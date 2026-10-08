"""Restore one topmost Unreleased section without rewriting released entries."""

import re
import sys
from pathlib import Path


HEADER = "## [Unreleased]"
SECTION = re.compile(r"^## \[([^\]\r\n]+)\][^\r\n]*(?:\r?\n|$)", re.MULTILINE)


def ensure_unreleased_section(content: str) -> str:
    newline = "\r\n" if "\r\n" in content else "\n"
    headings = list(SECTION.finditer(content))
    unreleased = [heading for heading in headings if heading[1] == "Unreleased"]
    if (
        len(unreleased) == 1
        and unreleased[0] == headings[0]
        and unreleased[0][0].rstrip("\r\n") == HEADER
    ):
        return content

    if headings:
        pending = []
        releases = []
        for index, heading in enumerate(headings):
            end = headings[index + 1].start() if index + 1 < len(headings) else len(content)
            if heading[1] == "Unreleased":
                pending.append(content[heading.end():end])
            else:
                releases.append(content[heading.start():end])

        body = "".join(pending) if pending else newline
        if releases and body and not body.endswith("\n"):
            body += newline + newline
        return content[:headings[0].start()] + HEADER + newline + body + "".join(releases)

    title = re.search(r"^# Changelog[^\r\n]*(?:\r?\n|$)", content, re.MULTILINE)
    if title:
        prefix = content[:title.end()].rstrip("\r\n") + newline + newline
        return prefix + HEADER + newline + newline + content[title.end():]
    return "# Changelog" + newline + newline + HEADER + newline + newline + content


def main() -> None:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "CHANGELOG.md")
    with path.open(encoding="utf-8", newline="") as changelog:
        content = changelog.read()
    updated = ensure_unreleased_section(content)
    if updated != content:
        with path.open("w", encoding="utf-8", newline="") as changelog:
            changelog.write(updated)


if __name__ == "__main__":
    main()
