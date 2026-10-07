import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


HELPER = Path(__file__).with_name("ensure_unreleased_changelog.py")


class EnsureUnreleasedChangelogTests(unittest.TestCase):
    def run_helper(self, path, *, use_default=False):
        command = [sys.executable, str(HELPER)]
        if not use_default:
            command.append(str(path))
        result = subprocess.run(
            command, cwd=path.parent, capture_output=True, text=True
        )
        self.assertEqual(result.returncode, 0, result.stderr)

    def transform(self, content):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "CHANGELOG.md"
            path.write_bytes(content)
            self.run_helper(path)
            return path.read_bytes()

    def test_inserts_before_releases_without_changing_their_content(self):
        releases = (
            b"## [0.27.0] - 2026-10-07\n\n### Changed\n\n"
            b"- Keep [links](https://example.com) and trailing spaces.  \n\n"
            b"## [0.26.0] - 2026-05-04\n\n### Fixed\n\n- Older entry"
        )
        prefix = b"# Changelog\nAll notable changes.\n\n\n"

        self.assertEqual(
            self.transform(prefix + releases),
            prefix + b"## [Unreleased]\n\n" + releases,
        )

    def test_existing_top_section_and_entries_are_unchanged(self):
        content = (
            b"# Changelog\n\n## [Unreleased]\n\n### Fixed\n\n"
            b"- Pending fix\n\n## [0.27.0] - 2026-10-07\n- Released fix\n"
        )

        self.assertEqual(self.transform(content), content)

    def test_crlf_is_preserved_when_inserting(self):
        content = b"# Changelog\r\n\r\n## [0.27.0] - 2026-10-07\r\n- Fix\r\n"

        self.assertEqual(
            self.transform(content),
            content.replace(b"## [0.27.0]", b"## [Unreleased]\r\n\r\n## [0.27.0]"),
        )

    def test_existing_crlf_section_is_unchanged(self):
        content = b"# Changelog\r\n\r\n## [Unreleased]\r\n\r\n## [0.27.0]\r\n"

        self.assertEqual(self.transform(content), content)

    def test_repeated_default_invocation_does_not_rewrite_file(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "CHANGELOG.md"
            path.write_bytes(b"# Changelog\n\n## [0.27.0]\n- Fix\n")
            self.run_helper(path, use_default=True)
            expected = path.read_bytes()
            os.utime(path, ns=(1_000_000_000, 1_000_000_000))
            modified = path.stat().st_mtime_ns

            self.run_helper(path, use_default=True)

            self.assertEqual(path.read_bytes(), expected)
            self.assertEqual(path.stat().st_mtime_ns, modified)
            self.assertEqual(expected.count(b"## [Unreleased]"), 1)

    def test_moves_misplaced_unreleased_section_above_unchanged_releases(self):
        prefix = b"# Changelog\n\n"
        first = b"## [0.27.0] - 2026-10-07\n\n- First release\n\n"
        pending = b"## [Unreleased]\n\n### Added\n\n- Pending feature\n\n"
        last = b"## [0.26.0] - 2026-05-04\n\n- Previous release\n"

        self.assertEqual(
            self.transform(prefix + first + pending + last),
            prefix + pending + first + last,
        )

    def test_duplicate_unreleased_sections_keep_all_entries_under_one_header(self):
        prefix = b"# Changelog\n\n"
        first_body = b"\n### Added\n\n- Pending feature\n\n"
        second_body = b"\n### Fixed\n\n- Pending fix\n\n"
        release = b"## [0.27.0] - 2026-10-07\n\n- Released feature\n\n"
        content = (
            prefix + b"## [Unreleased]\n" + first_body + release
            + b"## [Unreleased]\n" + second_body
        )

        self.assertEqual(
            self.transform(content),
            prefix + b"## [Unreleased]\n" + first_body + second_body + release,
        )

    def test_removes_release_date_from_unreleased_header_only(self):
        content = b"# Changelog\n\n## [Unreleased] - 2026-10-07\n\n- Pending fix\n"

        self.assertEqual(
            self.transform(content),
            content.replace(b"## [Unreleased] - 2026-10-07", b"## [Unreleased]"),
        )

    def test_title_only_changelog_gets_unreleased_section(self):
        self.assertEqual(
            self.transform(b"# Changelog\n"),
            b"# Changelog\n\n## [Unreleased]\n\n",
        )

    def test_empty_changelog_gets_title_and_unreleased_section(self):
        self.assertEqual(
            self.transform(b""), b"# Changelog\n\n## [Unreleased]\n\n"
        )


if __name__ == "__main__":
    unittest.main()
