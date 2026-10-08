import importlib.util
import json
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


HELPER = Path(__file__).with_name("release_train.py")
PENDING = "# Changelog\n\n## [Unreleased]\n\n### Changed\n\n- A reviewed change\n\n## [0.26.0] - 2026-05-04\n\n- Old notes\n"


def event(**changes):
    pr = {
        "merged": True, "base": {"ref": "main", "repo": {"full_name": "bitmovin/bitmovin-player-flutter"}},
        "head": {"ref": "release/0.27.0", "repo": {"full_name": "bitmovin/bitmovin-player-flutter"}},
        "merge_commit_sha": "a" * 40,
    }
    pr.update(changes)
    return {"action": "closed", "pull_request": pr}


class ReleaseTrainTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue(HELPER.exists(), "Release train validation helper is missing")
        spec = importlib.util.spec_from_file_location("release_train", HELPER)
        self.release = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.release)

    def prepared(self):
        return self.release.prepare_changelog(PENDING, "0.27.0", "2026-10-08")

    def test_prepare_preserves_notes_and_restores_empty_unreleased(self):
        result = self.prepared()
        self.assertEqual(result, PENDING.replace("## [Unreleased]", "## [Unreleased]\n\n## [0.27.0] - 2026-10-08"))

    def test_prepare_rejects_empty_headings_and_comments(self):
        for body in ("", "\n### Fixed\n\n", "\n<!-- later -->\n\n### Changed\n",
                     "\n-\n*\n+\n", "\n---\n***\n___\n", "\n[compare]: https://example.com/compare\n"):
            with self.subTest(body=body), self.assertRaises(ValueError):
                self.release.prepare_changelog("# Changelog\n\n## [Unreleased]\n" + body, "0.27.0", "2026-10-08")

    def test_changelog_content_accepts_real_bullets_and_prose(self):
        for body in ("- Fix playback", "* **Fix playback**", "This release fixes playback."):
            with self.subTest(body=body):
                self.assertTrue(self.release.has_changes(body))

    def test_finish_rejects_release_notes_containing_only_markdown_syntax(self):
        content = self.prepared().replace("- A reviewed change", "---\n[compare]: https://example.com/compare")
        with self.assertRaises(ValueError):
            self.release.validate_merge(event(), "bitmovin/bitmovin-player-flutter", "a" * 40, "version: 0.27.0\n", content)

    def test_prepare_rejects_duplicate_or_misplaced_sections(self):
        for content in (PENDING + "\n## [Unreleased]\n- Another\n", PENDING.replace("Unreleased", "0.27.0")):
            with self.subTest(content=content), self.assertRaises(ValueError):
                self.release.prepare_changelog(content, "0.27.0", "2026-10-08")

    def test_prepare_preserves_crlf(self):
        result = self.release.prepare_changelog(PENDING.replace("\n", "\r\n"), "0.27.0", "2026-10-08")
        self.assertNotIn("\n", result.replace("\r\n", ""))

    def test_package_version_accepts_crlf(self):
        try:
            result = self.release.package_version("name: bitmovin_player\r\nversion: 0.26.0\r\n")
        except ValueError as error:
            self.fail(f"Valid CRLF pubspec was rejected: {error}")
        self.assertEqual(result, "0.26.0")

    def test_start_allows_completed_old_branches_but_not_untagged_merges(self):
        prs = [{"headRefName": "release/0.26.0", "state": "MERGED"}]
        refs = ["refs/heads/release/0.26.0", "refs/tags/0.26.0"]
        self.assertTrue(self.release.start_state("0.27.0", prs, refs))
        with self.assertRaises(ValueError):
            self.release.start_state("0.27.0", prs, refs[:1])

    def test_version_must_be_stable_and_increasing(self):
        for version in ("0.26.0", "0.25.0", "00.27.0", "0.27.0-rc.1", "0.27.0\nmalicious", "$(false)"):
            with self.subTest(version=version), self.assertRaises(ValueError):
                self.release.validate_version(version, "0.26.0")
        self.release.validate_version("0.27.0", "0.26.0")

    def test_start_refuses_other_open_release_or_orphan_branch(self):
        for prs, refs in (([{"headRefName": "release/0.28.0", "url": "url", "state": "OPEN"}], []),
                          ([], ["refs/heads/release/0.27.0"]), ([], ["refs/tags/0.27.0"])):
            with self.subTest(prs=prs, refs=refs), self.assertRaises(ValueError):
                self.release.start_state("0.27.0", prs, refs)

    def test_start_rerun_keeps_existing_pr_and_human_edits(self):
        self.assertFalse(self.release.start_state("0.27.0", [{"headRefName": "release/0.27.0", "url": "url", "state": "OPEN"}], ["refs/heads/release/0.27.0"]))
        self.assertTrue(self.release.start_state("0.27.0", [], []))

    def test_fork_release_prs_do_not_block_or_impersonate_repository_releases(self):
        for branch, state in (("release/0.27.0", "OPEN"), ("release/0.28.0", "OPEN"),
                              ("release/0.27.0", "CLOSED"), ("release/0.27.0", "MERGED")):
            pr = {"headRefName": branch, "state": state, "url": "https://example.com/fork-pr", "isCrossRepository": True}
            with self.subTest(branch=branch, state=state):
                try:
                    prepare = self.release.start_state("0.27.0", [pr], [])
                except ValueError as error:
                    self.fail(f"A fork PR blocked the repository's release: {error}")
                self.assertTrue(prepare, "A fork PR impersonated the repository's release")

    def test_fork_pr_cannot_hide_an_existing_repository_release_pr(self):
        fork = {"headRefName": "release/0.27.0", "state": "OPEN", "url": "fork", "isCrossRepository": True}
        repository = {"headRefName": "release/0.27.0", "state": "OPEN", "url": "repository", "isCrossRepository": False}
        try:
            prepare = self.release.start_state("0.27.0", [fork, repository], ["refs/heads/release/0.27.0"])
        except ValueError as error:
            self.fail(f"A fork PR hid the existing repository PR: {error}")
        self.assertFalse(prepare)

    def test_start_does_not_reopen_closed_or_merged_release(self):
        for state in ("CLOSED", "MERGED"):
            with self.subTest(state=state), self.assertRaises(ValueError):
                self.release.start_state("0.27.0", [{"headRefName": "release/0.27.0", "state": state}], [])

    def test_finish_accepts_exact_merged_revision(self):
        self.assertEqual(self.release.validate_merge(event(), "bitmovin/bitmovin-player-flutter", "a" * 40, "version: 0.27.0\n", self.prepared()), "0.27.0")

    def test_finish_rejects_unmerged_wrong_base_fork_or_branch(self):
        for changes in ({"merged": False}, {"base": {"ref": "development"}},
                        {"head": {"ref": "release/0.27.0", "repo": {"full_name": "someone/fork"}}},
                        {"head": {"ref": "feature/release/0.27.0", "repo": {"full_name": "bitmovin/bitmovin-player-flutter"}}}):
            with self.subTest(changes=changes), self.assertRaises(ValueError):
                self.release.validate_merge(event(**changes), "bitmovin/bitmovin-player-flutter", "a" * 40, "version: 0.27.0\n", self.prepared())

    def test_finish_rejects_later_main_checkout_and_version_mismatch(self):
        for sha, spec in (("b" * 40, "version: 0.27.0\n"), ("a" * 40, "version: 0.28.0\n")):
            with self.subTest(sha=sha, spec=spec), self.assertRaises(ValueError):
                self.release.validate_merge(event(), "bitmovin/bitmovin-player-flutter", sha, spec, self.prepared())

    def test_finish_rejects_pending_changes_missing_date_or_wrong_release(self):
        for content in (self.prepared().replace("## [Unreleased]", "## [Unreleased]\n- Unreviewed change"),
                        self.prepared().replace(" - 2026-10-08", ""),
                        self.prepared().replace("[0.27.0]", "[0.28.0]"),
                        self.prepared().replace("2026-10-08", "2026-99-99")):
            with self.subTest(content=content), self.assertRaises(ValueError):
                self.release.validate_merge(event(), "bitmovin/bitmovin-player-flutter", "a" * 40, "version: 0.27.0\n", content)

    def test_tag_rerun_is_noop_but_conflict_fails(self):
        self.assertTrue(self.release.tag_needed("a" * 40, None))
        self.assertFalse(self.release.tag_needed("a" * 40, "a" * 40))
        with self.assertRaises(ValueError):
            self.release.tag_needed("a" * 40, "b" * 40)

    def test_prepare_cli_updates_package_and_changelog_together(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "pubspec.yaml").write_text("name: bitmovin_player\nversion: 0.26.0\ndependencies:\n")
            (root / "CHANGELOG.md").write_text(PENDING)
            result = subprocess.run([sys.executable, str(HELPER), "prepare", "0.27.0"], cwd=root, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("version: 0.27.0\n", (root / "pubspec.yaml").read_text())
            self.assertTrue((root / "CHANGELOG.md").read_text().startswith("# Changelog\n\n## [Unreleased]\n\n## [0.27.0] - "))

    def test_prepare_cli_failure_leaves_both_files_untouched(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            spec = "version: 0.26.0\n"
            content = "# Changelog\n\n## [Unreleased]\n\n### Fixed\n"
            (root / "pubspec.yaml").write_text(spec)
            (root / "CHANGELOG.md").write_text(content)
            result = subprocess.run([sys.executable, str(HELPER), "prepare", "0.27.0"], cwd=root, capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertEqual((root / "pubspec.yaml").read_text(), spec)
            self.assertEqual((root / "CHANGELOG.md").read_text(), content)

    def test_finish_cli_uses_local_git_commit_and_never_tags_or_pushes(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            def git(*args):
                return subprocess.check_output(["git", *args], cwd=root, text=True).strip()
            git("init", "-q")
            git("config", "user.name", "Test")
            git("config", "user.email", "test@example.com")
            (root / "pubspec.yaml").write_text("version: 0.27.0\n")
            (root / "CHANGELOG.md").write_text(self.prepared())
            git("add", "pubspec.yaml", "CHANGELOG.md")
            git("commit", "--no-verify", "-qm", "Reviewed release")
            sha = git("rev-parse", "HEAD")
            (root / "event.json").write_text(json.dumps(event(merge_commit_sha=sha)))
            env = dict(os.environ, GITHUB_EVENT_PATH=str(root / "event.json"), GITHUB_REPOSITORY="bitmovin/bitmovin-player-flutter", GITHUB_OUTPUT=str(root / "output"))
            result = subprocess.run([sys.executable, str(HELPER), "finish"], cwd=root, env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("version=0.27.0", (root / "output").read_text())
            self.assertEqual(git("tag"), "")
            git("tag", "-a", "0.27.0", "-m", "Approved release")
            (root / "output").unlink()
            result = subprocess.run([sys.executable, str(HELPER), "finish"], cwd=root, env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("create_tag=false", (root / "output").read_text())
            git("commit", "--no-verify", "--allow-empty", "-qm", "Later main change")
            (root / "output").unlink()
            result = subprocess.run([sys.executable, str(HELPER), "finish"], cwd=root, env=env, capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertFalse((root / "output").exists())

    def test_start_cli_checks_real_remote_refs_without_mutating_them(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            def git(*args):
                return subprocess.check_output(["git", *args], cwd=root, text=True).strip()
            git("init", "-q")
            git("config", "user.name", "Test")
            git("config", "user.email", "test@example.com")
            (root / "pubspec.yaml").write_text("version: 0.26.0\n")
            git("add", "pubspec.yaml")
            git("commit", "--no-verify", "-qm", "Base")
            subprocess.check_call(["git", "init", "--bare", "-q", str(root / "remote")])
            git("remote", "add", "origin", str(root / "remote"))
            (root / "bin").mkdir()
            gh = root / "bin/gh"
            gh.write_text('#!/bin/sh\ncat "$PR_FIXTURE"\n')
            gh.chmod(0o755)
            fixture = root / "prs.json"
            fixture.write_text("[]")
            env = dict(os.environ, PATH=str(root / "bin") + os.pathsep + os.environ["PATH"], PR_FIXTURE=str(fixture), GITHUB_REPOSITORY="bitmovin/bitmovin-player-flutter", GITHUB_OUTPUT=str(root / "output"))
            command = [sys.executable, str(HELPER), "check-start", "0.27.0"]
            result = subprocess.run(command, cwd=root, env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("prepare=true", (root / "output").read_text())
            git("push", "-q", "origin", "HEAD:refs/heads/release/0.27.0")
            before = git("ls-remote", "origin")
            (root / "output").unlink()
            result = subprocess.run(command, cwd=root, env=env, capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertFalse((root / "output").exists())
            fixture.write_text(json.dumps([{"headRefName": "release/0.27.0", "state": "OPEN", "url": "https://example.com/pr"}]))
            result = subprocess.run(command, cwd=root, env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("prepare=false", (root / "output").read_text())
            self.assertEqual(git("ls-remote", "origin"), before)


if __name__ == "__main__":
    unittest.main()
