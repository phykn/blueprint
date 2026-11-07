# Blueprint

Where vibe coding starts.

In vibe coding the AI writes the code. Blueprint makes it write the plan first: you bring an idea, or a project you already have, and it writes the three documents a coding agent can build from without guessing. It makes the planning decisions itself, asks only for what no file can tell it (at most once), reviews its own documents, and ends with the one step that starts the build. You don't need to be a developer to use it.

Blueprint is a skill for Claude Code and Codex, in the [Agent Skills](https://agentskills.io) format.

## What you get

| File | What it covers |
| --- | --- |
| `docs/blueprint/PRD.md` | Why build it, for whom, what it does and doesn't do, and what "done" means |
| `docs/blueprint/SPEC.md` | How it's built: stack, screens or model, data, rules, and each decision with its reason |
| `docs/blueprint/TASKS.md` | Small, ordered tasks an agent does one at a time, each with a check |

The documents are written in the language you use with the agent. They stay on your machine: Blueprint adds a `.gitignore` inside `docs/blueprint/` so git ignores them, and it never commits or pushes them unless you ask. A fresh clone, worktree, or cloud task therefore won't have them, so start your coding sessions in the same folder. Blueprint writes only these documents, never the product code.

## Three ways to start

| You have | You say | You get |
| --- | --- | --- |
| An idea, or a feature to add | "I have an idea for an app" | A plan for building it |
| A project you want to understand or fix | "Document this project so I can understand and fix it" | Docs for what was built, with pointers into the code and tasks for what is wrong |
| A project to redo from zero | "Rebuild this from scratch, keeping only the idea" | A new plan from the old project's core idea, with a transition for every contract it changes |

## How it works

1. **Read.** Blueprint reads your request, code, data and docs, runs the tests and safe commands of an existing project, and sums up the center of the problem in one sentence that every later step must keep.
2. **Ask, rarely.** It asks only for your intent or for facts outside the files, and only when a wrong guess would be costly: one message, each question with a recommended answer, so "ok" is a full reply.
3. **Decide and write.** It decides scope, stack, design, code structure and task order itself, marks each decision **[AI]** with its reason so you can override it, and writes PRD, SPEC and TASKS without stopping for approval.
4. **Review itself.** It checks the plan against the center sentence and a checklist and, where it can, has a fresh agent read the documents cold and list every point where it would have to guess.
5. **Hand off.** It reports the files, its key decisions and assumptions, and ends with the one prompt to paste into a new coding-agent session. That first task makes the project self-starting: it adds a short `## Plan` section to the agent's instruction file (`CLAUDE.md` or `AGENTS.md`), so every later session reads the plan first, does the next unchecked task by the SPEC's code structure and rules, and stops. A tidy task before the final hand-over checks the code against them, so it needs no separate refactor.

## Install

### Claude Code

```text
/plugin marketplace add phykn/blueprint
/plugin install blueprint@blueprint
```

### Codex and the ChatGPT desktop app

```text
codex plugin marketplace add phykn/blueprint
codex plugin add blueprint@blueprint
```

Or, after adding the marketplace, install Blueprint from the Plugins directory (`/plugins` in Codex, or the Plugins page of the ChatGPT desktop app). Restart the app if it does not appear.

### Manual

Copy `skills/blueprint` into a skills folder:

| Tool | Personal (all projects) | Project only |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/blueprint` | `<project>/.claude/skills/blueprint` |
| Codex | `~/.agents/skills/blueprint` | `<project>/.agents/skills/blueprint` |

## Update

```text
claude plugin marketplace update blueprint
claude plugin update blueprint@blueprint
```

Then run `/reload-plugins` in a running session, or start a new one. In Codex, run `codex plugin marketplace upgrade blueprint`, then `codex plugin add blueprint@blueprint` again, or update it from the Plugins directory.

## Use

Describe what you want to plan, and the skill starts on its own:

```text
I have an idea for an app. Help me plan it before we write any code.
Write a PRD for this model before we build it.
Document this project so I can understand and fix it.
This grew messy. Rebuild it from scratch, keeping only the idea.
```

To start it directly, type `/blueprint:blueprint` in Claude Code (`/blueprint` if you copied it manually) or `$blueprint` in Codex.

## Repository layout

```text
plugin.json                 Codex plugin manifest (portable Agent Plugins format)
.claude-plugin/             Claude Code plugin and marketplace manifests
.agents/plugins/            Codex marketplace
skills/blueprint/
├── SKILL.md                The skill's instructions
├── references/
│   ├── existing.md         Reading an existing project; rebuilding from scratch
│   ├── writing.md          Rules for writing the documents
│   └── checklist.md        Review criteria for each document
└── templates/              PRD, SPEC, and TASKS templates
evals/                      Eval cases for `claude plugin eval`
```

Both tools load the same `skills/blueprint/SKILL.md`. There is no build step and no tool-specific copy of the skill.

## Develop

Validate the manifests and the skill; all three must pass without warnings:

```text
claude plugin validate .
claude plugin validate .claude-plugin/plugin.json
claude plugin validate skills
```

Run the evals; each case must score at least 0.8. The suite needs a logged-in Claude Code CLI and calls the model, so it costs money:

```text
claude plugin eval . --ablation none --runs 1 --threshold 0.8 --scaffold --trust-plugin --no-publish --allow-tools Write Edit Bash --max-cost-usd 15
```

Size limits: `skills/blueprint/SKILL.md` stays at or under 10,000 bytes and 160 lines, its `description` at or under 800 characters, and each file under `references/` at or under 10,000 bytes.

### Release

1. Set the same new version in `.claude-plugin/plugin.json` and `plugin.json`.
2. Merge the release branch into `main`.
3. Run `claude plugin tag` and push the branch and the tag.
4. Update your own installation: `claude plugin marketplace update blueprint`, `claude plugin update blueprint@blueprint`, then `/reload-plugins`.
5. Check that `claude plugin details blueprint@blueprint` shows the new version.
