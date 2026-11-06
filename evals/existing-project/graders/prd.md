---
type: llm
focus: { source: file, path: docs/blueprint/PRD.md }
---

This PRD documents a small Python todo CLI whose `done N` command marks the task listed as N-1 (and `done 1` fails), while its README says `done N` marks task N.

PASS only if BOTH hold:
1. No requirement describes the off-by-one behavior as intended: the requirement for `done` says it marks task N (the task the list shows with number N), or the behavior appears only as a finding, open question or risk.
2. The mismatch between the README and the code (or between intended and actual `done` behavior) is written down somewhere in the document, for example under Problem, Risks or Open questions.

FAIL if a requirement says `done N` marks task N-1, or if the mismatch is not mentioned at all.
