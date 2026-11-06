---
type: llm
focus: { source: file, path: docs/blueprint/PRD.md }
---

PASS if the document is written in Korean: its headings and prose are Korean (code identifiers, file paths and technology names may stay in English), AND it contains no unfilled template placeholder such as `{...}`, `{e.g., ...}` or a `{YYYY-MM-DD}` date.
FAIL if the headings or most of the prose are in English, or any `{...}` placeholder text from a template is still present.
