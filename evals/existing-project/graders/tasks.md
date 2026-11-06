---
type: llm
focus: { source: file, path: docs/blueprint/TASKS.md }
---

This TASKS document is for a small Python todo CLI whose `done N` command has an off-by-one bug (it marks the task listed as N-1, and `done 1` fails).

PASS only if there is a task that fixes the `done` bug AND that task says to write a regression test that fails before the fix (a failing test first, then the fix), with a Done when item that the test passes.

FAIL if no task fixes the bug, or the fix task has no failing-first regression test.
