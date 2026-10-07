import importlib.util
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("link_sdk_versions.py")
spec = importlib.util.spec_from_file_location("link_sdk_versions", SCRIPT)
links = importlib.util.module_from_spec(spec)
spec.loader.exec_module(links)


class LinkSdkVersionsTests(unittest.TestCase):
    def run_script(self, content, *options):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "CHANGELOG.md"
            path.write_bytes(content.encode())
            result = subprocess.run(
                [sys.executable, str(SCRIPT), *options, str(path)],
                capture_output=True, text=True,
            )
            return result, path.read_bytes().decode()

    def test_links_platform_versions_and_build_metadata(self):
        for platform, version, anchor, url in (
            ("iOS", "3.124.0", "#31240", links.IOS_URL),
            ("Android", "3.166.0+jason", "#31660", links.ANDROID_URL),
        ):
            with self.subTest(platform=platform):
                line = f"- Update Bitmovin's native {platform} SDK version to `{version}`\n"
                self.assertEqual(
                    links.transform_line(line),
                    line.replace(f"`{version}`", f"[`{version}`]({url}{anchor})"),
                )

    def test_links_prerelease_to_base_version_anchor(self):
        line = "- Update Bitmovin iOS SDK to `3.125.0-beta.1+build.2`\n"
        self.assertIn(
            f"[`3.125.0-beta.1+build.2`]({links.IOS_URL}#31250)",
            links.transform_line(line),
        )

    def test_preserves_existing_links_and_unrelated_content(self):
        lines = (
            f"- Update Bitmovin iOS to [`3.124.0`]({links.IOS_URL}#31240)\n",
            "- Update Kotlin version to `2.2.21`\n",
            "- Update Android version to `3.166.0`\n",
            "- Update Bitmovin Web to `8.0.0`\n",
        )
        for line in lines:
            with self.subTest(line=line):
                self.assertEqual(links.transform_line(line), line)

    def test_links_missing_version_on_partially_linked_line(self):
        line = (
            f"- Bitmovin iOS [`3.124.0`]({links.IOS_URL}#31240) "
            "and Android `3.166.0`\n"
        )
        expected = line.replace("`3.166.0`", f"[`3.166.0`]({links.ANDROID_URL}#31660)")
        self.assertEqual(links.transform_line(line), expected)
        self.assertEqual(links.transform_line(expected), expected)

    def test_preserves_non_sdk_suffix_versions(self):
        sdk = f"[`3.124.0`]({links.IOS_URL}#31240)"
        suffix = ", requiring Flutter `3.44.0` and Kotlin `2.2.21` or later.\n"
        for citation in ("`3.124.0`", sdk):
            with self.subTest(citation=citation):
                line = "- Update Bitmovin's native iOS SDK version to " + citation + suffix
                expected = "- Update Bitmovin's native iOS SDK version to " + sdk + suffix
                self.assertEqual(links.transform_line(line), expected)
                result, after = self.run_script(expected, "--check")
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(after, expected)

    def test_check_missing_link_fails_without_writing(self):
        content = "# Changelog\r\n- Update Bitmovin Android SDK to `3.166.0+jason`\r\n"
        result, after = self.run_script(content, "--check")
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertIn("release-notes-android#31660", result.stdout)
        self.assertEqual(after, content)

    def test_check_linked_file_passes_without_writing(self):
        content = f"- Bitmovin iOS [`3.124.0`]({links.IOS_URL}#31240)\r\n"
        result, after = self.run_script(content, "--check")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(after, content)

    def test_dry_run_shows_diff_without_writing(self):
        content = "- Bitmovin iOS `3.124.0`\n"
        result, after = self.run_script(content, "--dry-run")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("release-notes-ios#31240", result.stdout)
        self.assertEqual(after, content)

    def test_default_mode_writes_links_and_second_run_is_unchanged(self):
        result, linked = self.run_script("- Bitmovin iOS `3.124.0`\n")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("release-notes-ios#31240", linked)
        result, after = self.run_script(linked)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("No changes needed", result.stdout)
        self.assertEqual(after, linked)

    def test_missing_file_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--check", str(Path(directory) / "missing.md")],
                capture_output=True, text=True,
            )
        self.assertEqual(result.returncode, 1)
        self.assertIn("not found", result.stderr)


if __name__ == "__main__":
    unittest.main()
