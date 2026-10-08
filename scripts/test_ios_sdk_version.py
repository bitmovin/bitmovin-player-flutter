import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("ios_sdk_version.py")
DEPENDENCY = '.package(url: "https://github.com/bitmovin/player-ios.git", exact: "3.124.0")'


class IosSdkVersionTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        root = Path(self.directory.name)
        (root / "scripts").mkdir()
        self.script = root / "scripts" / SCRIPT.name
        shutil.copyfile(SCRIPT, self.script)
        self.manifest = root / "ios/bitmovin_player/Package.swift"
        self.manifest.parent.mkdir(parents=True)
        self.content = "// Swift package\nlet dependencies = [\n    " + DEPENDENCY + ",\n]\n"
        self.manifest.write_text(self.content)

    def run_script(self, *args):
        return subprocess.run([sys.executable, str(self.script), *args], capture_output=True, text=True)

    def test_reads_pinned_version_without_writing(self):
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "3.124.0\n")
        self.assertEqual(self.manifest.read_text(), self.content)

    def test_updates_only_pinned_version_including_prerelease(self):
        result = self.run_script("3.125.0-beta.1")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.manifest.read_text(), self.content.replace("3.124.0", "3.125.0-beta.1"))

    def test_rejects_invalid_versions_and_extra_arguments_without_writing(self):
        for args in (("latest",), ("3.125",), ("3.125.0", "extra")):
            with self.subTest(args=args):
                result = self.run_script(*args)
                self.assertEqual(result.returncode, 1)
                self.assertIn("Usage:", result.stderr)
                self.assertEqual(self.manifest.read_text(), self.content)

    def test_rejects_missing_or_duplicate_dependency_without_writing(self):
        for content in ("let dependencies = []\n", self.content + DEPENDENCY + "\n"):
            with self.subTest(content=content):
                self.manifest.write_text(content)
                result = self.run_script("3.125.0")
                self.assertEqual(result.returncode, 1)
                self.assertIn("exactly one", result.stderr)
                self.assertEqual(self.manifest.read_text(), content)


if __name__ == "__main__":
    unittest.main()
