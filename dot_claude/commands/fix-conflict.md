---
description: Fix git conflicts during rebase or merge
allowed-tools: Bash(git:*), Bash(gh:*), Read, Edit, AskUserQuestion
---

Your task is to fix git conflicts.

1. Get context about the goal of the branch (use branch name, commit message, and `gh` to check for open PRs)
2. If necessary, use the AskUserQuestion tool to clarify the context
3. After the conflict is fixed, use `gt continue` to continue rebasing

Loop to step 1 until all conflicts are fixed.

Present a summary of your actions to the user and the SHA to revert all rebases.
