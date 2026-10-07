"""Exercise SDK update safety with real git and a fake GitHub boundary."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import textwrap
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / "sdk_update_pr.py"
REPO = "bitmovin-engineering/bitmovin-player-flutter"


class UpdateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        root = Path(self.temp.name)
        self.remote = root / "remote.git"
        self.work = root / "work"
        self.work.mkdir()
        self.git("init", "--bare", str(self.remote), cwd=root)
        self.git("init", "-b", "main")
        self.git("config", "user.name", "Update Bot")
        self.git("config", "user.email", "update-bot@bitmovin.com")
        for name in ["android/build.gradle", "CHANGELOG.md", "human.txt"]:
            path = self.work / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("initial\n")
        self.git("add", "android/build.gradle", "CHANGELOG.md", "human.txt")
        self.git("commit", "--no-verify", "-m", "Initial base")
        self.git("remote", "add", "origin", str(self.remote))
        self.git("push", "origin", "main")
        self.state = root / "gh-state.json"
        self.calls = root / "gh-calls.jsonl"
        self.state.write_text("[]")
        fake = root / "gh"
        fake.write_text('''#!/usr/bin/env python3
import json, os, subprocess, sys
from pathlib import Path
args = sys.argv[1:]
state = Path(os.environ["GH_TEST_STATE"])
with open(os.environ["GH_TEST_CALLS"], "a") as log:
    log.write(json.dumps(args) + "\\n")
if os.environ.get("GH_TEST_FAIL") == " ".join(args[:2]):
    sys.exit(7)
prs = json.loads(state.read_text())
if args[0] == "api":
    print(json.dumps([prs]))
elif args[:2] == ["pr", "create"]:
    def arg(name): return args[args.index(name) + 1]
    repo = arg("--repo")
    sha = subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip()
    prs.append({"number": 100, "state": "open", "head": {"ref": arg("--head"), "sha": sha, "repo": {"full_name": repo}}, "base": {"ref": arg("--base"), "repo": {"full_name": repo}}})
    if not os.environ.get("GH_TEST_NO_CREATE"):
        state.write_text(json.dumps(prs))
    print("https://github.com/" + repo + "/pull/100")
elif args[:2] == ["pr", "edit"]:
    pr = next(pr for pr in prs if pr["number"] == int(args[2]))
    pr["title"] = args[args.index("--title") + 1]
    pr["body"] = args[args.index("--body") + 1]
    state.write_text(json.dumps(prs))
''')
        fake.chmod(0o755)
        self.env = dict(os.environ, PATH=f"{root}:{os.environ['PATH']}",
                        GH_TEST_STATE=str(self.state), GH_TEST_CALLS=str(self.calls))

    def git(self, *args, cwd=None):
        return subprocess.run(["git", *args], cwd=cwd or self.work, text=True,
                              capture_output=True, check=True).stdout.strip()

    def run_helper(self, phase, version="3.100.0", platform="android", base="main"):
        return subprocess.run([sys.executable, str(SCRIPT), phase, platform, version, base, REPO],
                              cwd=self.work, env=self.env, text=True, capture_output=True)

    def assert_success(self, result):
        self.assertEqual(result.returncode, 0, result.stderr)

    def branch(self, version="3.100.0", platform="android"):
        return f"update_{platform}_player_to_{version}"

    def remote_update(self, subject=None, author="update-bot@bitmovin.com", path="android/build.gradle",
                      version="3.100.0", platform="android"):
        branch = self.branch(version, platform)
        self.git("checkout", "-b", branch)
        (self.work / path).write_text("updated\n")
        self.git("add", path)
        self.git("-c", f"user.email={author}", "commit", "--no-verify", "-m",
                 subject or f"Update {'iOS' if platform == 'ios' else 'Android'} player SDK to {version}")
        self.git("push", "origin", branch)
        sha = self.git("rev-parse", "HEAD")
        self.git("checkout", "main")
        self.git("branch", "-D", branch)
        return sha

    def pr(self, number, version, platform="android", base="main", repo=REPO):
        remote = self.git("ls-remote", "origin", f"refs/heads/{self.branch(version, platform)}")
        return {"number": number, "state": "open",
                "head": {"ref": self.branch(version, platform), "sha": remote.split()[0] if remote else None,
                         "repo": {"full_name": repo}},
                "base": {"ref": base, "repo": {"full_name": REPO}}}

    def set_prs(self, prs):
        self.state.write_text(json.dumps(prs))

    def gh_calls(self):
        return [json.loads(line) for line in self.calls.read_text().splitlines()]

    def test_creates_branch_without_deleting_remote(self):
        self.assert_success(self.run_helper("prepare"))
        self.assertEqual(self.git("branch", "--show-current"), self.branch())

    def test_frozen_changelog_helper_runs_when_reused_branch_lacks_helpers(self):
        repository_root = SCRIPT.parents[2]
        for name in (
            ".github/scripts/sdk_update_pr.py",
            ".github/scripts/update_player_sdk_update_changelog.py",
            "scripts/link_sdk_versions.py",
        ):
            destination = self.work / name
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(repository_root / name, destination)
        runner_temp = Path(self.temp.name) / "runner-temp"
        runner_temp.mkdir()
        workflow = (repository_root / ".github/workflows/create-sdk-update-pr.yml").read_text()
        step = workflow.split("      - name: Prepare safe update branch\n", 1)[1]
        step = step.split("\n      - uses:", 1)[0]
        script = runner_temp / "prepare.sh"
        script.write_text("set -eu\n" + textwrap.dedent(step.split("run: |\n", 1)[1]))
        env = dict(self.env, RUNNER_TEMP=str(runner_temp), SDK_PLATFORM="android",
                   SDK_VERSION="3.100.0", SDK_BASE="main", SDK_REPOSITORY=REPO)
        result = subprocess.run(["bash", str(script)], cwd=self.work, env=env,
                                text=True, capture_output=True)
        self.assert_success(result)
        # An older branch can lack all of the helper sources kept by the workflow.
        shutil.rmtree(self.work / ".github")
        shutil.rmtree(self.work / "scripts")
        result = subprocess.run(
            [sys.executable, str(runner_temp / "update_player_sdk_update_changelog.py"),
             "3.100.0", "android"], cwd=self.work, env=env, text=True, capture_output=True,
        )
        self.assert_success(result)
        self.assertIn("release-notes-android#31000", (self.work / "CHANGELOG.md").read_text())

    def test_reuses_automation_commit_without_rewriting(self):
        sha = self.remote_update()
        self.assert_success(self.run_helper("prepare"))
        self.assertEqual(self.git("rev-parse", "HEAD"), sha)

    def test_reuses_legacy_automation_commit(self):
        sha = self.remote_update(subject="chore(android): update android player version to 3.100.0")
        self.assert_success(self.run_helper("prepare"))
        self.assertEqual(self.git("rev-parse", "HEAD"), sha)

    def test_reused_pr_preserves_human_title_and_body(self):
        self.remote_update()
        pr = dict(self.pr(42, "3.100.0"), title="SDK update with customer regression fix",
                  body="Issue #123. Manually validated playback on two devices.")
        self.set_prs([pr])
        self.assert_success(self.run_helper("prepare"))
        self.assert_success(self.run_helper("finish"))
        updated = json.loads(self.state.read_text())[0]
        self.assertEqual(updated["title"], pr["title"])
        self.assertEqual(updated["body"], pr["body"])

    def assert_refuses_commit(self, **kwargs):
        sha = self.remote_update(**kwargs)
        result = self.run_helper("prepare")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("non-automation", result.stderr)
        self.assertEqual(self.git("ls-remote", "origin", f"refs/heads/{self.branch()}").split()[0], sha)

    def test_refuses_human_author(self):
        self.assert_refuses_commit(author="human@example.com")

    def test_refuses_unexpected_file(self):
        self.assert_refuses_commit(path="human.txt")

    def test_refuses_unexpected_subject(self):
        self.assert_refuses_commit(subject="Human fix")

    def test_refuses_same_branch_pr_for_other_base(self):
        self.set_prs([self.pr(1, "3.100.0", base="release")])
        result = self.run_helper("prepare")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("other base", result.stderr)

    def test_rejects_untrusted_or_invalid_semver_before_git_or_gh(self):
        for version in ["$(touch bad)", "3.01.0", "3.1.0-01", "3.1.0+", "3.1.0\nmalicious", "3.1.0-a..b"]:
            with self.subTest(version=version):
                result = self.run_helper("prepare", version)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("Invalid SemVer", result.stderr)
        self.assertFalse(self.calls.exists())

    def test_refuses_api_and_fetch_errors(self):
        self.env["GH_TEST_FAIL"] = "api --paginate"
        result = self.run_helper("prepare")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("failed", result.stderr)
        self.env.pop("GH_TEST_FAIL")
        self.git("remote", "set-url", "origin", str(self.work / "missing.git"))
        result = self.run_helper("prepare")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("failed", result.stderr)

    def test_repeat_finish_reuses_pr_and_preserves_commit(self):
        self.assert_success(self.run_helper("prepare"))
        (self.work / "android/build.gradle").write_text("update\n")
        self.assert_success(self.run_helper("finish"))
        sha = self.git("rev-parse", "HEAD")
        self.git("checkout", "main")
        self.git("branch", "-D", self.branch())
        self.assert_success(self.run_helper("prepare"))
        self.assert_success(self.run_helper("finish"))
        self.assertEqual(self.git("rev-parse", "HEAD"), sha)
        calls = self.gh_calls()
        self.assertEqual(sum(call[:2] == ["pr", "create"] for call in calls), 1)
        self.assertEqual(sum(call[:2] == ["pr", "edit"] for call in calls), 0)

    def test_closes_only_strictly_older_matching_prs_after_replacement(self):
        self.remote_update(version="3.99.0+jason")
        self.remote_update(version="3.100.0-beta.10")
        self.assert_success(self.run_helper("prepare"))
        prs = [self.pr(1, "3.99.0+jason"), self.pr(2, "3.100.0+build"),
               self.pr(3, "3.101.0"), self.pr(4, "3.99.0", platform="ios"),
               self.pr(5, "3.99.0", base="release"), self.pr(6, "3.99.0", repo="someone/fork"),
               self.pr(7, "3.100.0-beta.10"), self.pr(8, "3.99.0-not..valid")]
        self.set_prs(prs)
        (self.work / "android/build.gradle").write_text("update\n")
        self.assert_success(self.run_helper("finish"))
        calls = self.gh_calls()
        close = [call for call in calls if call[:2] == ["pr", "close"]]
        self.assertEqual([call[2] for call in close], ["1", "7"])
        self.assertTrue(all("--delete-branch" not in call for call in close))
        create_index = next(i for i, call in enumerate(calls) if call[:2] == ["pr", "create"])
        self.assertTrue(all(i > create_index for i, call in enumerate(calls) if call[:2] == ["pr", "close"]))

    def test_failed_replacement_does_not_close_prs(self):
        self.assert_success(self.run_helper("prepare"))
        self.set_prs([self.pr(1, "3.99.0")])
        self.env["GH_TEST_FAIL"] = "pr create"
        (self.work / "android/build.gradle").write_text("update\n")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(any(call[:2] == ["pr", "close"] for call in self.gh_calls()))

    def test_prerelease_order_and_build_metadata(self):
        self.remote_update(version="3.100.0-beta.2")
        self.assert_success(self.run_helper("prepare", "3.100.0-beta.10+jason"))
        self.set_prs([self.pr(1, "3.100.0-beta.2"), self.pr(2, "3.100.0-beta.10+other"),
                      self.pr(3, "3.100.0-beta.11"), self.pr(4, "3.100.0")])
        (self.work / "android/build.gradle").write_text("update\n")
        self.assert_success(self.run_helper("finish", "3.100.0-beta.10+jason"))
        self.assertEqual([call[2] for call in self.gh_calls() if call[:2] == ["pr", "close"]], ["1"])

    def test_concurrent_human_push_is_preserved_and_stops_pr_mutations(self):
        self.assert_success(self.run_helper("prepare"))
        (self.work / "android/build.gradle").write_text("update\n")
        self.assert_success(self.run_helper("finish"))
        peer = self.work.parent / "peer"
        self.git("clone", "--branch", self.branch(), str(self.remote), str(peer))
        (peer / "android/build.gradle").write_text("human update\n")
        self.git("add", "android/build.gradle", cwd=peer)
        self.git("-c", "user.name=Human", "-c", "user.email=human@example.com", "commit",
                 "--no-verify", "-m", "Human change", cwd=peer)
        self.git("push", "origin", self.branch(), cwd=peer)
        human_sha = self.git("rev-parse", "HEAD", cwd=peer)
        before = len(self.gh_calls())
        (self.work / "android/build.gradle").write_text("bot refresh\n")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("failed", result.stderr)
        self.assertEqual(self.git("ls-remote", "origin", f"refs/heads/{self.branch()}").split()[0], human_sha)
        self.assertFalse(any(call[0] == "pr" for call in self.gh_calls()[before:]))

    def test_successful_create_without_replacement_cannot_close_older_pr(self):
        self.assert_success(self.run_helper("prepare"))
        self.set_prs([self.pr(1, "3.99.0")])
        self.env["GH_TEST_NO_CREATE"] = "1"
        (self.work / "android/build.gradle").write_text("update\n")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Replacement PR", result.stderr)
        self.assertFalse(any(call[:2] == ["pr", "close"] for call in self.gh_calls()))

    def test_cleanup_failure_is_reported(self):
        self.remote_update(version="3.99.0")
        self.assert_success(self.run_helper("prepare"))
        self.set_prs([self.pr(1, "3.99.0")])
        self.env["GH_TEST_FAIL"] = "pr close"
        (self.work / "android/build.gradle").write_text("update\n")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("failed", result.stderr)

    def test_cleanup_preserves_older_pr_with_human_commits(self):
        self.remote_update(version="3.99.0", author="human@example.com", subject="Customer regression fix")
        self.assert_success(self.run_helper("prepare"))
        self.set_prs([self.pr(1, "3.99.0")])
        (self.work / "android/build.gradle").write_text("update\n")
        self.assert_success(self.run_helper("finish"))
        self.assertFalse(any(call[:2] == ["pr", "close"] for call in self.gh_calls()))

    def test_malformed_api_payload_fails_before_branch_creation(self):
        self.set_prs([{"message": "API failure"}])
        result = self.run_helper("prepare")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Invalid", result.stderr)
        self.assertEqual(self.git("branch", "--show-current"), "main")

    def test_refuses_unexpected_staged_changes(self):
        self.assert_success(self.run_helper("prepare"))
        (self.work / "human.txt").write_text("human change\n")
        self.git("add", "human.txt")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Unexpected tracked changes", result.stderr)

    def test_refuses_renaming_allowed_files_to_untracked_destinations(self):
        self.assert_success(self.run_helper("prepare"))
        self.git("mv", "android/build.gradle", "android/human.gradle")
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Unexpected tracked changes", result.stderr)

    def test_refuses_deleted_version_manifest_without_publishing(self):
        self.assert_success(self.run_helper("prepare"))
        (self.work / "android/build.gradle").unlink()
        result = self.run_helper("finish")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("deleted", result.stderr)
        self.assertFalse(any(call[0] == "pr" for call in self.gh_calls()))


if __name__ == "__main__":
    unittest.main()
