#!/usr/bin/env bash

set -euo pipefail

readonly UPSTREAM_URL="https://github.com/pingdotgg/t3code.git"
readonly REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$REPO_ROOT"

if [[ -n "$(git status --porcelain)" ]]; then
  printf 'Refusing to sync: the checkout has uncommitted or untracked changes.\n' >&2
  exit 1
fi

if git remote get-url upstream >/dev/null 2>&1; then
  git remote set-url upstream "$UPSTREAM_URL"
else
  git remote add upstream "$UPSTREAM_URL"
fi

git fetch upstream main --tags
git fetch origin main
git switch main
git merge --ff-only origin/main

readonly SYNC_DATE="$(date -u +%Y%m%d)"
readonly BASE_BRANCH="maintenance/upstream-${SYNC_DATE}"
SYNC_BRANCH="$BASE_BRANCH"
SUFFIX=2
while git show-ref --verify --quiet "refs/heads/$SYNC_BRANCH"; do
  SYNC_BRANCH="${BASE_BRANCH}-${SUFFIX}"
  SUFFIX=$((SUFFIX + 1))
done

git switch -c "$SYNC_BRANCH"
git merge --no-edit upstream/main

printf '\nUpstream is merged into %s.\n' "$SYNC_BRANCH"
printf 'Run vp check, vp run typecheck, and vp run lint:mobile before publishing it.\n'
printf 'Review the diff, then push this branch and merge it through a pull request.\n'
