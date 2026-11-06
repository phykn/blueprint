---
type: llm
focus: { source: file, path: docs/blueprint/PRD.md }
---

This PRD existed before the run, written by an older Blueprint for a small todo CLI (requirements R1 add, R2 list, R3 done; numbered headings such as "## 6. Requirements"; a "Status: Confirmed" header line; a Change log with one line dated 2025-06-01). The run was asked to add a feature: export the list as CSV.

PASS only if ALL hold:
1. The old content continues: the todo requirements for add, list and done are still present (it was updated in place, not replaced by an unrelated document).
2. The Change log has a new line after the 2025-06-01 line.
3. A new requirement row for CSV export was added (for example R4).
4. The header has a Mode line that reads "Mode: New" (the "Status:" line is gone or replaced).
5. The headings of sections that were changed (at least Requirements and Change log) carry no numbers, for example "## Requirements" rather than "## 6. Requirements".

FAIL if any of the five does not hold.
