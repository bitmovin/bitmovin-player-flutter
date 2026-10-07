"""Prepare and finish repeatable native SDK update PRs without rewriting history.

Usage: sdk_update_pr.py <prepare|finish> <android|ios> <version> <base> <owner/repo>
Existing update branches retain their original base and verified bot commits.
All pushes are fast-forward; superseded PRs are closed without deleting branches.
"""
from __future__ import annotations

import json
from pathlib import Path
import re
import subprocess
import sys


BOT_EMAIL = "update-bot@bitmovin.com"
SEMVER = re.compile(
    r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"
    r"(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?"
    r"(?:\+([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?"
)
FILES = {
    "android": {"android/build.gradle", "CHANGELOG.md"},
    "ios": {
        "ios/bitmovin_player/Package.swift", "CHANGELOG.md", "example/ios/Podfile.lock",
        "example/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved",
        "example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved",
    },
}


def semver_key(version: str) -> tuple:
    match = SEMVER.fullmatch(version) if len(version) <= 256 else None
    if not match:
        raise ValueError(f"Invalid SemVer: {version!r}")
    identifiers = match[4].split(".") if match[4] else []
    if any(part.isdigit() and len(part) > 1 and part.startswith("0") for part in identifiers):
        raise ValueError(f"Invalid SemVer: {version!r}")
    prerelease = tuple((0, int(part)) if part.isdigit() else (1, part) for part in identifiers)
    # Build metadata has no effect on SemVer precedence, including +jason.
    return (tuple(int(match[i]) for i in (1, 2, 3)), not identifiers, prerelease)


def run(*args: str) -> str:
    result = subprocess.run(args, text=True, capture_output=True)
    if result.returncode:
        raise ValueError(f"{args[0]} {args[1]} failed ({result.returncode}): {result.stderr.strip()}")
    return result.stdout.strip()


def open_prs(repository: str) -> list[dict]:
    # Fetch every page rather than silently omitting PRs beyond gh pr list's limit.
    pages = json.loads(run("gh", "api", "--paginate", "--slurp",
                           f"repos/{repository}/pulls?state=open&per_page=100"))
    if not isinstance(pages, list) or any(not isinstance(page, list) for page in pages):
        raise ValueError("Invalid paginated PR response")
    prs = []
    for page in pages:
        for pr in page:
            if (not isinstance(pr, dict) or type(pr.get("number")) is not int
                    or pr["number"] <= 0 or pr.get("state") != "open"):
                raise ValueError("Invalid open PR response")
            for side in ("head", "base"):
                ref = pr.get(side)
                if not isinstance(ref, dict) or not isinstance(ref.get("ref"), str):
                    raise ValueError("Invalid PR ref response")
                repo = ref.get("repo")
                if repo is not None and (not isinstance(repo, dict)
                                         or not isinstance(repo.get("full_name"), str)):
                    raise ValueError("Invalid PR repository response")
            prs.append(pr)
    return prs


def same_repository(pr: dict, repository: str) -> bool:
    return all((pr[side]["repo"] or {}).get("full_name") == repository for side in ("head", "base"))


def existing_pr(prs: list[dict], branch: str, base: str, repository: str) -> dict | None:
    matches = [pr for pr in prs if same_repository(pr, repository) and pr["head"]["ref"] == branch]
    if any(pr["base"]["ref"] != base for pr in matches):
        raise ValueError("Update branch has an open PR for another base; refusing to reuse it")
    if len(matches) > 1:
        raise ValueError("Multiple open PRs for the update branch")
    return matches[0] if matches else None


def verify_automation_history(tip: str, platform: str, version: str, base: str) -> bool:
    label = "iOS" if platform == "ios" else "Android"
    subjects = {f"Update {label} player SDK to {version}",
                f"chore({platform}): update {platform} player version to {version}"}
    base_sha = run("git", "rev-parse", f"refs/remotes/origin/{base}")
    # Fail explicitly if the histories are unrelated, rather than trusting an empty range.
    run("git", "merge-base", base_sha, tip)
    commits = run("git", "rev-list", f"{base_sha}..{tip}").splitlines()
    for commit in commits:
        details = run("git", "show", "-s", "--format=%ae%n%ce%n%s%n%P", commit).splitlines()
        paths = set(run("git", "diff-tree", "--no-commit-id", "--name-only", "-r", commit).splitlines())
        if (len(details) != 4 or details[0] != BOT_EMAIL or details[1] != BOT_EMAIL
                or details[2] not in subjects or len(details[3].split()) != 1
                or not paths or not paths <= FILES[platform]):
            raise ValueError(f"Refusing update branch containing non-automation commit {commit}")
    return bool(commits)


