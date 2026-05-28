# Development

Use this checklist when starting from the template.

## Rename The Project

Update these placeholders:

- `README.md` title and paths
- `pyproject.toml` project name and description
- `src/project_template/` package directory
- tests importing `project_template`
- `.env.example` required variables
- `LICENSE` copyright holder or license terms

## Setup

Run:

```sh
./setup.sh
```

This creates `.venv/`, installs the project in editable mode with development
dependencies, and creates `.env` from `.env.example` when needed.

## Common Commands

Run tests:

```sh
./scripts/run_with_env.sh python -m pytest
```

Run lint checks:

```sh
./scripts/run_with_env.sh python -m ruff check .
```

Format code:

```sh
./scripts/run_with_env.sh python -m ruff format .
```

## Dependency Changes

Add runtime dependencies to `project.dependencies` in `pyproject.toml`.
Add development-only tools to `project.optional-dependencies.dev`.

After editing dependencies, run:

```sh
./setup.sh
```
