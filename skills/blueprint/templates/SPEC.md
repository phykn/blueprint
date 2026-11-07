# SPEC: {Product or feature name}

> Technical specification. Explains **how** the requirements in `PRD.md` will be built, in enough detail that a coding agent can start without guessing.
> Mode: New | Existing (of {commit}) | From scratch (from {commit}) — Last updated: {YYYY-MM-DD}
>
> Markers: **[User]** said by the person · **[AI]** decided by the AI · **[Code]** read from existing code or files. Any [AI] item can be overridden.

## Overview

{One paragraph: the shape of the system. e.g., "A web app with a single page front end and a small database." or "A Python package with a training script and a batch inference script."}

## Tech stack

Choices only; their reasons are in *Decisions*.

| Area | Choice |
|---|---|
| {e.g., Language / framework} | {e.g., Python, PyTorch} |
| {e.g., Data storage} | {e.g., SQLite} |
| {e.g., Runtime} | {e.g., Local GPU} |

## Interfaces

How people or programs use the system: screens, commands, API endpoints. Reference requirement IDs. Keep the subsections that apply.

### {Screen or command name} — R1, R2

- Input: {what the user provides, e.g., arguments, form fields}
- Output: {what they get, including file names and formats}
- Rules: {the names of the rules in *Rules and edge cases* that apply here, e.g., *Empty list*, *Duplicate name*; the rules themselves are written only there}
- Code: {file and function that implement it, once the code exists}

## Data

The things the system reads, stores, or writes, and their structure.

### {Entity or file type}

| Field | Type | Notes |
|---|---|---|
| {name} | {text} | {required, max 100 characters} |

## Model and training

> Keep this section for ML projects. Delete it otherwise.

### Pipeline

{Preprocessing → model → postprocessing, step by step. Include how inputs of different sizes and formats are handled, and what is excluded or ignored.}

### Fixed choices

Choices only; their reasons are in *Decisions*.

| Item | Choice |
|---|---|
| {e.g., Starting point} | {e.g., ImageNet-pretrained encoder} |
| {e.g., Data split} | {e.g., 20% held out before training, fixed seed} |

### Open choices

Choices that can only be settled by experiment. Each becomes an experiment task in TASKS.md; the winner moves to Decisions.

| Item | Candidates | How compared | Rule that picks the winner |
|---|---|---|---|
| {e.g., Architecture} | {A, B} | {same split, same epochs} | {higher score on held-out data; ties → smaller model} |

### Artifacts

{Where checkpoints, logs, and outputs are saved, and how they are named, so runs can be compared and reproduced.}

## Rules and edge cases

Behaviour that is easy to get wrong: validation, permissions, limits, duplicates, time zones, reserved values, errors and empty states. Each rule is written here once, under a bold name that the interfaces refer to.

- **{Rule name}**: {e.g., **Prices**: stored in cents as integers to avoid rounding errors}
- **{Empty list}**: {e.g., the list screen shows "Nothing yet" and the add button}

## Decisions

Why things are the way they are, so nobody undoes them by accident. This table is the only place reasons and rejected alternatives are written. Name each choice and, in parentheses, the section that defines it.

| Decision | Reason | Rejected alternatives |
|---|---|---|
| {e.g., No login in v1} (*Interfaces*) [AI] | {Only one user; keeps setup simple} | {Email login} |
| {e.g., SQLite} (*Tech stack*) [AI] | {One file, no server to run} | {Postgres} |

## Project conventions

{Folder layout, naming, formatting, how to run and test the project. Delete what the stack's defaults already cover.}

- Run: `{command}`
- Test: `{command}`

### Code structure

{Each module or folder, the one thing it owns, and what it may use. Dependencies point one way, with no cycles; nothing uses the entry point. Existing mode: the structure as it is, marked [Code].}

| Module | Owns | Uses |
|---|---|---|
| `{e.g., app/store.py}` | {Reading and writing `todos.json`} | {nothing} |
| `{e.g., app/cli.py}` | {Commands and their output} | {`store`} |

### Code rules

Every task follows these, so the code needs no separate cleanup; the tidy task checks them across all of it.

- Write the least code that does the task clearly. Add no option, wrapper, or layer that no caller needs yet.
- Put code in the module that owns it in *Code structure*. Add a helper only for a real concept or for code used in more than one place; one-use code stays with its owner.
- Name things by what they do, with the domain's terms, and one name per thing across modules.
- Comments say only why: a constraint or decision the code cannot show.
- Handle an error only where a real failure can happen or input comes from outside. No catch-all handlers, silent fallbacks, or checks for states the code cannot reach.
- When a task makes earlier code duplicated or unused, remove it in the same task. Leave no unused code, debug output, or commented-out code.

## Open questions

Technical questions only; questions for the person are in the PRD.

- {...}
