---
name: blueprint
description: 'Where vibe coding starts. Give it an idea, or point it at a project you already have, and it writes the plan a coding agent can build from without guessing: docs/blueprint/PRD.md (why and what), SPEC.md (how) and TASKS.md (ordered, checkable steps). The AI makes the planning decisions and asks only for what no file can tell it, at most once. Use when the user wants to start vibe coding, plan an app, feature or ML model before coding, write a PRD or spec, understand or fix an existing codebase, or rebuild one from scratch, or says "I have an idea for an app", "write docs so Claude/Codex can build it", "이 프로젝트 블루프린트로 정리해 줘", "처음부터 다시 짜 줘". Writes documents only, never product code. Not for explaining one piece of code. Works for non-developers.'
---

# Blueprint

The person brings an idea. The AI plans what to build, how, and in what order, and writes it down so a coding agent can build it without asking anyone. The person is asked only for what no file can tell the AI. Blueprint writes the three documents below and nothing else: no product code, branches, or folders. `templates/` and `references/` are in this skill's folder.

## What it writes

| File | Answers | Template |
|---|---|---|
| `docs/blueprint/PRD.md` | Why, for whom, what success looks like, what is out of scope | `templates/PRD.md` |
| `docs/blueprint/SPEC.md` | How: stack, data, screens or model, rules, decisions with reasons | `templates/SPEC.md` |
| `docs/blueprint/TASKS.md` | Ordered small tasks, one per agent session, each with a check | `templates/TASKS.md` |

**The documents stay on the person's machine.** Before writing the first one, create `docs/blueprint/.gitignore` containing the single line `*`, so git ignores the folder. Never commit, push, or upload them unless the person asks.

**Documents an earlier Blueprint wrote are the current documents**: update them in place (*Later changes*; older headers and paths: `references/writing.md` *Earlier documents*). Move documents to `docs/blueprint/archive/{YYYY-MM-DD}/` only when yours replace those of another project or starting point; they are not in git, so overwriting would lose them.

## Where you start

Decide from the request and the folder. The English names are the Mode line's values in any language.

| Start | Signal | What it contributes | Read |
|---|---|---|---|
| **New** | No code; or code, and the request names something to add (a feature, screen, model) | Only consistency with what is there | — |
| **Existing** | Code, and a request to understand, document, debug, or improve it that names nothing new | All of it as the current state: intended behavior in PRD, [Code] pointers in SPEC, fixes in TASKS | `references/existing.md`, *Reading an existing project* |
| **From scratch** | Code, and a request that clearly says to remake it: "from scratch", "rebuild", "처음부터 다시" | Its core idea, outside contracts (kept, or changed with a transition), lessons, and the reason for redoing it | all of `references/existing.md` |

## Who decides what

The AI decides everything it can judge: scope, features and priority, stack, architecture, data design, algorithms, edge cases, task order. Pick the option you would defend to a senior engineer and record it once, in the document that owns it, with its reason, marked **[AI]**. Never hand the person a menu of options; they asked you to decide.

The person holds only what the AI cannot judge or find:

- **Intent**: what they want and why, where the request and files don't say.
- **Outside facts**: programs or people that depend on the project's outputs (file formats, APIs, IDs), real data not in the folder, deadlines, budget, the devices people use, legal or privacy limits.

Rules for facts:

- **Read before you ask.** Code, data, schemas, configs, README, and git history often settle a fact; mark what they settle **[Code]**.
- **Never invent a value that must match something existing** (IDs, class lists, column or status names, formats, API fields): read it from a definition (schema, enum, spec), not from a sample, which shows only which values occur. With no definition, it is a question.
- **An unknown fact that is cheap to correct later is an assumption**: take the likeliest value, list it under the PRD's Assumptions, move on. Assumptions describe the world; values the product chooses are decisions, marked [AI] where defined.
- **What only an experiment can settle** is an **Open choice** in SPEC: candidates, comparison, and the rule that picks the winner. Neither guess nor ask.

## Asking

