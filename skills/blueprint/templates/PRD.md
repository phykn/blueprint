# PRD: {Product or feature name}

> Product Requirements Document. Explains **why** we are building this and **what** it must do. It does not say how.
> Status: Draft | Confirmed — Last updated: {YYYY-MM-DD}

## 1. Summary

{One or two sentences: what this is and who it is for.}

## 2. Problem

{Who has the problem, what they do today, and why that is painful. Concrete examples beat general statements.}

## 3. Users

| User | What they want to do |
|---|---|
| {e.g., Shop owner} | {e.g., See today's orders on their phone} |

## 4. Core scenario

{The main flow from start to finish, as numbered steps from the user's point of view.}

1. {User opens ...}
2. {...}
3. {...}

## 5. Data and evaluation

> Keep this section when the project learns from or processes data (ML models, data pipelines, analysis). Delete it otherwise.

| Item | Details |
|---|---|
| Input data | {kind, how many, sizes, file formats, quirks such as overlays or noise} |
| Labels / ground truth | {format, how files are paired, class or ID numbering (confirmed with the user), reliability} |
| Evaluation data | {which data is used to judge results, how it is kept separate from training data} |
| Evaluation method | {metric or review procedure} |
| Output | {format and what consumes it} |

## 6. Requirements

Each requirement has an ID so SPEC and TASKS can refer to it. Use **Must** for the first version and **Later** for things that can wait. Requirements say *what*, not *how*: technologies, libraries, and algorithms belong in SPEC.

| ID | Requirement | Priority |
|---|---|---|
| R1 | {e.g., A user can add an item with a name and a price} | Must |
| R2 | {...} | Must |
| R3 | {...} | Later |

## 7. Success criteria

How we know the first version is done. Each line must be checkable by a person or a test. Subjective checks need a count or ratio (e.g., "an expert prefers the output in at least 8 of 10 images").

- [ ] {e.g., A new user can sign up and add their first item in under 2 minutes}
- [ ] {...}

## 8. Out of scope

Things we are deliberately **not** doing in this version. The coding agent must not build these.

- {e.g., Payments}
- {e.g., Multiple languages}

## 9. Constraints

{Deadline, budget, required platforms, hardware, or tools, privacy or legal requirements. Delete this section if there are none.}

## 10. Risks

{Things that could make the project fail or the results untrustworthy. e.g., "With only 10 labeled images, evaluation uses 2 images." Delete if none.}

## 11. Assumptions

Gaps filled with a default instead of a user decision, including anything the skill proposed. Confirm or change these.

- {e.g., Assumed only one person uses the app at a time}

## 12. Open questions

- {Question} — {who decides, if known}

## Change log

- {YYYY-MM-DD}: Created.
