import os
import re
import shutil
import subprocess
import tempfile
import textwrap
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


class ReleasePreparationTests(unittest.TestCase):
    def run_preparation(self, publish_failure=False):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory) / "candidate"
            root.mkdir()
            remote = Path(directory) / "remote.git"

            def git(*args):
                return subprocess.run(["git", *args], cwd=root, check=True, capture_output=True, text=True)

            git("init", "--initial-branch=release/test")
            git("config", "user.name", "Test")
            git("config", "user.email", "test@example.com")
            git("init", "--bare", str(remote))
            git("remote", "add", "origin", str(remote))
            for name in ("scripts", "example/ios", "player_testing", "android", "bin", "lib/src", "player_testing/lib"):
                (root / name).mkdir(parents=True, exist_ok=True)
            shutil.copy(ROOT / "scripts/pre_release_checks.sh", root / "scripts/pre_release_checks.sh")
            (root / "scripts/ios_sdk_version.py").write_text("print('3.124.0')\n")
            (root / "scripts/link_sdk_versions.py").write_text("")
            (root / "scripts/check_ios_spm.py").write_text("")
            (root / "android/build.gradle").write_text("")
            (root / "CHANGELOG.md").write_text("Before preparation\n")
            (root / "pubspec.yaml").write_text("version: 0.1.0\n")
            (root / ".gitignore").write_text("bin/\n")
            release_paths = ("example/pubspec.yaml", "example/pubspec.lock", "player_testing/pubspec.yaml", "example/ios/Podfile.lock", "lib/src/generated.dart", "player_testing/lib/generated.dart")
            for name in release_paths:
                (root / name).write_text("Initial contents\n")
            tool = textwrap.dedent("""\
                #!/bin/sh
                if [ "$1" = dart ]; then shift; fi
                if [ "$*" = 'pub publish --dry-run' ]; then
                  echo dry-run >> "$COMMAND_LOG"
                  git diff --quiet HEAD -- || exit 65
                  if [ "$PUBLISH_FAILURE" = true ]; then exit 65; fi
                fi
                if [ "$*" = 'pub upgrade --major-versions' ]; then
                  echo '# upgraded' >> pubspec.yaml
                fi
                exit 0
                """)
            for name in ("fvm", "dart"):
                executable = root / "bin" / name
                executable.write_text(tool)
                executable.chmod(0o755)
            git("add", "CHANGELOG.md", "pubspec.yaml", ".gitignore", "scripts", "android", *release_paths)
            git("commit", "--no-verify", "-m", "Initial candidate")
            (root / "CHANGELOG.md").write_text("Prepared release\n")
            (root / "pubspec.yaml").write_text("version: 0.2.0\n")

            workflow = (ROOT / ".github/workflows/start-release-train.yml").read_text()
            preparation = workflow.split("      - name: Upgrade dependencies", 1)[1].split("      - name: Open release approval PR", 1)[0]
            commands = []
            for match in re.finditer(r"^        run: (?P<inline>[^\n]+)\n(?P<block>(?:          [^\n]*\n|\n)*)", preparation, re.MULTILINE):
                commands.append(textwrap.dedent(match["block"]) if match["inline"] == "|" else match["inline"])
            self.assertTrue(commands, "No preparation commands found")
            log = Path(directory) / "commands"
            env = dict(os.environ, PATH=str(root / "bin") + os.pathsep + os.environ["PATH"], COMMAND_LOG=str(log), PUBLISH_FAILURE=str(publish_failure).lower(), RELEASE_VERSION="0.2.0", RELEASE_BRANCH="release/test")
            result = subprocess.run(["bash", "-e", "-o", "pipefail", "-c", "\n".join(commands)], cwd=root, env=env, capture_output=True, text=True)
            refs = git("--git-dir", str(remote), "for-each-ref", "--format=%(refname)").stdout
            published = "refs/heads/release/test" in refs
            if published:
                self.assertEqual(git("rev-parse", "HEAD").stdout, git("--git-dir", str(remote), "rev-parse", "refs/heads/release/test").stdout)
            return result, published, log.read_text().splitlines() if log.exists() else []

    def test_preparation_commits_candidate_before_dry_run_and_push(self):
        result, published, commands = self.run_preparation()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(commands, ["dry-run"])
        self.assertTrue(published)

    def test_publish_warning_prevents_branch_push(self):
        result, published, commands = self.run_preparation(publish_failure=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(commands, ["dry-run"])
        self.assertFalse(published)


if __name__ == "__main__":
    unittest.main()
