# Blueprint review checklist

The single test: **Could a coding agent that has never seen this conversation build the right thing from these documents alone, without asking or guessing?**

Use "Every document" and the section for each document (see *4. Review* in `SKILL.md`), plus "Existing project" or "From scratch" when that is where you started, then "Across documents". Fix what you can yourself; what needs the person's intent or an outside fact becomes an assumption or an Open question.

## Every document

- [ ] Numbers add up: counts, totals, splits, dates, and limits agree wherever they meet.
- [ ] Every decision the AI made is marked [AI] where it is written, with its reason in Decisions. Every fact nobody stated and no file settles is listed under the PRD's Assumptions, not presented as known.
- [ ] Every value that must match existing data, files, or systems (names, IDs, status values, formats) was read from a definition or given by the person, not inferred from a sample.

## PRD

- [ ] The Problem section opens with a one-sentence center, and the problem is described before any solution.
- [ ] The core scenario is a concrete, step-by-step flow, not a feature list.
- [ ] Every requirement has an ID, a priority (Must / Later), and a source marker.
- [ ] No requirement names a technology, library, or algorithm. Those belong in SPEC.
- [ ] Every success criterion is checkable by a person or a test. No "easy", "fast", "intuitive", "good" without a number, a ratio, or an observable result.
- [ ] Out of scope lists at least the obvious temptations (things an agent might "helpfully" add), each with a reason.

### PRD — data projects

- [ ] Input data is described: amount, sizes, formats, and quirks (overlays, noise, missing values, mixed sources).
- [ ] Label or ground-truth format is defined: file format, how files are paired, class or ID numbering.
- [ ] Evaluation data exists, is separate from training data, and the numbers add up (e.g., held-out count vs. total available).
- [ ] The output format is fully specified, including size, value range, and any reserved values (e.g., 255 = ignore).
- [ ] Small-data or unreliable-label risks are written under Risks.

## SPEC

- [ ] Every Must requirement in the PRD is covered by at least one interface, pipeline step, or rule.
- [ ] Nothing in SPEC goes beyond the PRD (no features the PRD did not ask for).
- [ ] Every stack choice has a row in Decisions.
- [ ] Data fields have types and key constraints (required, unique, limits).
- [ ] Each interface's Rules line names rules that exist in Rules and edge cases, and every error or edge case the interface can hit has one.
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
- [ ] T1 adds the plan pointer: the *Plan* section goes into the coding agent's instruction file, with a Done when item for it (in documents an earlier Blueprint wrote, the first unchecked task does this).
- [ ] Each task is small enough for one agent session.
- [ ] Each task lists the requirement IDs it serves; every Must requirement appears in some task.
- [ ] Every interface and rule in SPEC is built by some task, including rules that apply everywhere, such as response headers or error messages.
- [ ] Every Open choice in SPEC has an experiment task that records the winner back into SPEC.
- [ ] Each task has "Done when" items that can be verified without judgment calls.
- [ ] Tasks do not depend on later tasks.
- [ ] Steps only a person can do are marked 👤 and say what the agent prepares before stopping.

## Existing project

- [ ] Every interface, rule, and data structure in SPEC names the file and function that implement it, and each one exists.
- [ ] Each behavior claim was checked by running or reading the code, not inferred from names, comments, or the README.
- [ ] No bug or suspected bug is written as a requirement; each is a task or an Open question.
- [ ] Disagreements between the code and its README, comments, or tests are listed.
- [ ] Each document's header names the commit or date of the code it describes.
- [ ] Decisions give only reasons the person or the code history supplied.

## From scratch

- [ ] The PRD is built from the core idea (problem, users, outcome), not from the old feature list.
- [ ] Every outside contract found in the old project (formats others read or write, stored data, API fields, called commands, shared IDs) is kept as a requirement, or changed by a decision in SPEC with its reason and cost; stored data has a migration.
- [ ] Every old feature that was dropped is under Out of scope with a reason.
- [ ] Every bug or pain point found in the old project is a requirement or a check in the new plan.
- [ ] Each reuse of the old stack or structure is in Decisions with a reason of its own.
- [ ] Each document's header names the commit or date of the old code that was read.
- [ ] SPEC Decisions says where the new code goes so the old version keeps working; the first task sets it up and the last task is a 👤 switch-over.
- [ ] Each kept contract has a task that checks it against the old version; each changed contract has a transition (migration, old form still accepted for a while after the switch-over) with a task that checks it.

## Across documents

- [ ] Every part of the PRD's center sentence is answered by the plan; no part of it was dropped or traded for an easier problem.
- [ ] Every claim built on a repeated pattern was confirmed in the files, not only inferred.
- [ ] Names (screens, entities, fields, classes) are spelled the same in all three files.
- [ ] No document relies on the chat history to be understood.
- [ ] No contradictions (e.g., PRD says "no login", SPEC has a login screen).
- [ ] Each rule or value is written out in one section only; every other mention, in the same document or another, refers to it by ID or section.
- [ ] Each kind of statement sits only where the ownership table in `references/writing.md` puts it.
- [ ] Open questions are collected, not scattered or silently answered.
- [ ] Unused template sections and placeholder text (`{...}`) are removed.

## Fresh reader

Used by *4. Review* in `SKILL.md`. Give the subagent only the three documents (From scratch: also the old code at the header's commit) and have it review, not build, listing every point where it would have to guess or ask. Keep that question open: the reader's job is to find what lies outside your frame, so do not narrow it to the places you already doubt.

- Check facts by script before you start it: the line numbers, counts, quotes, paths, command options, and data on this machine that the documents claim. Hand the reader the results as an "already checked" list so it does not check them again.
- Cap its answer at about 800 to 1,500 words.
- A rerun after fixes reviews only what changed, with the earlier findings and their fixes.
- If the review runs long, do not restart it; message it to report what it has found so far.
