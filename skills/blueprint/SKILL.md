---
name: blueprint
description: Turns an idea, or a project that already exists, into documents an AI coding agent can build from without guessing — a PRD (why and what), a SPEC (how), and TASKS (ordered, verifiable steps). The AI makes the planning decisions; the person supplies the idea and only the facts the AI cannot find in the files. Three modes — plan something new, document an existing project as it is, or rebuild an existing project from zero keeping only its core idea. Use when the user wants to plan an app, feature, or ML model before vibe coding, write a PRD/spec/requirements, document a codebase, or redo one from scratch, or says things like "I have an idea for an app", "write docs so Claude/Codex can build it", "document this project so I can understand it", "rebuild this from scratch", "이 프로젝트 블루프린트로 정리해 줘", or "이거 처음부터 다시 짜 줘". Writes documents only, never product code. Not for a quick explanation of one piece of code. Works for non-developers.
---

# Blueprint

The person brings an idea. The AI does the planning: it decides what to build, how, and in what order, and writes it down so a coding agent can build it without asking anyone. The person is asked only for what no file can tell the AI.

The output is three Markdown files in the person's project. Paths under `templates/` and `references/` are in this skill's folder.

| File | Answers | Template |
|---|---|---|
| `docs/blueprint/PRD.md` | Why build it, for whom, what success looks like, what is out of scope | `templates/PRD.md` |
| `docs/blueprint/SPEC.md` | How it will be built: stack, data, screens or model, decisions and their reasons | `templates/SPEC.md` |
| `docs/blueprint/TASKS.md` | Ordered, small tasks an agent can do one at a time, each with a check | `templates/TASKS.md` |

**The documents stay on the person's machine.** Before writing the first one, create `docs/blueprint/.gitignore` containing the single line `*`, so git ignores the whole folder without changing the project's own `.gitignore`. Never commit, push, or upload these files unless the person explicitly asks. Blueprint itself writes nothing else in the project: no product code, no branches or folders. Those come later, from tasks the coding agent runs.

## Modes

Pick the mode from the request.

| Mode | When | The documents describe |
|---|---|---|
| **New** | An idea, with nothing built yet, or a feature to add to existing code | The thing to build |
| **Document** | An existing project someone wants to understand, debug, or improve | What exists, pointing into the code, plus tasks for what is wrong |
| **Rebuild** | An existing project to redo from zero | A new design from the old project's core idea; outside contracts stay unless the AI judges a change worth its transition |

If `docs/blueprint/` already holds documents for the same project and mode, update them (see *Updating documents later*). If the new documents would replace them instead, first move them to `docs/blueprint/archive/{YYYY-MM-DD}/`; they are not in git, so overwriting them would lose them for good.

## Who decides what

The AI decides everything it can judge: scope, features and their priority, stack, architecture, data design, algorithms, edge cases, and task order. Pick the option you would defend to a senior engineer and record it once, in the document that owns it, with its reason, marked **[AI]**. Do not hand the person a menu of design options; they asked you to decide.

The person holds only what the AI cannot judge or find:

- **Intent**: what they want and why, where the request and the files don't say.
- **Outside facts**: what is true outside the files: programs or people that depend on the project's outputs (file formats, APIs, IDs), real data that isn't in the folder, deadlines, budget, the devices people use, legal or privacy limits.

Rules for facts:

- **Read before you ask.** Code, data, schemas, configs, README, and git history often settle a fact. Use them and mark the result **[Code]**.
- **Never invent a value that must match something existing**: IDs, class lists, column or status names, file formats, API fields. Read it from a definition (a schema, an enum, a spec). A data sample shows which values occur, not every value that exists. If no definition settles it, it is a question.
- **An unknown fact that is cheap to correct later becomes an assumption**: take the likeliest value, list it under the PRD's Assumptions, and move on. An assumption describes the world (how many orders a day, which phones people use); a value the product chooses (slot length, a limit, a retention period) is a decision, marked [AI] where it is defined.
- **When only an experiment can tell which option is best** (model architecture, thresholds, a library of unknown fit), write it as an **Open choice** in SPEC: the candidates, how they are compared, and the rule that picks the winner. Neither guess nor ask.

## Asking

Ask at most one round of questions, before writing, and usually none. A question is allowed only when all of these hold:

1. The answer is not in the request or the files.
2. A wrong guess would waste significant work, could not be undone, or must match something existing.
3. No assumption would be safe.

Put every allowed question into that one message, numbered, in plain language, each with your recommended answer and what it leads to, so the person can reply "ok" to accept all recommendations or correct only the wrong ones. Explain a technical term the first time you use it in a short clause, unless the person is clearly a developer. An answer the person gave or accepted, even with "ok", is marked [User]. If they say "just do it" or don't know, your recommendations become assumptions. Ask in the person's language.

After that round, don't stop for approval. If writing uncovers a new question that meets the same bar, ask it alone; this should be rare.

