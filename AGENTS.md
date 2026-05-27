# Agent Instructions

## Workspace Layout

- Put all projects under `~/Documents/Codex/`.
- Keep each project self-contained in its own folder.
- Keep Git worktrees inside the project folder under `worktrees/`.
- Treat the project root checkout as the stable `main` checkout.
- Do task work in a branch-specific worktree, usually under `worktrees/<branch-name>/`.

## Git Workflow

- Create Codex task branches with the `codex/` prefix.
- Prefer:

```sh
git worktree add worktrees/<branch-name> -b <branch-name>
```

- Check worktrees with:

```sh
git worktree list
```

- Remove completed worktrees with:

```sh
git worktree remove worktrees/<branch-name>
git branch -d <branch-name>
```

## Project Setup

- Run `./setup.sh` after cloning, moving, or creating a new worktree.
- Keep setup idempotent so it is safe to run multiple times.
- Add project-specific dependency installation to `setup.sh` as the project grows.

## Engineering Defaults

- Keep changes scoped to the requested task.
- Preserve user changes and do not rewrite unrelated files.
- Prefer existing project patterns over new abstractions.
- Add tests when behavior changes or risk increases.
