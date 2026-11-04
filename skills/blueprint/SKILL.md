---
name: blueprint
description: Turns a rough app, feature, or ML model idea into documents an AI coding agent can build from without guessing — a PRD (why and what), a SPEC (how), and TASKS (ordered, verifiable steps) — or reads a project that already exists and writes the same documents for it, so people and agents can understand, debug, and improve it. Use when the user wants to start vibe coding, plan a new app, feature, or model, write a PRD/spec/requirements, or document an existing codebase, or says things like "I have an idea for an app", "help me plan this before coding", "write docs so Claude/Codex can build it", "이 프로젝트 블루프린트로 정리해 줘", or "document this project so I can understand it". Not for a quick explanation of one piece of code. Works for non-developers.
---

# Blueprint

In vibe coding, the AI writes the code. The human's job is the blueprint: deciding **why**, **what**, and **what done looks like**. This skill helps the user write that blueprint, either for something new or for a project that already exists (see *From an existing project*).

The output is three Markdown files in the user's project. Paths under `templates/` and `references/` are in this skill's folder.

| File | Answers | Template |
|---|---|---|
| `docs/blueprint/PRD.md` | Why build it, for whom, what success looks like, what is out of scope | `templates/PRD.md` |
| `docs/blueprint/SPEC.md` | How it will be built: stack, data, screens or model, decisions and their reasons | `templates/SPEC.md` |
| `docs/blueprint/TASKS.md` | Ordered, small tasks an agent can do one at a time, each with a check | `templates/TASKS.md` |

**The documents stay on the user's machine.** Before writing the first one, create `docs/blueprint/.gitignore` containing the single line `*`, so git ignores the whole folder without changing the project's own `.gitignore`. Never commit, push, or upload these files unless the user explicitly asks.

## Principles

- **The user owns the decisions; you own the structure.** Never silently invent requirements. If you fill a gap with a default, mark it as an assumption so the user can see and change it.
- **Never guess values that must match existing things.** Class or label IDs, column names, status names, file naming rules, formats, units, API fields: if the value has to match data, files, or systems that already exist, ask. Do not pick one and move on, even if it seems obvious. A data sample shows which values occur, not every value that exists: confirm a full list (all statuses, all classes) with the user unless a definition or schema in the files gives it.
- **Write for an agent that has never met the user.** Every document must make sense with no chat history. If a sentence only makes sense because of the conversation, rewrite it.
- **Testable over descriptive.** "Fast" is not a requirement; "the list loads in under 1 second with 1,000 items" is. Subjective checks (e.g., expert judgment) must still have a count or ratio that decides pass or fail.
- **Say what not to do.** Out-of-scope items prevent more wasted work than in-scope items.
- **Record the why behind decisions.** Agents (and people) undo decisions they don't understand.
- **Small beats complete.** A short, correct document beats a long, padded one. Say each thing once, in the document that owns it (PRD: what; SPEC: how; TASKS: order and checks), and refer to it elsewhere by ID or section, because copies drift apart; a "Done when" item may still quote the value it checks. Delete template sections that don't apply instead of filling them with filler.

## Language

- Write the documents in the language the user is speaking. Keep code identifiers, file paths, and technology names in their original form.
- Headings in the templates are in English; translate them into the user's language.

## Audience: assume a non-developer may be using this

- Ask questions in plain language. Instead of "What's your auth strategy?", ask "Do people need to log in? If so, with email, Google, or something else?"
- Explain a technical term the first time you use it, in one short clause.
- If the user is clearly a developer (uses technical terms, names a stack), skip the explanations, but keep the same question rules.

## Who decides what

Ask the user only what the user can actually know. Decide the rest yourself.

| Ask the user | Decide yourself |
|---|---|
| Goals, users, what the output is for | Algorithms, losses, training schedules, hyperparameters |
| What "good enough" means and who judges it | Libraries, file layout, internal formats |
| Facts about existing data, files, and systems | How to handle edge cases the user didn't mention |
| Constraints: hardware, budget, deadlines, privacy | Display details such as colors |
| Choices the user has already stated a preference on | Anything the user says they can't judge |

