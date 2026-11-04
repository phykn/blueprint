# TASKS: {Product or feature name}

> Ordered work plan. A coding agent should do **one task at a time**, top to bottom, and check it off when its "Done when" items pass.
> Read `PRD.md` and `SPEC.md` before starting any task.
> Tasks marked 👤 need a person. The agent prepares what the person needs, then stops; it does not fake the result. When a later session finds a 👤 task first, the agent asks whether the person has done it, checks what it can, and checks the task off once they confirm.

## How to use

Tell your coding agent:

> Read docs/blueprint/PRD.md, docs/blueprint/SPEC.md and docs/blueprint/TASKS.md. Do the first unchecked task only. When finished, verify every "Done when" item, check the task off, and stop.

## Tasks

### [ ] T1. {Project setup}

- Serves: —
- Do: {e.g., Create the project with the stack in SPEC §2 and make it run locally.}
- Done when:
  - [ ] {e.g., `npm run dev` starts and the home page shows the app name}

### [ ] T2. {Thin end-to-end slice or simple baseline}

- Serves: R1
- Do: {The smallest version of the main flow that works from input to output.}
- Done when:
  - [ ] {A checkable result}

### [ ] T3. {Experiment: settle an Open choice from SPEC §5}

- Serves: R2
- Do: {Run each candidate under the comparison conditions in SPEC.}
- Done when:
  - [ ] {Results for every candidate are saved to `{path}`}
  - [ ] {The winner is chosen by the rule in SPEC and recorded in SPEC Decisions}

### [ ] T4. {...}

- Serves: R3
- Do: {...}
- Done when:
  - [ ] {...}

### [ ] 👤 T5. {Step only a person can do, e.g., expert review}

- Serves: {success criterion}
- Do: {What the person does. The agent prepares the inputs and stops.}
- Done when:
  - [ ] {The person's result meets the criterion}
  - [ ] {What to record if it doesn't}
