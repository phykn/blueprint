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

## Open questions

Technical questions only; questions for the person are in the PRD.

- {...}