- Even an expert user usually can't judge deep technical trade-offs on the spot. Don't turn your job into a multiple-choice quiz for them.
- **Every question costs the user effort. Ask only when a wrong guess is expensive.** When a choice has a safe default that is cheap to change later (e.g., "postpone the Mac test until a Mac is available"), take it, list it under Assumptions, and move on. Ask when a wrong guess would waste significant work, can't be undone, or must match existing data.
- **Facts are never defaults**, even when they will become settings. How the user's work runs today (opening hours, limits, status names), deadlines, budgets, and the devices people use come from the user or their files. Read them from the files when the files settle them; otherwise ask.
- When you decide, pick the option you'd defend to a senior engineer, record it in SPEC with its reason and rejected alternatives, and mark it **[AI]** (user decisions are **[User]**) so the user can see and override it.
- If you genuinely can't tell which option is best, don't ask the user to guess either: make it an **Open choice** (see *2. Design*).
- After deciding a batch of things, show a short summary of your [AI] decisions so the user can object. Silence or approval means proceed.

## How to ask

These rules apply to every question in every step.

1. **One question per turn.** Never stack several questions in one message, even related ones. The user should be able to answer with a single letter or a few words.
2. **Offer options.** Give 3–4 labelled choices, (a) to (d), each with a short consequence, plus a way to answer freely. Mark the one you recommend with a one-line reason.
3. **Confirm before building on an inference.** If you interpreted an answer (e.g., "labeling assistant" → "a person corrects the output"), state your interpretation and ask "Is this right?" as its own question before asking anything that depends on it. Short or ambiguous answers ("ignore it", "the usual") always need this.
4. **Acknowledge, then ask.** Start each turn by restating in one or two lines what you just recorded, so the user can catch mistakes immediately.
5. **Most important first.** Ask about things that change what gets built before details.

## Workflow

### 0. Check what exists

Look for existing documents in `docs/blueprint/`, a `README`, data, or code. If documents exist, **update** them instead of starting over, and tell the user what you changed. If the user wants documents for a project that is already built (to understand, document, debug, or improve it) rather than a plan for something new, follow *From an existing project* instead of steps 1–3. Otherwise, if code or data exists, read enough of it to keep the documents consistent with reality — and to answer "must match existing" questions yourself where the files make the answer certain.

### 1. Interview (PRD)

Goal: understand the problem before the solution.

- Start with one open question: "What do you want to build, and what problem does it solve?"
- Then follow *How to ask*. Cover, in roughly this order:
  1. Who uses it and what problem they have today
  2. What happens with the result: who uses the output and for what
  3. The core flow: what a user does from start to finish in the main scenario
  4. What "done" looks like for the first version (success criteria)
  5. What is explicitly **not** in the first version
  6. Constraints: deadline, budget, the devices each kind of user has, privacy
- **If the project learns from or processes data** (ML models, data pipelines, analysis), also cover:
  - The input data: kind, amount, sizes, file formats, quirks (e.g., overlays, noise, missing values)
  - Labels or ground truth: format, how files are paired, ID/class numbering, how reliable they are
  - Evaluation: how anyone will know the output is good, and on which data. Make sure evaluation data exists and is separate from training data — check that the numbers add up.
  - The output format, and what consumes it
- Stop interviewing when you can fill the PRD template's required sections. Unknowns go into "Open questions".
- If the user says "just write it", draft with clearly marked assumptions instead of asking more.

Write `docs/blueprint/PRD.md` from `templates/PRD.md`. Show a short summary (not the whole file) and ask the user to confirm or correct it. Then run the *Review gate*.

### 2. Design (SPEC)

Goal: decide how, at the level an agent needs to start without guessing.

- Derive as much as possible from the PRD, and ask only what *Who decides what* leaves to the user (e.g., "Must it run on a phone?", "Do you already have a model in mind?").
- Prefer a simple, mainstream stack with fewer moving parts.
- If a technical decision would change what the user gets (a PRD-level change, e.g., inference now needs labels as input), it is no longer a technical detail: confirm it with the user and update the PRD first.
- **When the right choice can only be found by trying** (model architecture, loss, hyperparameters, thresholds, libraries with unknown fit), don't force a decision. Write it under **Open choices** as candidates, how they will be compared, and the rule that picks the winner.