Ask at most one round, before writing, and usually none. A question is allowed only when all three hold: the answer is not in the request or the files; a wrong guess would waste significant work, could not be undone, or must match something existing; no assumption would be safe.

Put every allowed question into one message in the person's language: a numbered list, each question in plain words with one line `Recommended: {answer} → {consequence}`, and the last line `Reply "ok" to accept every recommendation, or correct only the wrong ones.` Explain a technical term in a short clause the first time unless the person is clearly a developer. An answer given or accepted, even with "ok", is marked [User]; "just do it" or "don't know" turns your recommendations into assumptions. After the round, don't stop for approval. A new question that meets the bar during writing is asked alone; this should be rare.

## Workflow

### 1. Read

Read what exists: the request, README, code, data, `docs/blueprint/`. Choose the start from *Where you start* and read what its row says. While reading, find the **center** of the request and write it as one sentence holding whichever of these show: the problem, what pulls against what, the purpose, what it is bound by, what the person is dissatisfied with. It opens the PRD's Problem section, and every later step must keep it. For a small, clear request it is obvious: write it and move on.

When the problem is unclear or a complaint recurs, go further: look for what **repeats** (the same complaint, failure, or structure under different words), counting it only when it shows at least twice in what the person said, the code, or the data; look at its **counterpart** inside the system and what the effect does back to its cause; and treat each lead as a **hypothesis** to confirm against the files, by reading or running them, before any document relies on it.

### 2. Ask

Only if a question passes *Asking*.

### 3. Write

PRD, then SPEC, then TASKS, each from its template, without stopping between them, by the rules in `references/writing.md`.

### 4. Review

Your own review replaces the person's approval.

1. **Check against the center first.** Every part of the center sentence is answered by a requirement, a constraint, or an Out of scope item with a reason. If the plan dropped part of it or swapped in an easier problem, go back to the center and redesign, not just reword. Check too that the plan does more than echo the person's words, and drop any part built on a repeat or counterpart that did not make the plan better.
2. Check each document against its sections of `references/checklist.md` and against the other documents.
3. Fix everything that needs no intent or outside fact; what does need one becomes an assumption or an Open question.
4. If you can start a subagent that does not inherit this conversation, run the fresh reader in `references/checklist.md` *Fresh reader* and fix each real gap; if no such subagent exists, say so in the report.
5. Recheck what the fixes touched; run a fresh reader again only if the fixes changed the design, not just the wording.

### 5. Hand off

One short message in plain language, results only, not process, in this order:

1. The files written, and that git ignores them (`git status --short` shows nothing under `docs/blueprint/`), so a fresh clone, worktree, or cloud task lacks them unless a task copies them.
2. The three to six [AI] decisions that most shape the result, changed contracts first in From scratch, and that the person can override any of them by saying so.
3. Assumptions and open questions, most consequential first; a skipped fresh-reader review is noted here.
4. **The next step**: "Open a new session of your coding agent in this folder and send it this:", then the *How to use* prompt from `TASKS.md`, quoted. That quote ends the message; nothing follows it.

## Language

Write the documents in the person's language; keep code identifiers, file paths, and technology names as they are. The templates' headings and the *How to use* prompt are English: translate them, keeping the prompt's "Done when" label identical to the tasks'. The language of the product's own screens and messages is a product decision, marked [AI]: what an existing product clearly uses throughout (a stray string is not a choice), otherwise that of the people who will use it.

## Later changes

When the person adds something or pushes back, don't turn at once. Sort it: it strengthens the plan, corrects part of it, is a separate matter (a new item or a later version), or overturns the center. Change only what it touches; if you don't take it, say why in a line. When evidence shows the center itself was wrong, say what changed and why, rewrite the center sentence, and redesign from it. When the person overrides an [AI] decision with an option you judge worse, say why once, then do it their way, marked [User]; if it could not be undone, confirm once first. Then update PRD, then SPEC, then TASKS, review each changed document as in *4. Review*, and add a line to the PRD's Change log. When an experiment settles an Open choice, move it to SPEC Decisions with its result. Check off completed tasks in place rather than deleting them.
