---
type: llm
focus: { source: file, path: docs/blueprint/SPEC.md }
---

Grade this SPEC for a plant-watering reminder app.

PASS only if ALL hold:
1. The Tech stack table has no "Why" or "Reason" column: it lists areas and choices only.
2. Reasons for choices and rejected alternatives appear only in the Decisions table, not repeated next to the choices elsewhere.
3. Each interface (screen, command or endpoint) entry has a "Rules:" line that names rules written out in the Rules and edge cases section, instead of restating error handling inline.
4. A Code structure section names each module or folder with what it owns and what it uses, and a Code rules section lists the rules every task follows.
5. No template placeholder text remains: no `{e.g., ...}`, `{YYYY-MM-DD}` or other `{...}` left over from the template. Braces inside code or inside the product's own message formats (for example `{n} days`) are not placeholders.

FAIL if any of the five does not hold.
