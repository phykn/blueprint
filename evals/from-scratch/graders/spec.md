---
type: llm
focus: { source: file, path: docs/blueprint/SPEC.md }
---

This SPEC plans a from-scratch rebuild of a small Python todo CLI whose `todos.json` file is read by another program (`report.py`), so that file format is an outside contract.

PASS only if ALL hold:
1. The `todos.json` format is handled as a contract: either it is kept (the SPEC points to a requirement that keeps it, or states it is kept) or it is changed by a decision that includes a transition (a migration of existing data and/or accepting the old format for a while).
2. The old code is pointed to at its git commit (a commit hash in the header or where checks compare against it).
3. The SPEC says where the new code will live (for example a new folder, branch or worktree next to the old one).

FAIL if any of the three does not hold.
