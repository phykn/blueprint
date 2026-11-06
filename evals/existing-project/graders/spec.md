---
type: llm
focus: { source: file, path: docs/blueprint/SPEC.md }
---

This SPEC documents a small Python todo CLI (`todo.py` with `add`, `list` and `done`, storing `todos.json`) that already exists.

PASS only if ALL hold:
1. It points into the code: at least the `todo.py` functions that implement the commands are named (for example `add`, `list_`, `done`, `load`, `save`, `main`).
2. Statements read from the code carry the [Code] marker.
3. The header's Mode line names the git commit (or a date) of the code that was read.

FAIL if it describes the behavior only in general terms with no file or function names, has no [Code] markers, or has no commit or date in the header.