def cleanup_history_is_automation(pr: dict, platform: str, version: str, base: str) -> bool:
    sha = pr["head"].get("sha")
    if not isinstance(sha, str) or not re.fullmatch(r"(?:[0-9a-f]{40}|[0-9a-f]{64})", sha):
        return False
    ref = f"refs/sdk-update/cleanup/{pr['number']}/{sha}"
    try:
        run("git", "fetch", "origin", f"refs/heads/{pr['head']['ref']}:{ref}")
        if run("git", "rev-parse", ref) != sha:
            return False
        return verify_automation_history(ref, platform, version, base)
    except ValueError as error:
        print(f"Skipping PR #{pr['number']}: {error}")
        return False


def prepare(platform: str, version: str, base: str, repository: str, branch: str) -> None:
    existing_pr(open_prs(repository), branch, base, repository)
    run("git", "fetch", "origin", f"refs/heads/{base}:refs/remotes/origin/{base}")
    result = subprocess.run(["git", "ls-remote", "--exit-code", "--heads", "origin",
                             f"refs/heads/{branch}"], text=True, capture_output=True)
    if result.returncode == 2:
        run("git", "checkout", "-b", branch, f"refs/remotes/origin/{base}")
    elif result.returncode == 0:
        run("git", "fetch", "origin", f"refs/heads/{branch}:refs/sdk-update/remote")
        verify_automation_history("refs/sdk-update/remote", platform, version, base)
        run("git", "checkout", "-b", branch, "refs/sdk-update/remote")
    else:
        raise ValueError(f"git ls-remote failed ({result.returncode}): {result.stderr.strip()}")
    print(f"Prepared {branch}")


def finish(platform: str, version: str, base: str, repository: str, branch: str) -> None:
    if run("git", "branch", "--show-current") != branch:
        raise ValueError("Not on the expected update branch")
    verify_automation_history("HEAD", platform, version, base)
    changed = set(run("git", "diff", "HEAD", "--name-only").splitlines())
    if not changed <= FILES[platform]:
        raise ValueError(f"Unexpected tracked changes: {sorted(changed - FILES[platform])}")
    deleted = run("git", "diff", "HEAD", "--diff-filter=D", "--name-only")
    if deleted:
        raise ValueError(f"SDK update files were deleted: {deleted}")
    paths = [name for name in sorted(FILES[platform]) if Path(name).exists()]
    run("git", "add", "--", *paths)
    if run("git", "diff", "--cached", "--name-only"):
        label = "iOS" if platform == "ios" else "Android"
        run("git", "commit", "--no-verify", "-m", f"Update {label} player SDK to {version}")
    prs = open_prs(repository)
    current = existing_pr(prs, branch, base, repository)
    # Ordinary pushes preserve all history and reject concurrent remote changes.
    run("git", "push", "origin", f"HEAD:refs/heads/{branch}")
    label = "iOS" if platform == "ios" else "Android"
    title = f"Update {label} player to {version}"
    body = f"Automated {label} player version update to {version}"
    # Reusing a PR must preserve human edits to its title and validation notes.
    if current is None:
        run("gh", "pr", "create", "--repo", repository, "--base", base,
            "--head", branch, "--title", title, "--body", body)
    # A successful CLI mutation alone is insufficient: confirm the replacement is open.
    prs = open_prs(repository)
    replacement = existing_pr(prs, branch, base, repository)
    if replacement is None:
        raise ValueError("Replacement PR was not found; refusing superseded PR cleanup")
    prefix = f"update_{platform}_player_to_"
    for pr in prs:
        if (pr["number"] == replacement["number"] or not same_repository(pr, repository)
                or pr["base"]["ref"] != base or not pr["head"]["ref"].startswith(prefix)):
            continue
        old_version = pr["head"]["ref"][len(prefix):]
        try:
            older = semver_key(old_version) < semver_key(version)
        except ValueError:
            continue
        if older and cleanup_history_is_automation(pr, platform, old_version, base):
            run("gh", "pr", "close", str(pr["number"]), "--repo", repository,
                "--comment", f"Closing because {label} Player SDK {old_version} is superseded "
                f"by {version} in #{replacement['number']}.")
    print(f"Updated PR #{replacement['number']}")


def main() -> None:
    if len(sys.argv) != 6 or sys.argv[1] not in {"prepare", "finish"}:
        sys.exit("Usage: sdk_update_pr.py <prepare|finish> <android|ios> <version> <base> <owner/repo>")
    phase, platform, version, base, repository = sys.argv[1:]
    try:
        semver_key(version)
        if platform not in FILES:
            raise ValueError("SDK platform must be android or ios")
        if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", repository):
            raise ValueError("Invalid repository")
        if base.startswith("-"):
            raise ValueError("Invalid base branch")
        run("git", "check-ref-format", f"refs/heads/{base}")
        branch = f"update_{platform}_player_to_{version}"
        run("git", "check-ref-format", f"refs/heads/{branch}")
        if phase == "prepare":
            prepare(platform, version, base, repository, branch)
        else:
            finish(platform, version, base, repository, branch)
    except (ValueError, OSError) as error:
        sys.exit(f"Error: {error}")


if __name__ == "__main__":
    main()
