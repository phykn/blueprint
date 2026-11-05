# Blueprint

In vibe coding, the AI writes the code. With Blueprint, it writes the plan
too: you bring the idea, and the AI decides the rest.

Blueprint is a skill for Claude Code and Codex. It turns an idea into
documents an AI coding agent can build from without guessing: why you're
building it, how it will work, and the exact steps to get there. It makes the
planning decisions itself and asks you only for what no file can tell it,
usually nothing and at most one short round of questions. You don't need to
be a developer to use it.

It has three modes:

| Mode | You say | You get |
| --- | --- | --- |
| New | "I have an idea for an app" | A plan for building it |
| Document | "Document this project so I can understand it" | Docs for what was built, with links into the code and tasks for what to fix |
| Rebuild | "Rebuild this from scratch" | A new plan from zero built on the old project's core idea |

## What you get

| File | What it covers |
| --- | --- |
| `docs/blueprint/PRD.md` | Why build it, for whom, what it does and doesn't do, and what "done" means |
| `docs/blueprint/SPEC.md` | How it's built: stack, screens, data, and each decision with its reason |
| `docs/blueprint/TASKS.md` | Small, ordered tasks an agent can do one at a time, each with a check |

It works for web and mobile apps and for data projects such as deep learning
models. The documents are written in the language you use with the agent.
Blueprint writes only these documents, never the product code.

The documents stay on your machine: Blueprint adds a `.gitignore` inside
`docs/blueprint/` so git ignores them, and it never commits or pushes them
unless you ask. Start your coding session in the same folder, since a fresh
clone or worktree won't have them.

## How it works

1. **Read.** Blueprint reads what is already there: your request, code, data,
   and docs. For an existing project it runs the tests and safe commands too.
   It sums up the center of the problem in one sentence and keeps it fixed
   through every later step. When a complaint keeps coming back, it traces it
   to its cause in the code or data before relying on it.
2. **Ask, rarely.** It asks only for your intent or for facts outside the
   files, such as another program that reads your data, and only when a wrong
   guess would be costly. All questions come in one message, each with a
   recommended answer, so "ok" is a full reply.
3. **Decide and write.** It decides scope, stack, design, and task order
   itself, and marks each decision **[AI]** with its reason, so you can see
   and override it. Choices only an experiment can settle, such as a model's
   architecture, become candidates and a rule for picking the winner. Tasks
   start with the smallest end-to-end working version or a baseline.
4. **Review itself.** It first checks that the plan still answers that
   center, then checks the documents against a checklist and, where
   it can, has a fresh agent read them cold and list every point where it
   would have to guess. Then it fixes the gaps and reports its key decisions,
   assumptions, and open questions.

In Rebuild mode, the old project is evidence, not a spec. Blueprint keeps its
core idea and the lessons from its bugs, and decides everything else again,
even the formats and interfaces other programs rely on. It drops every feature
the core idea doesn't need, listing each with a reason. When it changes such
a contract, it says so first in its report and plans a transition: old data
is migrated and the old form keeps working for a while after it. By default it plans the new version in a separate folder,
so the old one keeps working, with checks against the old one and a final
switch-over step left to you.

## Install

### Claude Code

```text
/plugin marketplace add phykn/blueprint
/plugin install blueprint@blueprint
```

Run `/reload-plugins` after updating an existing installation.

### Codex and the ChatGPT desktop app

```text
codex plugin marketplace add phykn/blueprint
codex plugin add blueprint@blueprint
```

Restart the ChatGPT desktop app if the plugin does not appear right away.

### Manual

Blueprint follows the [Agent Skills](https://agentskills.io) format, so you
can also copy `skills/blueprint` into a skills folder:

| Tool | Personal (all projects) | Project only |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/blueprint` | `<project>/.claude/skills/blueprint` |
| Codex | `~/.agents/skills/blueprint` | `<project>/.agents/skills/blueprint` |

## Use

Describe what you want to plan, and the skill starts on its own:

```text
I have an idea for an app. Help me write the docs before we code.
Write a PRD for this model before we build it.
I built this project with Claude last year. Document it so I can understand and fix it.
This project grew messy. Rebuild it from scratch, keeping only the idea.
```

To start it directly, type `/blueprint:blueprint` in Claude Code (`/blueprint`
if you copied it manually) or `$blueprint` in Codex.

## Repository layout

```text
.claude-plugin/        Claude Code plugin and marketplace metadata
.codex-plugin/         Codex plugin metadata
.agents/plugins/       Codex marketplace
skills/blueprint/
├── SKILL.md           The skill's instructions
├── templates/         PRD, SPEC, and TASKS templates
└── references/
    └── checklist.md   Review criteria for each document
```

Both tools load the same `skills/blueprint/SKILL.md`. There is no build step
and no tool-specific copy of the skill.
