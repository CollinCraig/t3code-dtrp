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
- The installed T3 v0.0.28 service is not switched to this fork until the fork passes focused and
  end-to-end validation.