Write `docs/blueprint/SPEC.md` from `templates/SPEC.md`. Summarize the key decisions for the user and confirm. Then run the *Review gate*.

### 3. Plan (TASKS)

Goal: a sequence an agent can execute one task per session.

- Break work into tasks that each produce something runnable or checkable. Aim for tasks an agent can finish in one sitting.
- Order them so the project works end-to-end as early as possible (a thin vertical slice or a simple baseline first), then improve.
- Every task has **Done when** criteria that a person or a command can verify.
- Link each task to the PRD requirement it serves (e.g., `R2`).
- Each Open choice in SPEC becomes an experiment task whose result is recorded back into SPEC Decisions.
- Some steps can only be done by a person: expert judgment, testing on a device the agent can't reach, getting data or credentials. Mark them 👤. The agent prepares everything for them and stops. Put 👤 tasks that don't block others (e.g., a check on another device) where they can wait without holding up the rest.

Write `docs/blueprint/TASKS.md` from `templates/TASKS.md`. Then run the *Review gate*.

### Review gate (after every document)

Run this after the user confirms each document, **even if they approved it without changes**: approval does not mean the document is complete.

1. Check the document against its section in `references/checklist.md`, and against the documents written before it.
2. Report what you found as a short list, most serious first, each with one line of why it matters.
3. Fix what you can yourself without a user decision (moving content, listing an assumption) and say so.
4. Ask about the rest following *How to ask* — one at a time.
5. Update the document, then review again. Move on only when a review finds nothing new.

### 4. Final review and hand-off

Run the "Across documents" section of `references/checklist.md` over all three files and fix anything left. If the project is a git repository, confirm that `git status` does not list `docs/blueprint/`. Then tell the user:

- which files were written, and that they are kept out of git,
- the remaining open questions and assumptions, if any,
- how to start building: open a new session of their coding agent in this same folder and paste the prompt from the *How to use* section of `docs/blueprint/TASKS.md`. Quote that prompt so they can copy it. The files are not in git, so a separate clone, worktree, or cloud task will not have them.

## From an existing project

The code shows what the project does; the user knows why. The documents record both, so someone who has never seen the project can find their way around it, fix it, and extend it.

1. **Read before asking.** Find the entrypoints, how to run and test it, the main flows, the data, and outside services. Run the tests and safe commands that show behavior, and note the results; never run anything that sends, deploys, deletes, or touches real accounts. Where the README, comments, or tests disagree with the code, the code shows what happens, and the disagreement is a finding.
2. **Point to the code.** Every interface, rule, and data structure in SPEC names the file and function that implement it (e.g., `rules.py` `available_slots()`), so a reader can jump from the document to the code. Put the commit you read (or the date, outside git) in each document's header line.
3. **Built is not the same as intended.** Requirements say what the project is meant to do. Behavior that looks unintended (a contradiction, a crash, a mismatch with the docs or tests) is a finding, not a requirement. Ask the user about intent, not about how the code works: who uses it and why when the code can't tell you, and for each finding whether it is a bug or intended, one at a time, most serious first, following *How to ask*. Intended behavior becomes a requirement, a bug becomes a task, and an unanswered finding stays an Open question.
4. **Write the documents** from the same templates, in the same order, running the *Review gate* after each and *4. Final review and hand-off* at the end:
   - PRD: what it does today, for whom, and what it deliberately doesn't do.
   - SPEC: how it works, with code pointers. Mark what you read in the code **[Code]**. A past decision whose reason neither the user nor the code history gives goes under Open questions, not Decisions with an invented reason.
   - TASKS: the work the findings call for, most serious first: bug fixes with a regression test that fails first, doc fixes, missing tests for important rules, and code too unclear to change safely.

## Updating documents later

When requirements change mid-project, update the PRD first, then SPEC, then TASKS, so the documents never contradict each other, and review each changed document as in the *Review gate*. Add a line to the PRD's Change log. When an experiment settles an Open choice, move it to Decisions in SPEC with the result. Check off completed tasks in place rather than deleting them.
