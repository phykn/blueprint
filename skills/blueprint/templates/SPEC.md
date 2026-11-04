# SPEC: {Product or feature name}

> Technical specification. Explains **how** the requirements in `PRD.md` will be built, in enough detail that a coding agent can start without guessing.
> Status: Draft | Confirmed — Last updated: {YYYY-MM-DD}
>
> Markers: **[User]** decided by the user · **[AI]** a technical decision the AI made because the user can't be expected to judge it. [AI] items can be overridden at any time.

## 1. Overview

{One paragraph: the shape of the system. e.g., "A web app with a single page front end and a small database." or "A Python package with a training script and a batch inference script."}

## 2. Tech stack

| Area | Choice | Why |
|---|---|---|
| {e.g., Language / framework} | {e.g., Python, PyTorch} | {one-line reason} |
| {e.g., Data storage} | {e.g., SQLite} | {...} |
| {e.g., Runtime} | {e.g., Local GPU} | {...} |

## 3. Interfaces

How people or programs use the system: screens, commands, API endpoints. Reference requirement IDs. Keep the subsections that apply.

### {Screen or command name} — R1, R2

- Input: {what the user provides, e.g., arguments, form fields}
- Output: {what they get, including file names and formats}
- Errors and edge cases: {what happens with no data, bad input, or failures}

## 4. Data

The things the system reads, stores, or writes, and their structure.

### {Entity or file type}

| Field | Type | Notes |
|---|---|---|
| {name} | {text} | {required, max 100 characters} |

## 5. Model and training

> Keep this section for ML projects. Delete it otherwise.

### Pipeline

{Preprocessing → model → postprocessing, step by step. Include how inputs of different sizes and formats are handled, and what is excluded or ignored.}

### Fixed choices

| Item | Choice | Why |
|---|---|---|
| {e.g., Starting point} | {e.g., ImageNet-pretrained encoder} | {...} |
| {e.g., Data split} | {e.g., 20% held out before training, fixed seed} | {...} |

### Open choices

Choices that can only be settled by experiment. Each becomes an experiment task in TASKS.md; the winner moves to Decisions.

| Item | Candidates | How compared | Rule that picks the winner |
|---|---|---|---|
| {e.g., Architecture} | {A, B} | {same split, same epochs} | {higher score on held-out data; ties → smaller model} |

### Artifacts

{Where checkpoints, logs, and outputs are saved, and how they are named, so runs can be compared and reproduced.}

## 6. Rules and edge cases

{Behaviour that is easy to get wrong: validation, permissions, limits, duplicates, time zones, reserved values, etc.}

- {e.g., Prices are stored in cents as integers to avoid rounding errors}

## 7. Decisions

Why things are the way they are, so nobody undoes them by accident.

| Decision | Reason | Rejected alternatives |
|---|---|---|
| {e.g., No login in v1} | {Only one user; keeps setup simple} | {Email login} |

## 8. Project conventions

{Folder layout, naming, formatting, how to run and test the project. Delete what the stack's defaults already cover.}

- Run: `{command}`
- Test: `{command}`

## 9. Open questions

- {...}