## Workflow

### 1. Read

Read what exists: the request, README, code, data, and `docs/blueprint/`. In New mode, read enough to keep the documents consistent with what is already there. In Document and Rebuild modes, read as the mode's section says.

While reading, find the **center** of the request and write it as one sentence holding whichever of these show: the problem, what pulls against what, the purpose, what it is bound by, and what the person is dissatisfied with. It opens the PRD's Problem section, and every later step must keep it. For a small, clear request the sentence is obvious; write it and move on.

When the problem is unclear or a complaint recurs, go further:

- **Look for what repeats.** The same complaint, failure, or structure under different words is a lead. Count it only when it shows up at least twice in what the person actually said, the code, or the data.
- **Look at the counterpart.** For a repeated pain, find what it is inside the system, and what the effect does back to its cause. "It's slow", "nothing happens", and "it shows up late" may be one wait stuck at one point in the system.
- **A lead is a hypothesis.** Confirm it against the files, by reading or running them, before any document relies on it.

### 2. Ask

Only if a question passes *Asking*.

### 3. Write

Write PRD, then SPEC, then TASKS, each from its template, without stopping between them.

- **Write for an agent that has never met the person.** Every document must make sense with no chat history. Write the PRD so the person can read it too, in plain words; SPEC and TASKS are for the coding agent and may be technical.
- **Testable over descriptive.** "Fast" is not a requirement; "the list loads in under 1 second with 1,000 items" is. Subjective checks (e.g., expert judgment) need a count or ratio that decides pass or fail.
- **Say what not to do.** Out of scope lists what an agent might helpfully add.
- **Record the why.** Agents undo decisions they don't understand. Each non-obvious decision gets its reason and the alternatives it beat.
- **Say each thing once**, in the document that owns it (PRD: what; SPEC: how; TASKS: order and checks), and refer to it everywhere else by ID or section heading, within the same document too, because copies drift apart. A "Done when" item may quote the value it checks.
- **Small beats complete.** Delete template sections that don't apply instead of filling them. Headings carry no numbers, so deleting one breaks nothing; refer to a section by its heading.
- A technical decision that changes what the person gets (e.g., inference now needs labels as input) belongs in the PRD, marked [AI].
- **Data projects** (ML models, pipelines, analysis): the PRD defines the input data, labels or ground truth, evaluation data kept separate from training data (check that the counts add up), and the output format and what consumes it.
- **TASKS**: start with a thin end-to-end slice or a simple baseline, then improve. Each task fits one agent session, produces something runnable or checkable, names the requirement IDs it serves, and has "Done when" items a command or a person can verify. Each Open choice becomes an experiment task that records the winner in SPEC Decisions. Mark 👤 the steps only a person can do: expert judgment, a device the agent can't reach, getting data or credentials, deploying, or switching a live system over. Place them where they block as little as possible.

### 4. Review

Your own review replaces the person's approval.

1. **Check against the center first.** Every part of the center sentence is answered by a requirement, a constraint, or an Out of scope item with a reason. A plausible plan that dropped part of it, or swapped the problem for an easier one, solves a different problem: go back to the center and redesign, not just reword. Also check that the plan does more than follow the person's words, and that each part built on a repeat or counterpart made the plan better; remove the parts that didn't.
2. Check each document against its sections of `references/checklist.md` and against the other documents.
3. Fix everything that needs no intent or outside fact. What does need one becomes an assumption or an Open question.
4. If you can start a subagent that does not inherit this conversation, give it only the three documents (in Rebuild mode, also the old code at the recorded commit), tell it to review and not build, and ask it to list every point where it would have to guess or ask before building. Fix each real gap.
5. Recheck what the fixes touched against the checklist. Run a fresh reader again only when the fixes changed the design, not just the wording.

### 5. Report

One short message in plain language, with results and next steps only, not the process that led to them:

- which files were written, and that they are kept out of git (in a git repository, confirm `git status` does not list `docs/blueprint/`);
- the [AI] decisions that most shape the result, a few lines, and that the person can override any of them by saying so;
- the assumptions and open questions, most consequential first;
- how to start building: open a new session of the coding agent in this same folder and paste the prompt from the *How to use* section of `TASKS.md`. Quote it. The files are not in git, so a separate clone, worktree, or cloud task will not have them unless a task copies them there.

## Document mode

The code shows what the project does. The documents record that, plus the intent behind it, so someone new can find their way around, fix it, and extend it.

