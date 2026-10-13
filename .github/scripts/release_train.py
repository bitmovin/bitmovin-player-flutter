"""Prepare a reviewed release and validate its immutable publication source."""

import argparse
import datetime
import json
import os
import re
import subprocess
import sys
from pathlib import Path

from ensure_unreleased_changelog import SECTION, ensure_unreleased_section


VERSION = r"(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)"


def validate_version(version, current=None):
    if not re.fullmatch(VERSION, version):
        raise ValueError("Release version must be a stable MAJOR.MINOR.PATCH version")
    if current is not None:
        validate_version(current)
        if tuple(map(int, version.split("."))) <= tuple(map(int, current.split("."))):
            raise ValueError("Release version must be greater than the current package version")


def package_version(pubspec):
    versions = re.findall(r"^version: ([^\r\n]+)\r?$", pubspec, re.MULTILINE)
    if len(versions) != 1:
        raise ValueError("Expected exactly one package version in pubspec.yaml")
    return versions[0]


def has_changes(body):
    body = re.sub(r"<!--.*?-->", "", body, flags=re.DOTALL)
    return any(
        line.strip(" \t-*+_>")
        and not line.lstrip().startswith("#")
        and not re.match(r"^\s*\[[^\]]+\]:", line)
        for line in body.splitlines()
    )


def prepare_changelog(content, version, date):
    validate_version(version)
    datetime.date.fromisoformat(date)
    headings = list(SECTION.finditer(content))
    if not headings or headings[0][1] != "Unreleased" or sum(h[1] == "Unreleased" for h in headings) != 1:
        raise ValueError("Expected one topmost Unreleased section")
    if any(h[1] == version for h in headings):
        raise ValueError("Release version already exists in CHANGELOG.md")
    end = headings[1].start() if len(headings) > 1 else len(content)
    if not has_changes(content[headings[0].end():end]):
        raise ValueError("Unreleased contains no change entries")
    newline = "\r\n" if "\r\n" in content else "\n"
    updated = content[:headings[0].start()] + f"## [{version}] - {date}" + newline + content[headings[0].end():]
    return ensure_unreleased_section(updated)


def start_state(version, prs, refs):
    validate_version(version)
    prs = [pr for pr in prs if not pr.get("isCrossRepository", False)]
    branch = f"release/{version}"
    if f"refs/tags/{version}" in refs:
        raise ValueError("Release tag already exists")
    same = [pr for pr in prs if pr["headRefName"] == branch]
    other = [pr for pr in prs if pr["state"] == "OPEN" and pr["headRefName"].startswith("release/") and pr["headRefName"] != branch]
    if other:
        raise ValueError("Another release PR is open; finish it before starting a release")
    # Old merged branches may remain when automatic branch deletion is disabled.
    completed = {f"refs/heads/{pr['headRefName']}" for pr in prs
                 if pr["state"] == "MERGED" and pr["headRefName"].startswith("release/")
                 and f"refs/tags/{pr['headRefName'].removeprefix('release/')}" in refs}
    active = [ref for ref in refs if ref.startswith("refs/heads/release/") and ref not in completed and ref != f"refs/heads/{branch}"]
    if active:
        raise ValueError("Another release branch is unfinished; inspect it before retrying")
    if same:
        if len(same) == 1 and same[0]["state"] == "OPEN":
            print(f"Release PR already exists: {same[0]['url']}; preserving all review work")
            return False
        raise ValueError("This release PR was closed or merged; do not reopen it automatically")
    if f"refs/heads/{branch}" in refs:
        raise ValueError("Release branch exists without a PR; inspect it and open its PR manually")
    return True


