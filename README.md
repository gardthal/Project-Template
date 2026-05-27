# Test Project

Workspace for project code.

## Git Worktree Workflow

Keep this directory as the primary checkout, then create task branches in sibling worktrees:

```sh
git worktree add ../test-project-worktrees/<branch-name> -b <branch-name>
```

List worktrees:

```sh
git worktree list
```

Remove a worktree after the branch is merged or no longer needed:

```sh
git worktree remove ../test-project-worktrees/<branch-name>
git branch -d <branch-name>
```

Use branch names like `codex/my-task` for Codex work and `feature/my-task` for longer-lived feature work.
