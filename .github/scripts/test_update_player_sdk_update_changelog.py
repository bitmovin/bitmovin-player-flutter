import importlib.util
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("update_player_sdk_update_changelog.py")
spec = importlib.util.spec_from_file_location("sdk_changelog", SCRIPT)
changelog = importlib.util.module_from_spec(spec)
spec.loader.exec_module(changelog)
IOS_URL = "https://developer.bitmovin.com/playback/docs/release-notes-ios"
ANDROID_URL = "https://developer.bitmovin.com/playback/docs/release-notes-android"
HISTORY = "\n## [0.26.0] - 2026-05-04\n\n### Changed\n\n- Historical entry.\n\n\n\n[0.26.0]: https://example.com/releases\n"


class UpdateSdkChangelogTests(unittest.TestCase):
    def test_replaces_linked_entry_preserving_suffix_and_history(self):
        content = (
            "# Changelog\n\n## [Unreleased]\n\n### Changed\n\n"
            f"- Update Bitmovin's native iOS SDK version to [`3.124.0`]({IOS_URL}#31240), requiring iOS 15 or later.\n"
            "- Another change.\n" + HISTORY
        )
        updated = changelog.update_unreleased_changed_section(content, "ios", "3.125.0")
        self.assertEqual(updated.count("Update Bitmovin's native iOS"), 1)
        self.assertIn(f"[`3.125.0`]({IOS_URL}#31250), requiring iOS 15 or later.", updated)
        self.assertTrue(updated.endswith(HISTORY))
        self.assertEqual(changelog.update_unreleased_changed_section(updated, "ios", "3.125.0"), updated)

    def test_replaces_unlinked_entry_with_link(self):
        content = "# Changelog\n\n## [Unreleased]\n\n### Changed\n\n- Update Bitmovin's native Android SDK version to `3.166.0+jason`\n" + HISTORY
        updated = changelog.update_unreleased_changed_section(content, "android", "3.167.0+jason")
        self.assertEqual(updated.count("Update Bitmovin's native Android"), 1)
        self.assertIn(f"[`3.167.0+jason`]({ANDROID_URL}#31670)", updated)
        self.assertTrue(updated.endswith(HISTORY))

    def test_inserts_linked_entry_without_changing_other_platform(self):
        other_entry = f"- Update Bitmovin's native iOS SDK version to [`3.124.0`]({IOS_URL}#31240)\n"
        content = "# Changelog\n\n## [Unreleased]\n\n### Changed\n\n- Existing change.\n" + other_entry + HISTORY
        updated = changelog.update_unreleased_changed_section(content, "android", "3.167.0-beta.1+build")
        self.assertIn(f"[`3.167.0-beta.1+build`]({ANDROID_URL})\n- Existing change.", updated)
        self.assertIn(other_entry, updated)
        self.assertTrue(updated.endswith(HISTORY))
        self.assertEqual(changelog.update_unreleased_changed_section(updated, "android", "3.167.0-beta.1+build"), updated)

    def test_creates_missing_sections(self):
        for content in (
            "# Changelog\n\n## [Unreleased]\n\n### Added\n\n- A feature.\n" + HISTORY,
            "# Changelog\n" + HISTORY,
            HISTORY,
        ):
            with self.subTest(content=content):
                updated = changelog.update_unreleased_changed_section(content, "ios", "3.125.0")
                self.assertIn("## [Unreleased]", updated)
                self.assertIn("### Changed", updated)
                self.assertIn(f"[`3.125.0`]({IOS_URL}#31250)", updated)
                self.assertTrue(updated.endswith(HISTORY))

    def test_cli_preserves_historical_spacing(self):
        content = "# Changelog\n\n## [Unreleased]\n\n### Changed\n\n- Existing change.\n" + HISTORY
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "CHANGELOG.md"
            path.write_text(content)
            result = subprocess.run([sys.executable, str(SCRIPT), "3.125.0", "ios"], cwd=directory, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertTrue(path.read_text().endswith(HISTORY))

    def test_invalid_inputs_fail_without_writing(self):
        for args in (("invalid", "ios"), ("3.125.0", "web"), ("3.125.0",)):
            with self.subTest(args=args), tempfile.TemporaryDirectory() as directory:
                path = Path(directory) / "CHANGELOG.md"
                path.write_text("untouched\n")
                result = subprocess.run([sys.executable, str(SCRIPT), *args], cwd=directory, capture_output=True, text=True)
                self.assertEqual(result.returncode, 1)
                self.assertEqual(path.read_text(), "untouched\n")

    def test_missing_changelog_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            result = subprocess.run([sys.executable, str(SCRIPT), "3.125.0", "ios"], cwd=directory, capture_output=True, text=True)
        self.assertEqual(result.returncode, 1)
        self.assertIn("not found", result.stdout)


if __name__ == "__main__":
    unittest.main()
