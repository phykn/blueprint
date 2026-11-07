---
type: llm
focus: { source: file, path: docs/blueprint/TASKS.md }
---

This TASKS document plans a from-scratch rebuild of a small Python todo CLI.

PASS only if ALL hold:
1. The first task creates the place for the new code (by default a new branch in the same folder; a new folder or worktree is also fine) and adds the "## Plan" pointer section to the instruction file in that place. If it uses a new folder or worktree, it also copies docs/blueprint/ there.
2. The last task is marked 👤 (a person-only task) and is the switch-over from the old version to the new one.

FAIL if the first task does not create the new place with the pointer (and, for a new folder, the copied docs), or the last task is not a 👤 switch-over.
