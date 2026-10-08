# Preparing and approving a release

1. Run **Start Release Train** on `main` with a stable version greater than the
   current package version, such as `0.27.0`. It upgrades Dart dependencies in
   the package, example and testing package, regenerates code, builds the iOS
   example with SPM and validates the resulting package with a publish dry run.
2. Review the generated `release/<version>` PR into `main`. Review dependency
   upgrades, generated code, the package version and release notes. Wait for
   the candidate's CI checks, including Android and source analysis.
3. Merge the PR when ready to publish. **This merge approves publication.**
   Finish Release Train automatically tags the exact merged commit. The tag
   triggers publication to pub.dev, the GitHub release and API documentation.

There is no manual Finish dispatch or post-publication cleanup PR. The preparation
PR already contains a dated release entry and a fresh empty `Unreleased` section.
The changelog date records preparation, so all published contents are available
for review before approval. Subsequent changes to `main` do not enter that tag.

Start uses `PLAYER_CI_GH_TOKEN` for branch and PR creation so normal PR checks
run. Finish retains `PLAYER_FLUTTER_DEPLOY_KEY` for the tag push so the existing
tag-triggered publishing workflow runs. These credentials need their existing
repository write access. Keep the `pub.dev` environment for trusted publishing,
but remove its required-reviewer rule when adopting this flow: the release PR
merge supplies human approval. Leaving that rule enabled adds another approval
before publishing. Repository protections continue to apply. This flow does not
enable auto-merge or scheduled preparation.

## Retrying safely

- Running Start again while the same release PR is open skips preparation and
  preserves all edits and review work. Another open release PR or unfinished
  release branch blocks preparation. Closed release PRs are not reopened
- If Start pushed the branch but failed to create its PR, inspect that branch
  and its workflow log. Open the PR manually with
  `gh pr create --base main --head release/<version>` and include the explicit
  merge-to-publish approval message above. Do not delete or overwrite the branch
- Rerunning Finish skips a tag already pointing to the approved merged commit.
  A tag at another commit causes failure and is never moved. If publication fails
  after the tag push, inspect the publishing run and rerun only its failed jobs;
  do not move the tag or dispatch Start again

No actual release is needed to validate the automation. The existing Python
automation suite covers preparation, candidate identity, version/changelog
agreement and rerun safety. The pre-release script tests use isolated tools to
verify that checks run after upgrades and code generation, and failures block
preparation.
