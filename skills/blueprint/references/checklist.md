# Blueprint review checklist

The single test: **Could a coding agent that has never seen this conversation build the right thing from these documents alone, without asking or guessing?**

Use "Every document" and the section for the document you just wrote (see *Review gate* in SKILL.md), plus "Existing projects" when documenting one, then "Across documents" at the end. Fix what you can yourself; turn the rest into questions for the user, one at a time.

## Every document

- [ ] Numbers add up: counts, totals, splits, dates, and limits agree wherever they meet.
- [ ] Every default you chose is visible, listed under the PRD's Assumptions or marked [AI] in SPEC, and each one is a choice. Facts the user holds (how their work runs today, deadlines, budget, devices) came from the user or their files.
- [ ] Every value that must match existing data, files, or systems (names, IDs, status values, formats) was confirmed by the user or read from a definition, not inferred from a sample.

## PRD

- [ ] The problem is described before any solution.
- [ ] The core scenario is a concrete, step-by-step flow, not a feature list.
- [ ] Every requirement has an ID and a priority (Must / Later).
- [ ] No requirement names a technology, library, or algorithm. Those belong in SPEC.
- [ ] Every success criterion is checkable by a person or a test. No "easy", "fast", "intuitive", "good" without a number, a ratio, or an observable result.
- [ ] Out of scope lists at least the obvious temptations (things an agent might "helpfully" add).

### PRD — data projects

- [ ] Input data is described: amount, sizes, formats, and quirks (overlays, noise, missing values, mixed sources).
- [ ] Label or ground-truth format is defined: file format, how files are paired, class or ID numbering.
- [ ] Evaluation data exists, is separate from training data, and the numbers add up (e.g., held-out count vs. total available).
- [ ] The output format is fully specified, including size, value range, and any reserved values (e.g., 255 = ignore).
- [ ] Small-data or unreliable-label risks are written under Risks.

## SPEC

- [ ] Every Must requirement in the PRD is covered by at least one interface, pipeline step, or rule.
- [ ] Nothing in SPEC goes beyond the PRD (no features the PRD did not ask for).
- [ ] Each stack choice has a one-line reason.
- [ ] Data fields have types and key constraints (required, unique, limits).
- [ ] Error and edge cases are described for each interface.
- [ ] Non-obvious decisions are in the Decisions table with rejected alternatives.
- [ ] How to run and test the project is written down, or obviously the stack default.

### SPEC — ML projects

- [ ] The pipeline covers every input quirk from the PRD (sizes, formats, regions to ignore).
- [ ] The data split is fixed and reproducible (seed or explicit file list).
- [ ] Anything that can only be settled by experiment is under Open choices with candidates, comparison conditions, and a winner rule — not decided by guess.
- [ ] Hardware differences (e.g., CUDA vs. Apple Silicon) are handled explicitly.
- [ ] Where checkpoints, logs, and outputs go is defined.

## TASKS

- [ ] The first tasks produce a running, end-to-end slice or baseline.
- [ ] Each task is small enough for one agent session.
- [ ] Each task lists the requirement IDs it serves; every Must requirement appears in some task.
- [ ] Every interface and rule in SPEC is built by some task, including rules that apply everywhere, such as response headers or error messages.
- [ ] Every Open choice in SPEC has an experiment task that records the winner back into SPEC.
- [ ] Each task has "Done when" items that can be verified without judgment calls.
- [ ] Tasks do not depend on later tasks.
- [ ] Steps only a person can do are marked 👤 and say what the agent prepares before stopping.

## Existing projects

- [ ] Every interface, rule, and data structure in SPEC names the file and function that implement it, and each one exists.
- [ ] Each behavior claim was checked by running or reading the code, not inferred from names, comments, or the README.
- [ ] No bug or suspected bug is written as a requirement; each is a task or an Open question.
- [ ] Disagreements between the code and its README, comments, or tests are listed.
- [ ] Each document's header names the commit or date of the code it describes.
- [ ] Decisions give only reasons the user or the code history supplied.

## Across documents

- [ ] Names (screens, entities, fields, classes) are spelled the same in all three files.
- [ ] No document relies on the chat history to be understood.
- [ ] No contradictions (e.g., PRD says "no login", SPEC has a login screen).
- [ ] Each rule or value is defined in one place and referred to elsewhere by ID or section.
- [ ] Open questions are collected, not scattered or silently answered.
- [ ] Unused template sections and placeholder text (`{...}`) are removed.
