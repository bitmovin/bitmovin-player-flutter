import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("pre_release_checks.sh")


class PreReleaseChecksTests(unittest.TestCase):
    def run_checks(self, fail=""):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in ("scripts", "example", "player_testing", "android", "bin"):
                (root / name).mkdir()
            shutil.copy(SCRIPT, root / "scripts/pre_release_checks.sh")
            (root / "android/build.gradle").write_text("")
            (root / "scripts/ios_sdk_version.py").write_text("print('3.124.0')\n")
            (root / "scripts/link_sdk_versions.py").write_text("")
            tool = root / "bin/fvm"
            tool.write_text('#!/bin/sh\nprintf "%s:%s\\n" "${PWD##*/}" "$*" >> "$COMMAND_LOG"\ncase "$*" in *"$FAIL_COMMAND"*) if [ -n "$FAIL_COMMAND" ]; then exit 1; fi;; esac\n')
            tool.chmod(0o755)
            env = dict(os.environ, PATH=str(root / "bin") + os.pathsep + os.environ["PATH"], COMMAND_LOG=str(root / "commands"), FAIL_COMMAND=fail)
            result = subprocess.run(["sh", "scripts/pre_release_checks.sh", "--apply-upgrades", "--skip-ios-build"], cwd=root, env=env, capture_output=True, text=True)
            return result, (root / "commands").read_text().splitlines()

    def test_validation_runs_after_all_upgrades_and_codegen(self):
        result, commands = self.run_checks()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        upgrades = [i for i, command in enumerate(commands) if "pub upgrade" in command]
        self.assertEqual(len(upgrades), 3)
        checks = [i for i, command in enumerate(commands) if "pub outdated" in command or "pub publish" in command]
        self.assertTrue(all(i > max(upgrades) for i in checks), commands)
        generation = [i for i, command in enumerate(commands) if "build_runner build" in command]
        self.assertEqual(len(generation), 2, commands)
        self.assertTrue(all(max(upgrades) < i < min(checks) for i in generation), commands)

    def test_upgrade_or_generation_failure_blocks_candidate_validation(self):
        for fail in ("pub upgrade", "build_runner build"):
            with self.subTest(fail=fail):
                result, commands = self.run_checks(fail)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse(any("pub publish" in command for command in commands), commands)

    def test_post_upgrade_publish_failure_fails_preparation(self):
        result, _ = self.run_checks("pub publish")
        self.assertNotEqual(result.returncode, 0)


if __name__ == "__main__":
    unittest.main()
