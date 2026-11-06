# Writing the documents

Rules for *3. Write* in `SKILL.md`: PRD, then SPEC, then TASKS, each from its template.

- **Write for an agent that has never met the person.** Every document must make sense with no chat history. Write the PRD so the person can read it too, in plain words; SPEC and TASKS are for the coding agent and may be technical.
- **Testable over descriptive.** "Fast" is not a requirement; "the list loads in under 1 second with 1,000 items" is. Subjective checks (e.g., expert judgment) need a count or ratio that decides pass or fail.
- **Say what not to do.** Out of scope lists what an agent might helpfully add.
- **Record the why.** Agents undo decisions they don't understand. Each non-obvious decision gets its reason and the alternatives it beat, in SPEC *Decisions*.
- **Say each thing once**, in the place that owns it (the table below), and refer to it everywhere else by ID or section heading, within the same document too, because copies drift apart. A "Done when" item may quote the value it checks.
- **Small beats complete.** Delete template sections that don't apply instead of filling them. Headings carry no numbers, so deleting one breaks nothing; refer to a section by its heading.
- A technical decision that changes what the person gets (e.g., inference now needs labels as input) belongs in the PRD, marked [AI].
- **Data projects** (ML models, pipelines, analysis): the PRD defines the input data, labels or ground truth, evaluation data kept separate from training data (check that the counts add up), and the output format and what consumes it.
- **TASKS**: start with a thin end-to-end slice or a simple baseline, then improve. Each task fits one agent session, produces something runnable or checkable, names the requirement IDs it serves, and has "Done when" items a command or a person can verify. Each Open choice becomes an experiment task that records the winner in SPEC Decisions. Mark 👤 the steps only a person can do: expert judgment, a device the agent can't reach, getting data or credentials, deploying, or switching a live system over. Place them where they block as little as possible.
- **T1 keeps the plan pointer.** The template's first task ends with the step that adds the *Plan* section to the coding agent's instruction file, and a Done when item for it. Keep both in every plan, with the file name the project needs, even when T1 has nothing else to do.

## Where each kind of statement lives

| Kind of statement | Lives in | Everywhere else |
|---|---|---|
| The center sentence | PRD *Problem*, first line | Checked against, never restated |
| Requirements (what) | PRD *Requirements* table, `R1`… | SPEC and TASKS point to the ID |
| Assumptions about the world | PRD *Assumptions* | — |
| Questions for the person | PRD *Open questions*; SPEC *Open questions* holds technical questions only | — |
| Stack and structure choices | SPEC *Tech stack* and *Overview*, choices only | Reasons in *Decisions* |
| Rules and edge cases | SPEC *Rules and edge cases*, one bullet per rule under a bold name | Interfaces name the rule |
| Reasons and rejected alternatives | SPEC *Decisions* table | — |
| What only an experiment settles | SPEC *Open choices* | TASKS experiment tasks name the item |
| Order and checks | TASKS *Tasks*, Done when items | — |

## Earlier documents

Documents an earlier Blueprint wrote are updated in place, whatever version wrote them (*What it writes* in `SKILL.md`):

- Drop the numbers from the headings of any section you touch; older templates numbered them.
- A header without a Mode line (older versions wrote `Status: Draft | Confirmed`) gets the template's Mode line; replace the Status line and the marker line with the template's.
- If `docs/blueprint/` is missing but `docs/PRD.md`, `docs/SPEC.md` and `docs/TASKS.md` all exist, the first Blueprint wrote them: move them into `docs/blueprint/`, create its `.gitignore`, and say so in the report.
- Keep checked tasks checked, keep the Change log, and add a line to it.
- If no task carries the *Plan* section (older templates had none), the first unchecked task gets that step and its Done when item, as *T1 keeps the plan pointer* says.
