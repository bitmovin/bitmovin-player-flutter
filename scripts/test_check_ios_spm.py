import json
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPTS = Path(__file__).parent
VERSION = "3.124.0"


class CheckIosSpmTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        root = Path(self.directory.name)
        (root / "scripts").mkdir()
        for name in ("check_ios_spm.py", "ios_sdk_version.py"):
            shutil.copyfile(SCRIPTS / name, root / "scripts" / name)
        self.script = root / "scripts/check_ios_spm.py"
        manifest = root / "ios/bitmovin_player/Package.swift"
        manifest.parent.mkdir(parents=True)
        manifest.write_text(f'.package(url: "https://github.com/bitmovin/player-ios.git", exact: "{VERSION}")\n')
        self.lockfile = root / "example/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved"
        self.lockfile.parent.mkdir(parents=True)
        self.podfile = root / "example/ios/Podfile.lock"
        self.pins = [
            {"identity": identity, "state": {"version": VERSION}}
            for identity in ("player-ios", "player-ios-core")
        ]
        self.write_pins(self.pins)

    def write_pins(self, pins):
        self.lockfile.write_text(json.dumps({"version": 3, "pins": pins}))

    def run_script(self):
        return subprocess.run([sys.executable, str(self.script)], capture_output=True, text=True)

    def test_accepts_both_exact_spm_pins_without_podfile(self):
        before = self.lockfile.read_bytes()
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(f"Verified Player {VERSION}", result.stdout)
        self.assertEqual(self.lockfile.read_bytes(), before)

    def test_accepts_unrelated_flutter_pods(self):
        self.podfile.write_text("PODS:\n  - Flutter (1.0.0)\n  - unrelated (2.0.0)\n")
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_rejects_missing_duplicate_or_mismatched_pins(self):
        for identity in ("player-ios", "player-ios-core"):
            matching = next(pin for pin in self.pins if pin["identity"] == identity)
            others = [pin for pin in self.pins if pin["identity"] != identity]
            for pins in (
                others,
                self.pins + [matching],
                others + [{"identity": identity, "state": {"version": "3.123.0"}}],
                others + [{"identity": identity, "state": {"revision": "abc"}}],
            ):
                with self.subTest(identity=identity, pins=pins):
                    self.write_pins(pins)
                    result = self.run_script()
                    self.assertEqual(result.returncode, 1)
                    self.assertIn(f"Expected {identity} {VERSION}", result.stderr)

    def test_rejects_bitmovin_pods(self):
        for name in ("bitmovin_player", "BitmovinPlayer", "BitmovinPlayerCore", "BitmovinAnalyticsCollector"):
            with self.subTest(name=name):
                self.podfile.write_text(f"PODS:\n  - {name} (3.124.0)\n")
                result = self.run_script()
                self.assertEqual(result.returncode, 1)
                self.assertIn("must not be resolved through CocoaPods", result.stderr)

    def test_missing_or_malformed_spm_lockfile_fails(self):
        self.lockfile.unlink()
        self.assertNotEqual(self.run_script().returncode, 0)
        self.lockfile.write_text("not json")
        self.assertNotEqual(self.run_script().returncode, 0)


if __name__ == "__main__":
    unittest.main()
