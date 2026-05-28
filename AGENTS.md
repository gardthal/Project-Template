# Agent Instructions

This repository is a Python-oriented template project. It is intended to be
copied when starting new projects, so keep the guidance here broadly useful,
conservative, and easy for future agents to follow.

## Instruction Scope

- Keep this root `AGENTS.md` focused on repository-wide rules.
- Add nested `AGENTS.md` files only when a subdirectory needs different setup,
  commands, ownership rules, or conventions.
- Use `AGENTS.override.md` only for intentional overrides. When both
  `AGENTS.override.md` and `AGENTS.md` exist in the same directory, Codex uses
  the override file for that directory.
- More specific instructions closer to the working directory take precedence
  over broader project instructions.
- Keep instruction files concise. Codex has a combined instruction size limit,
  so move long process docs to `docs/` and link to them from `AGENTS.md`.

## Workspace Layout

- Keep all projects under `~/Documents/Codex/`.
- Keep each project self-contained in its own folder.
- Treat the project root checkout as the stable `main` checkout.
- Do task work in a branch-specific Git worktree under `worktrees/`.
- Keep generated files, virtual environments, caches, build output, and local
  secrets out of source control.

Expected layout as the project grows:

```text
.
|-- AGENTS.md
|-- README.md
|-- setup.sh
|-- .github/workflows/ci.yml
|-- pyproject.toml       # Python project metadata, once dependencies exist
|-- src/                 # Application or library code
|-- tests/               # Automated tests
|-- scripts/             # Developer or maintenance scripts
|   `-- run_with_env.sh  # Load local .env before running commands
|-- docs/                # Project documentation
`-- worktrees/           # Local Git worktrees, not project source
```

If the project is a Python package, prefer a `src/` layout:

```text
src/<package_name>/
tests/
```

## Git Workflow

- Create Codex task branches with the `codex/` prefix.
- Prefer branch-specific worktrees:

```sh
git worktree add worktrees/<branch-name> -b <branch-name>
```

- Check active worktrees before creating or removing one:

```sh
git worktree list
```

- Remove completed worktrees only after their work is merged or no longer
  needed:

```sh
git worktree remove worktrees/<branch-name>
git branch -d <branch-name>
```

- Keep changes scoped to the requested task.
- Preserve user changes. Do not rewrite, revert, or reformat unrelated files.
- Before committing or opening a PR, review `git status` and the diff.

## Project Setup

- Run `./setup.sh` after cloning, moving, copying, or creating a new worktree.
- Keep `setup.sh` idempotent so it is safe to run multiple times.
- Add project-specific setup to `setup.sh` as the project grows.
- Use a local virtual environment named `.venv/`.
- Do not install dependencies globally when a project-local environment is
  reasonable.
- Store Python dependencies in project metadata such as `pyproject.toml`, or in
  `requirements-dev.txt` / `requirements.txt` for simpler projects.
- `setup.sh` should create `.venv/` and install dependencies from the project
  metadata when present.
- Update `.python-version`, `pyproject.toml`, README, package directory names,
  and tests when copying this template into a real project.

Typical Python setup commands may be added once the project has dependency
metadata:

```sh
./setup.sh
. .venv/bin/activate
python -m pytest
```

## Python Conventions

- Target the Python version declared by the project. If none is declared, use a
  current stable Python 3 version and document it when adding project metadata.
- Prefer standard library functionality unless a dependency clearly improves the
  design.
- Use explicit, meaningful names for modules, functions, variables, and tests.
- Keep functions small enough to test and reason about.
- Separate pure logic from I/O, subprocess calls, network calls, and UI code
  where practical.
- Use type hints for public functions, dataclasses, protocols, and complex data
  structures.
- Prefer `pathlib.Path` over string path manipulation.
- Prefer structured data parsing and serialization libraries over ad hoc string
  manipulation.
- Handle errors deliberately. Do not hide failures with broad `except` blocks
  unless the fallback is intentional and tested.
- Add comments only where they explain non-obvious reasoning, constraints, or
  tradeoffs.

## Dependency Management

- Use one dependency source of truth for each project, such as `pyproject.toml`.
- Keep runtime dependencies separate from development dependencies.
- Pin or lock dependencies when reproducibility matters for the project.
- Avoid adding new dependencies for small utilities that are straightforward to
  implement with the standard library.
- Update `setup.sh`, README setup notes, and relevant tests when dependency
  installation changes.

## Secrets and Configuration

- Never commit real API keys, tokens, passwords, private keys, or credential
  files.
- Keep real local secrets in the project-local `.env`, `.env.*`, or `secrets/`;
  these paths are ignored by Git.
- Keep `.env.example` committed with variable names and safe placeholder values
  only.
- Prefer unique keys per project when the external service supports multiple
  keys.
- Add new required environment variables to `.env.example` and document their
  purpose in `docs/secrets.md` or `README.md`.
- Read secrets from environment variables in Python, typically with
  `os.environ["VARIABLE_NAME"]` for required values.
- Run API-backed commands through `./scripts/run_with_env.sh` so local `.env`
  values and `.venv/bin` tools are available without committing secrets.
- Do not print secrets in logs, test output, error messages, screenshots, or PR
  descriptions.
- Rotate any secret that may have been committed, exposed in logs, or pasted
  into a shared system.

## Formatting and Static Checks

Follow the project's configured tools. If no tools are configured yet, prefer
these Python defaults when introducing tooling and add the configuration to
`pyproject.toml`:

```sh
python -m ruff check .
python -m ruff format .
python -m mypy src
```

- Do not reformat unrelated files just because a formatter is available.
- Keep lint exceptions narrow and documented.
- Treat type-checking errors as design feedback rather than noise.

## Testing

- Add or update tests for behavior changes, bug fixes, and risky refactors.
- Prefer `pytest` for Python tests unless the project already uses another
  framework.
- Keep tests deterministic and isolated from external services by default.
- Use temporary directories and fixtures instead of writing into the repository
  during tests.
- Cover edge cases for parsing, validation, filesystem behavior, and error
  handling.

Typical test commands once the project has tests:

```sh
./scripts/run_with_env.sh python -m pytest
./scripts/run_with_env.sh python -m pytest tests/path/to/test_file.py
```

## Documentation

- Keep `README.md` accurate when setup, commands, or project behavior changes.
- Document new environment variables, required credentials, and external
  services.
- Include examples for public CLI commands, library entry points, and common
  workflows.
- Do not commit secrets, tokens, local machine paths, or private credentials.

## Pull Requests

When preparing a PR:

- Keep the PR focused on one concern.
- Summarize what changed and why.
- List the checks that were run.
- Mention follow-up work or known limitations.
- Include screenshots or terminal output only when they help verify the change.

## Agent Operating Rules

- Read existing files before changing them.
- Check for nested instruction files in the target path before editing files in
  a subdirectory.
- Prefer existing project patterns over new abstractions.
- Choose the smallest change that solves the requested problem cleanly.
- Ask for clarification only when a reasonable assumption would be risky.
- If a command fails, inspect the error before trying a broader workaround.
- Do not perform destructive Git or filesystem operations unless explicitly
  requested.
- Leave the workspace in a state that is easy for the user to inspect with
  `git status`, tests, and documented commands.
