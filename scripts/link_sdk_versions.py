#!/usr/bin/env python3
"""
Link native SDK version references in CHANGELOG.md to Bitmovin release notes.

Each changelog line mentioning "iOS" or "Android" with a version like `X.Y.Z`
gets that version turned into a markdown link to the corresponding release notes
section on developer.bitmovin.com.

Usage:
  scripts/link_sdk_versions.py [--dry-run | --check] [CHANGELOG.md]
"""
import argparse
import difflib
import re
import sys
from pathlib import Path

IOS_URL = "https://developer.bitmovin.com/playback/docs/release-notes-ios"
ANDROID_URL = "https://developer.bitmovin.com/playback/docs/release-notes-android"

# Matches `X.Y.Z` or `X.Y.Z+suffix` inside backticks (any major version)
VERSION_RE = re.compile(r"`(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?)`")


def version_to_anchor(version: str) -> str:
    """'3.112.0' or '3.151.0+jason' -> '#31120' / '#31510'"""
    semver = version.split("+")[0].split("-")[0]
    return "#" + semver.replace(".", "")


def transform_line(line: str) -> str:
    if "bitmovin" not in line.lower():
        return line

    def make_link(m: re.Match) -> str:
        if line[m.start() - 1:m.start()] == "[" and line[m.end():].startswith("]("):
            return m.group(0)  # this version is already linked
        prefix = line[:m.start()].lower()
        platforms = re.findall(r"\b(?:ios|android)\b", prefix)
        if not platforms:
            return m.group(0)
        if platforms[-1] == "ios":
            base_url = IOS_URL
        else:
            base_url = ANDROID_URL
        anchor = version_to_anchor(m.group(1))
        return f"[`{m.group(1)}`]({base_url}{anchor})"

    return VERSION_RE.sub(make_link, line)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--dry-run", action="store_true", help="Show changes without writing")
    mode.add_argument("--check", action="store_true", help="Fail on missing links without writing")
    parser.add_argument("path", nargs="?", type=Path, default=Path("CHANGELOG.md"))
    args = parser.parse_args()
    path = args.path
    if not path.exists():
        print(f"error: {path} not found", file=sys.stderr)
        return 1

    with path.open(encoding="utf-8", newline="") as file:
        content = file.read()
    lines = content.splitlines(keepends=True)
    new_lines = [transform_line(line) for line in lines]
    new_content = "".join(new_lines)

    if new_content == content:
        print(f"No changes needed in {path}")
        return 0

    if args.dry_run or args.check:
        diff = difflib.unified_diff(
            content.splitlines(keepends=True),
            new_content.splitlines(keepends=True),
            fromfile=str(path),
            tofile=str(path) + " (linked)",
        )
        sys.stdout.writelines(diff)
    else:
        path.write_text(new_content, encoding="utf-8")
        changed = sum(1 for a, b in zip(lines, new_lines) if a != b)
        print(f"Updated {path} ({changed} line(s) linked)")
    return 1 if args.check else 0


if __name__ == "__main__":
    sys.exit(main())