def validate_merge(event, repository, head, pubspec, changelog):
    pr = event.get("pull_request", {})
    base, source = pr.get("base", {}), pr.get("head", {})
    if (event.get("action") != "closed" or pr.get("merged") is not True
            or base.get("ref") != "main"
            or base.get("repo", {}).get("full_name") != repository
            or source.get("repo", {}).get("full_name") != repository):
        raise ValueError("Only a merged release PR from this repository into main may publish")
    branch = source.get("ref", "")
    if not branch.startswith("release/"):
        raise ValueError("Expected release/<version> source branch")
    version = branch.removeprefix("release/")
    validate_version(version)
    if not re.fullmatch(r"[0-9a-f]{40}", head) or head != pr.get("merge_commit_sha"):
        raise ValueError("Checkout must be the exact merged PR revision, never latest main")
    if package_version(pubspec) != version:
        raise ValueError("Release branch and package version disagree")
    headings = list(SECTION.finditer(changelog))
    if (len(headings) < 2 or headings[0][1] != "Unreleased"
            or sum(h[1] == "Unreleased" for h in headings) != 1
            or has_changes(changelog[headings[0].end():headings[1].start()])):
        raise ValueError("Expected one empty topmost Unreleased section in the approved release")
    date_heading = re.fullmatch(rf"## \[{re.escape(version)}\] - (\d{{4}}-\d{{2}}-\d{{2}})", headings[1][0].rstrip("\r\n"))
    if date_heading is None or sum(h[1] == version for h in headings) != 1:
        raise ValueError("Expected the dated release immediately after Unreleased")
    datetime.date.fromisoformat(date_heading[1])
    end = headings[2].start() if len(headings) > 2 else len(changelog)
    if not has_changes(changelog[headings[1].end():end]):
        raise ValueError("Approved release contains no release notes")
    return version


def tag_needed(head, tagged):
    if tagged is None:
        return True
    if tagged != head:
        raise ValueError("Existing release tag points to a different commit; refusing to replace it")
    print("Release tag already points to the approved commit; nothing to publish")
    return False


def run(*args):
    return subprocess.check_output(args, text=True).strip()


def read(path):
    with Path(path).open(encoding="utf-8", newline="") as file:
        return file.read()


def output(**values):
    for key, value in values.items():
        line = f"{key}={str(value).lower() if isinstance(value, bool) else value}"
        print(line)
        if os.environ.get("GITHUB_OUTPUT"):
            with Path(os.environ["GITHUB_OUTPUT"]).open("a", encoding="utf-8") as file:
                file.write(line + "\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=("check-start", "prepare", "finish"))
    parser.add_argument("version", nargs="?")
    args = parser.parse_args()
    if args.command == "finish":
        event = json.loads(read(os.environ["GITHUB_EVENT_PATH"]))
        head = run("git", "rev-parse", "HEAD")
        version = validate_merge(event, os.environ["GITHUB_REPOSITORY"], head, read("pubspec.yaml"), read("CHANGELOG.md"))
        tag = subprocess.run(["git", "rev-parse", "--verify", f"refs/tags/{version}^{{commit}}"], capture_output=True, text=True)
        output(version=version, create_tag=tag_needed(head, tag.stdout.strip() if tag.returncode == 0 else None))
    else:
        if args.version is None:
            raise ValueError("A release version is required")
        pubspec = read("pubspec.yaml")
        validate_version(args.version, package_version(pubspec))
        if args.command == "check-start":
            prs = json.loads(run("gh", "pr", "list", "--repo", os.environ["GITHUB_REPOSITORY"], "--base", "main", "--state", "all", "--limit", "1000", "--json", "headRefName,url,state,isCrossRepository"))
            if len(prs) == 1000:
                raise ValueError("PR query limit reached; release history must be inspected before continuing")
            refs = [line.split()[1] for line in run("git", "ls-remote", "--heads", "--tags", "origin").splitlines()]
            output(prepare=start_state(args.version, prs, refs), branch=f"release/{args.version}")
        else:
            content = prepare_changelog(read("CHANGELOG.md"), args.version, datetime.datetime.now(datetime.timezone.utc).date().isoformat())
            updated = re.sub(r"^version: [^\r\n]+", f"version: {args.version}", pubspec, count=1, flags=re.MULTILINE)
            for path, text in (("pubspec.yaml", updated), ("CHANGELOG.md", content)):
                with Path(path).open("w", encoding="utf-8", newline="") as file:
                    file.write(text)


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, subprocess.CalledProcessError) as error:
        sys.exit(f"Release preparation refused: {error}")
