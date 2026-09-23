#!/usr/bin/env python3
"""Read or update the exact native iOS Player version in Package.swift."""
import re
import sys
from pathlib import Path

MANIFEST = Path(__file__).resolve().parents[1] / "ios/bitmovin_player/Package.swift"
PATTERN = re.compile(r'(\.package\(url: "https://github\.com/bitmovin/player-ios\.git", exact: ")([^"\n]+)("\))')


def main():
    text = MANIFEST.read_text()
    matches = list(PATTERN.finditer(text))
    if len(matches) != 1:
        sys.exit("Expected exactly one pinned player-ios dependency in Package.swift")
    if len(sys.argv) == 1:
        print(matches[0][2])
        return
    if len(sys.argv) != 2 or not re.fullmatch(r"\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?", sys.argv[1]):
        sys.exit("Usage: ios_sdk_version.py [X.Y.Z[-prerelease]]")
    MANIFEST.write_text(PATTERN.sub(lambda m: m[1] + sys.argv[1] + m[3], text))


if __name__ == "__main__":
    main()
