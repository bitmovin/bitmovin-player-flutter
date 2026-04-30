#!/usr/bin/env python3
"""
Link native SDK version references in CHANGELOG.md to Bitmovin release notes.

Each changelog line mentioning "iOS" or "Android" with a version like `3.X.Y`
gets that version turned into a markdown link to the corresponding release notes
section on developer.bitmovin.com.

Usage:
  scripts/link_sdk_versions.py [--dry-run] [CHANGELOG.md]
"""
import re
import sys
from pathlib import Path

IOS_URL = "https://developer.bitmovin.com/playback/docs/release-notes-ios"
ANDROID_URL = "https://developer.bitmovin.com/playback/docs/release-notes-android"

# Matches `3.X.Y` or `3.X.Y+suffix` inside backticks
VERSION_RE = re.compile(r"`(3\.\d+\.\d+(?:\+[^`]+)?)`")


def version_to_anchor(version: str) -> str:
    """'3.112.0' or '3.151.0+jason' -> '#31120' / '#31510'"""
    semver = version.split("+")[0]
    return "#" + semver.replace(".", "")


def transform_line(line: str) -> str:
    if "](https://developer.bitmovin.com" in line:
        return line  # already linked

    lower = line.lower()
    if "ios" in lower:
        base_url = IOS_URL
    elif "android" in lower:
        base_url = ANDROID_URL
    else:
        return line

    def make_link(m: re.Match) -> str:
        version = m.group(1)
        anchor = version_to_anchor(version)
        return f"[`{version}`]({base_url}{anchor})"

    return VERSION_RE.sub(make_link, line)


def main() -> None:
    args = sys.argv[1:]
    dry_run = "--dry-run" in args
    args = [a for a in args if a != "--dry-run"]

    path = Path(args[0]) if args else Path("CHANGELOG.md")
    content = path.read_text()
    lines = content.splitlines(keepends=True)
    new_lines = [transform_line(line) for line in lines]
    new_content = "".join(new_lines)

    if new_content == content:
        print(f"No changes needed in {path}")
        return

    if dry_run:
        import difflib
        diff = difflib.unified_diff(
            content.splitlines(keepends=True),
            new_content.splitlines(keepends=True),
            fromfile=str(path),
            tofile=str(path) + " (linked)",
        )
        sys.stdout.writelines(diff)
    else:
        path.write_text(new_content)
        changed = sum(1 for a, b in zip(lines, new_lines) if a != b)
        print(f"Updated {path} ({changed} line(s) linked)")


if __name__ == "__main__":
    main()
