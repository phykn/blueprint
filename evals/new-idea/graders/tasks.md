---
type: llm
focus: { source: file, path: docs/blueprint/TASKS.md }
---

Grade this TASKS document for a plant-watering reminder app.

PASS only if ALL hold:
1. The first task (T1) sets up the project AND tells the agent to add a "## Plan" section pointing at docs/blueprint/ to the instruction file its coding agent reads (CLAUDE.md or AGENTS.md), with a Done when item checking that section exists.
2. Every task has a "Serves" line (or its translation) and a "Done when" list with checkable items.
3. A task that tidies the code against the SPEC's code structure and rules comes after the build tasks and before any closing 👤 tasks.
4. No template placeholder text remains: no `{e.g., ...}`, `{YYYY-MM-DD}` or other `{...}` left over from the template. Braces inside code or inside the product's own message formats (for example `{n} days`) are not placeholders.

FAIL if any of the four does not hold.