1. **Read thoroughly.** Find the entrypoints, how to run and test it, the main flows, the data, and outside services. Run the tests and safe commands that show behavior, and note the results; never run anything that sends, deploys, deletes, or touches real accounts. Where the README, comments, or tests disagree with the code, the code shows what happens, and the disagreement is a finding.
2. **Point to the code.** Every interface, rule, and data structure in SPEC names the file and function that implement it (e.g., `rules.py` `available_slots()`). Put the commit you read (or the date, outside git) in each document's header.
3. **Built is not the same as intended.** For each finding (a contradiction, a crash, a mismatch with docs or tests), judge from the evidence whether it is a bug or intended: tests, docs, commit messages, and how the rest of the code treats the case. Intended behavior becomes a requirement; a bug becomes a task. When the evidence can't tell and the answer changes what gets built, it is a question for the round, if it passes *Asking*, or else an Open question.
4. **Write**: PRD — what it does today, for whom, and what it deliberately doesn't do. SPEC — how it works, marked [Code]; a past decision whose reason no evidence gives goes under Open questions, never an invented reason. TASKS — the work the findings call for, most serious first: bug fixes with a regression test that fails first, doc fixes, missing tests for important rules, and code too unclear to change safely.

## Rebuild mode

The old project is evidence, not a spec. Keep its idea; decide everything else again from zero, its promises to the outside world included, but never break one without a transition.

1. **Read the old project** as in Document mode step 1, and record its commit (or the date) in each document's header. Take four things from it:
   - **Core idea**: the problem, the users, and the outcome they get. This is the only part of the old design carried over as given.
   - **Outside contracts**: whatever outside the code depends on it: files or data other programs read or write, stored user data, API endpoints and fields, commands that scripts call, IDs and names shared with other systems. That they exist is a fact; whether to keep them is a design decision like any other. Keep a contract when it serves the core idea. Change or drop it when a clearly better design needs that, recorded in SPEC Decisions as [AI] with the reason and what it costs the people who rely on it. A changed contract gets a transition: stored data is migrated, and where consumers outside the files may exist, the new version still accepts the old form for a while after the switch-over (e.g., the old command name still runs and points to the new one). Ask whether anyone else depends on an output only when its consumers are not in the files and no transition is possible. Live data the old version keeps writing stays where it is: the new version works on a copy until the switch-over, and its branch never commits changes to that data.
   - **Lessons**: bugs, crashes, workarounds, slow or confusing parts. Each becomes a requirement or check the new version must meet, not code to copy. When several share one cause, the cause is the lesson, and the new design removes it.
   - **Why it is being rebuilt**: the person's dissatisfaction with the old version is part of the center. The new design must answer it, not just be newer.
2. **Design from zero.** Write the PRD from the core idea, not from the old feature list. Keep an old feature only when the core idea needs it; list each dropped one under Out of scope with a one-line reason, so nobody re-adds it. Choose the stack and structure as for a new project. Reusing the old ones is fine only when they win on their own merits, recorded in Decisions.
3. **Decide where the new code goes**, in SPEC Decisions. Default: a new folder next to the project (in a git repository, a `git worktree` on a new branch), so the old version keeps running on its own files while the new one is built. Blueprint only records the choice; the first task creates the place.
4. **Plan the TASKS**: the first task, run in the old folder, creates that place, copies `docs/blueprint/` into it, and tells the person to continue there. A check that proves each kept contract against the old version (it reads the old version's files correctly, and what it writes keeps the format outside readers expect), and each changed contract's transition (old data migrates, the old form still works), comes as soon as the slice that touches it exists. The check holds the new version to the contract, not to the old version's bugs: where the old output is wrong, the requirement decides. The last task is 👤: switching over from the old version, since replacing a working system is the person's call; it includes a check for each assumption about an outside contract (e.g., the finance spreadsheet still imports the file), telling the users of each changed contract what changes, and a date to remove each old form. SPEC points to the old code at the recorded commit wherever a check compares against it, so the coding agent and the fresh reader in *4. Review* can read it there. The report names every changed contract first among the [AI] decisions.

## Language

- Write the documents in the language the person is speaking. Keep code identifiers, file paths, and technology names in their original form.
- The templates' headings and the *How to use* prompt in TASKS are in English; translate them, keeping the prompt's "Done when" label identical to the one the tasks use.
- The language of the product's own screens and messages is a product decision, marked [AI]: keep the language an existing product clearly uses throughout (a stray string is not a choice), otherwise use the language of the people who will use it.

## Updating documents later

When the person adds something or pushes back, don't turn at once. First sort it: it strengthens the current plan, corrects part of it, is a separate matter (a new item or a later version), or overturns the center. Change only what it touches. If you don't take it, say why in a line. If there is evidence that the center itself was wrong, say what changed and why, then rewrite the center sentence and redesign from it. When the person overrides an [AI] decision with an option you judge worse, say why once, briefly, then do it their way and mark it [User]; if it could not be undone, confirm once before writing it. Then update the PRD first, then SPEC, then TASKS, so the documents never contradict each other, and review each changed document as in *4. Review*. Add a line to the PRD's Change log. When an experiment settles an Open choice, move it to SPEC Decisions with the result. Check off completed tasks in place rather than deleting them.
