# PRD: {Product or feature name}

> Product Requirements Document. Explains **why** we are building this and **what** it must do. It does not say how.
> Mode: New | Document (of `{commit}`) | Rebuild (from `{commit}`) — Last updated: {YYYY-MM-DD}
>
> Markers: **[User]** said by the person · **[AI]** decided by the AI · **[Code]** read from existing code or files. Any [AI] item can be overridden.

## Summary

{One or two sentences: what this is and who it is for.}

## Problem

**Center:** {One sentence: the problem, what pulls against what, the purpose, what it is bound by, and what the person is dissatisfied with, as far as they show. e.g., "Customers want to reserve bread fast, but the shop must never promise more than it bakes, and today phone orders get lost."}

{Who has the problem, what they do today, and why that is painful. Concrete examples beat general statements. Every other section serves the center.}

## Users

| User | What they want to do |
|---|---|
| {e.g., Shop owner} | {e.g., See today's orders on their phone} |

## Core scenario

{The main flow from start to finish, as numbered steps from the user's point of view.}

1. {User opens ...}
2. {...}
3. {...}

## Data and evaluation

> Keep this section when the project learns from or processes data (ML models, data pipelines, analysis). Delete it otherwise.

| Item | Details |
|---|---|
| Input data | {kind, how many, sizes, file formats, quirks such as overlays or noise} |
| Labels / ground truth | {format, how files are paired, class or ID numbering (confirmed with the user), reliability} |
| Evaluation data | {which data is used to judge results, how it is kept separate from training data} |
| Evaluation method | {metric or review procedure} |
| Output | {format and what consumes it} |

## Requirements

Each requirement has an ID so SPEC and TASKS can refer to it. Use **Must** for the first version and **Later** for things that can wait. Requirements say *what*, not *how*: technologies, libraries, and algorithms belong in SPEC.

| ID | Requirement | Priority | Source |
|---|---|---|---|
| R1 | {e.g., A user can add an item with a name and a price} | Must | [User] |
| R2 | {e.g., Existing `orders.csv` files load without changes} | Must | [Code] |
| R3 | {...} | Later | [AI] |

## Success criteria

How we know the first version is done. Each line must be checkable by a person or a test. Subjective checks need a count or ratio (e.g., "an expert prefers the output in at least 8 of 10 images").

- [ ] {e.g., A new user can sign up and add their first item in under 2 minutes}
- [ ] {...}

## Out of scope

Things we are deliberately **not** doing in this version, each with a one-line reason. The coding agent must not build these. In Rebuild mode, every dropped old feature is listed here.

- {e.g., Payments} — {e.g., orders are paid in person today}
- {e.g., Multiple languages} — {...}

## Constraints

{Deadline, budget, required platforms, hardware, or tools, privacy or legal requirements. Delete this section if there are none.}

## Risks

{Things that could make the project fail or the results untrustworthy. e.g., "With only 10 labeled images, evaluation uses 2 images." Delete if none.}

## Assumptions

Facts nobody stated and no file settles, filled with the likeliest value. Decisions are not listed here; they carry their [AI] marker where they are written. Correct any assumption that is wrong.

- {e.g., Only one person uses the app at a time}

## Open questions

- {Question} — {why it matters, and what the documents assume until it is answered}

## Change log

- {YYYY-MM-DD}: Created.
