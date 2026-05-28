#!/usr/bin/env sh
set -eu

PROJECT_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
ENV_FILE="$PROJECT_ROOT/.env"
VENV_DIR="$PROJECT_ROOT/.venv"

if [ "$#" -eq 0 ]; then
  printf 'Usage: %s <command> [args...]\n' "$0" >&2
  exit 2
fi

if [ ! -f "$ENV_FILE" ]; then
  printf 'Missing .env. Run ./setup.sh, then fill in project secrets.\n' >&2
  exit 1
fi

set -a
. "$ENV_FILE"
set +a

cd "$PROJECT_ROOT"

if [ -d "$VENV_DIR" ]; then
  PATH="$VENV_DIR/bin:$PATH"
  export PATH
  VIRTUAL_ENV="$VENV_DIR"
  export VIRTUAL_ENV
fi

exec "$@"
