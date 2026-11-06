---
type: llm
focus: { source: file, path: docs/blueprint/PRD.md }
---

This PRD plans a from-scratch rebuild of a small Python todo CLI (`todo.py` with add/list/done, `todos.json`, a `report.py` that reads that file, an unused `export_html()` function and a `--color` flag).

PASS only if ALL hold:
1. The plan starts from the core idea (keeping a personal todo list from the terminal), not from a copy of the old feature list.
2. At least one old feature that the core idea does not need (for example `export_html`, `--color`, or `report.py`) is listed under Out of scope with a one-line reason.
3. The header's Mode line names the commit (or date) of the old code that was read.

FAIL if any of the three does not hold.
