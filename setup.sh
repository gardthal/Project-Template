#!/usr/bin/env sh
set -eu

PROJECT_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd "$PROJECT_ROOT"

mkdir -p worktrees

PYTHON_BIN=${PYTHON_BIN:-python3}
VENV_DIR="$PROJECT_ROOT/.venv"

if [ ! -d "$VENV_DIR" ]; then
  "$PYTHON_BIN" -m venv "$VENV_DIR"
  printf 'Created Python virtual environment: %s\n' "$VENV_DIR"
fi

if [ -f pyproject.toml ]; then
  PIP_DISABLE_PIP_VERSION_CHECK=1 "$VENV_DIR/bin/python" -m pip install -e ".[dev]"
elif [ -f requirements-dev.txt ]; then
  PIP_DISABLE_PIP_VERSION_CHECK=1 "$VENV_DIR/bin/python" -m pip install -r requirements-dev.txt
elif [ -f requirements.txt ]; then
  PIP_DISABLE_PIP_VERSION_CHECK=1 "$VENV_DIR/bin/python" -m pip install -r requirements.txt
else
  printf 'No dependency metadata found; skipping dependency installation.\n'
fi

if [ -f .env.example ] && [ ! -f .env ]; then
  cp .env.example .env
  chmod 600 .env
  printf 'Created local .env from .env.example. Fill in real secret values before running API-backed code.\n'
fi

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if ! git config core.autocrlf input >/dev/null 2>&1; then
    printf 'Skipped git config core.autocrlf; local Git config is not writable.\n'
  fi
  if ! git config fetch.prune true >/dev/null 2>&1; then
    printf 'Skipped git config fetch.prune; local Git config is not writable.\n'
  fi
fi

printf 'Workspace ready: %s\n' "$PROJECT_ROOT"
