#!/usr/bin/env python3
"""Verify the built example resolves Bitmovin through SPM, never CocoaPods."""
import json
import re
import subprocess
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
expected = subprocess.check_output([sys.executable, str(root / "scripts/ios_sdk_version.py")], text=True).strip()

lockfile = root / "example/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved"
pins = json.loads(lockfile.read_text())["pins"]

for identity in ("player-ios", "player-ios-core"):
    matches = [pin for pin in pins if pin["identity"] == identity]
    if len(matches) != 1 or matches[0]["state"].get("version") != expected:
        sys.exit(f"Expected {identity} {expected} in {lockfile}")

podfile = root / "example/ios/Podfile.lock"
if podfile.exists() and re.search(r"(?m)^  - (?:bitmovin_player|BitmovinPlayer|BitmovinPlayerCore|BitmovinAnalyticsCollector)(?:[ /(:]|$)", podfile.read_text()):
    sys.exit("Bitmovin must not be resolved through CocoaPods")

print(f"Verified Player {expected} and Player Core resolve through SPM without Bitmovin pods")
