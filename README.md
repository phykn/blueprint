# Blueprint

In vibe coding, the AI writes the code. The human's job is to write **good docs**.

Blueprint is a skill for Claude Code and Codex. It turns a rough idea into
documents an AI coding agent can build from without guessing: why you're
building it, how it will work, and the exact steps to get there. You don't
need to be a developer to use it.

## What you get

| File | What it covers |
| --- | --- |
| `docs/PRD.md` | Why build it, for whom, what it does and doesn't do, and what "done" means |
| `docs/SPEC.md` | How it's built: stack, screens, data, and each decision with its reason |
| `docs/TASKS.md` | Small, ordered tasks an agent can do one at a time, each with a check |

It works for web and mobile apps and for data projects such as deep learning
models. The documents are written in the language you use with the agent.

## How it works

1. **Interview.** Blueprint asks one plain-language question at a time, with
   choices to pick from. It asks only what you can actually know and decides
   the technical details itself.
2. **Design.** When a technical choice is needed, it proposes one with its
   reason and marks it so you can see and override it. Questions that only an
   experiment can settle, such as a model's architecture, become a list of
   candidates and a rule for choosing.
3. **Plan.** It orders the tasks so the smallest end-to-end working version,
   or a baseline, comes first.
4. **Review.** After you approve each document, Blueprint reviews it against a
   checklist and reports gaps and contradictions.

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
