---
type: llm
focus: { source: file, path: docs/blueprint/PRD.md }
---

Grade this PRD for a plant-watering reminder app.

PASS only if ALL hold:
1. The Problem section opens with a one-sentence statement of the center of the problem (a line beginning with a bold "Center:" or an equivalent single sentence) before any solution is described.
2. There is a requirements table where every row has an ID (R1, R2, ...), a priority (Must or Later) and a source marker ([User], [AI] or [Code]).
3. Every success criterion is checkable: it names a number, a ratio, or an observable result, not just "easy", "fast" or "good".
4. Assumptions are collected under one Assumptions section and open questions, if there are any, under one Open questions section, not scattered through the text. Having no open questions and no such section is fine.
5. No template placeholder text remains: no `{e.g., ...}`, `{YYYY-MM-DD}` or other `{...}` left over from the template. Braces inside code or inside the product's own message formats (for example `{n} days`) are not placeholders.

FAIL if any of the five does not hold.
