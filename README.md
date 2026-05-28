# Project Template

Python project template for Codex-assisted development.

## Directory Layout

All projects should live under:

```text
~/Documents/Codex/
```

This template lives at:

```text
~/Documents/Codex/Template Project/
```

## Git Worktree Workflow

Keep this directory as the primary checkout on `main`, then create task branches in `worktrees/`:

```sh
git worktree add worktrees/<branch-name> -b <branch-name>
```

List worktrees:

```sh
git worktree list
```

Remove a worktree after the branch is merged or no longer needed:

```sh
git worktree remove worktrees/<branch-name>
git branch -d <branch-name>
```

Use branch names like `codex/my-task` for Codex work and `feature/my-task` for longer-lived feature work.

## Setup

Run:

```sh
./setup.sh
```

Setup creates a local Python virtual environment in `.venv/` and installs
dependencies when project metadata is present. It checks for `pyproject.toml`,
then `requirements-dev.txt`, then `requirements.txt`.

Setup creates a local `.env` from `.env.example` if one does not already exist.
Fill `.env` with real API keys or other secrets before running code that needs
them. See `docs/secrets.md` for the full secrets workflow.

Activate the virtual environment manually when you want an interactive shell:

```sh
. .venv/bin/activate
```

Run commands that need project secrets through:

```sh
./scripts/run_with_env.sh python -m your_package
```

The runner loads `.env` and prefers `.venv/bin` automatically when `.venv/`
exists.

## Development

See `docs/development.md` for the starter checklist, common commands, and
dependency update workflow.

## CI

GitHub Actions runs lint, formatting checks, and tests on pushes to `main` and
on pull requests.

## License

This template is available under the MIT License. Update `LICENSE` after copying
the template if a project needs different terms.
