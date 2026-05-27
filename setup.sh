#!/usr/bin/env sh
set -eu

PROJECT_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd "$PROJECT_ROOT"

mkdir -p worktrees

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git config core.autocrlf input
  git config fetch.prune true
fi

printf 'Workspace ready: %s\n' "$PROJECT_ROOT"
