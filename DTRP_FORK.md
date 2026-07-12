# DemonTimeRP T3 Code Fork

This fork keeps the founder workflow unchanged: open a chat, describe the outcome, and let the
agent handle Git and workspace mechanics.

## First compatibility milestone

- New threads default to isolated worktrees created from the latest matching branch on `origin`.
- Automatic task branches use `feature/sol/<slug>`, matching the existing DTRP agent policy.
- Push publishes the current local branch to the same-named remote branch. If legacy metadata says a
  feature branch tracks `origin/main`, T3 repairs that metadata during the push instead of targeting
  `main`.
- The default Branch changes diff includes committed changes plus current uncommitted and untracked
  edits, so in-progress agent work appears without switching scopes or committing first.
- Thread worktree binding remains T3-native, so provider execution, terminals, checkpoints, and
  diffs all follow the same task workspace.

## Deliberately unchanged

- Stark and Knox prompt normally; there is no new founder setup or approval step.
- DTRP target selection, authority, testing, PR review, deployment, and verification remain owned by
  the existing repository tools and agent instructions.
- This fork is optional and does not replace the ChatGPT/Codex app.
- The upstream T3 v0.0.28 service remains isolated on `127.0.0.1:3773`. The validated fork runs as
  the separate `dtrp-t3-code` user service on `127.0.0.1:4773`, exposed only inside the DTRP
  tailnet.

## Separate Mac and mobile identity

The fork installs beside upstream T3 instead of replacing it:

- Product name: `DTRP T3`
- macOS/iOS/Android application ID: `com.demontimerp.t3code`
- Production URL scheme: `dtrp-t3`; development: `dtrp-t3-dev`
- Desktop user-data directory: `dtrp-t3`, backed by `~/.dtrp-t3` (upstream continues to use
  `t3code` and `~/.t3`)
- Desktop updates publish from the GitHub repository performing the build, or from
  `T3CODE_DESKTOP_UPDATE_REPOSITORY` when explicitly set.

The fork deliberately contains no T3 Tools Apple, Expo, Clerk, APNS, or App Store credentials.
Set these public identity values when the DTRP-owned services exist:

```dotenv
DTRP_T3_APPLE_TEAM_ID=XXXXXXXXXX
DTRP_T3_RELYING_PARTY=auth.example.com
DTRP_T3_EAS_OWNER=your-expo-owner
DTRP_T3_EAS_PROJECT_ID=00000000-0000-0000-0000-000000000000
```

Without an EAS project ID, mobile OTA updates are disabled. A personal-team iOS build remains
available with `T3CODE_IOS_PERSONAL_TEAM=1` and a unique
`T3CODE_IOS_PERSONAL_TEAM_BUNDLE_ID`; that mode intentionally removes widgets, push, and native
Apple sign-in because a free Personal Team cannot sign those capabilities.

## Thin, toggleable appearance layer

The DTRP visual treatment is intentionally client-only and reversible. General Settings includes a
`DemonTimeRP branding` switch. When enabled (the fork default), it applies the compact DTRP wordmark
and red accent palette. Disabling it restores the standard T3 wordmark and palette immediately.

No DTRP operational rules live in the theme. Agent behavior remains owned by the target repository's
`AGENTS.md`, skills, and server-side configuration, keeping appearance changes easy to rebase.

## Updating from upstream T3

The fork tracks the official repository as the `upstream` remote. From a clean checkout, run:

```bash
./scripts/dtrp-sync-upstream.sh
```

The script fetches `pingdotgg/t3code`, fast-forwards the fork's local `main` to `origin/main`, and
merges the newest upstream `main` into a dated `maintenance/upstream-YYYYMMDD` branch. It never pushes
or merges into the fork's `main` directly. Validate and review that branch, then publish it through a
pull request.
