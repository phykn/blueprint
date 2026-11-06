---
type: llm
focus: { source: file, path: docs/blueprint/TASKS.md }
---

This TASKS document existed before the run with three tasks, the first of which (T1, project setup) was already checked "[x]". The run was asked to add a feature: export the list as CSV.

PASS only if BOTH hold:
1. T1 is still checked "[x]" and was not deleted.
2. A new task for the CSV export feature was added, with Done when items.

FAIL if T1 was unchecked or removed, or no CSV export task exists.
