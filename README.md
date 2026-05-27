# Test Project

Workspace for project code.

## Directory Layout

All projects should live under:

```text
~/Documents/Codex/
```

This project lives at:

```text
~/Documents/Codex/Test Project/
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

Setup creates a local `.env` from `.env.example` if one does not already exist.
Fill `.env` with real API keys or other secrets before running code that needs
them. See `docs/secrets.md` for the full secrets workflow.
