#!/bin/bash
# Seeds the workspace with the todo CLI of the existing-project case plus docs/blueprint/ written by Blueprint 0.4.1
# (numbered headings, a Status line, no Mode line, one task checked), so the run must update them in place.
set -euo pipefail
cat > todo.py <<'PY'
#!/usr/bin/env python3
"""todo.py: a tiny todo list kept in todos.json next to this file."""
import json
import sys
from pathlib import Path

DB = Path(__file__).with_name("todos.json")


def load():
    if DB.exists():
        return json.loads(DB.read_text())
    return []


def save(todos):
    DB.write_text(json.dumps(todos, indent=2))


def add(text):
    todos = load()
    todos.append({"text": text, "done": False})
    save(todos)
    print(f"added {len(todos)}. {text}")


def list_():
    todos = load()
    if not todos:
        print("nothing to do")
    for i, t in enumerate(todos, 1):
        mark = "x" if t["done"] else " "
        print(f"[{mark}] {i}. {t['text']}")


def done(n):
    todos = load()
    idx = n - 2
    if idx < 0 or idx >= len(todos):
        sys.exit(f"error: no task {n}")
    todos[idx]["done"] = True
    save(todos)
    print(f"done {n}. {todos[idx]['text']}")


def main(argv):
    if len(argv) < 2 or argv[1] not in ("add", "list", "done"):
        sys.exit("usage: todo.py add TEXT | list | done N")
    if argv[1] == "add":
        add(" ".join(argv[2:]))
    elif argv[1] == "list":
        list_()
    else:
        done(int(argv[2]))


if __name__ == "__main__":
    main(sys.argv)
PY
cat > test_todo.py <<'PY'
import subprocess
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).parent
DB = HERE / "todos.json"


def run(*args):
    return subprocess.run([sys.executable, str(HERE / "todo.py"), *args], capture_output=True, text=True).stdout


class TodoTest(unittest.TestCase):
    def setUp(self):
        if DB.exists():
            DB.unlink()

    tearDown = setUp

    def test_list_empty(self):
        self.assertEqual(run("list").strip(), "nothing to do")

    def test_add_then_list(self):
        run("add", "milk")
        run("add", "bread")
        self.assertEqual(run("list").splitlines(), ["[ ] 1. milk", "[ ] 2. bread"])


if __name__ == "__main__":
    unittest.main()
PY
cat > README.md <<'MD'
# todo

A one-file todo list for the terminal. Tasks are kept in `todos.json` next to `todo.py`.

    python3 todo.py add Buy milk
    python3 todo.py list
    python3 todo.py done 1

`list` numbers the tasks from 1. `done N` marks task N as done.

Run the tests with `python3 test_todo.py`.
MD
mkdir -p docs/blueprint
printf '*\n' > docs/blueprint/.gitignore
cat > docs/blueprint/PRD.md <<'MD'
# PRD: todo

> Product Requirements Document. Explains **why** we are building this and **what** it must do. It does not say how.
> Status: Confirmed — Last updated: 2025-06-01

## 1. Summary

A one-file todo list for the terminal, for one person who wants to track a few tasks without leaving the shell.

## 2. Problem

Notes in a text file get lost and never get checked off. The person wants to add a task in one command, see what is open, and mark things done.

## 3. Users

| User | What they want to do |
|---|---|
| Terminal user | Add tasks, list them, mark them done, all from the shell |

## 4. Core scenario

1. The user runs `python3 todo.py add Buy milk`.
2. The user runs `python3 todo.py list` and sees the numbered tasks.
3. The user runs `python3 todo.py done 1` and the task shows as done.

## 6. Requirements

Each requirement has an ID so SPEC and TASKS can refer to it. Use **Must** for the first version and **Later** for things that can wait. Requirements say *what*, not *how*: technologies, libraries, and algorithms belong in SPEC.

| ID | Requirement | Priority |
|---|---|---|
| R1 | The user can add a task with a text | Must |
| R2 | The user can list tasks, numbered from 1, with done tasks marked | Must |
| R3 | The user can mark task N done, where N is the number shown by list | Must |

## 7. Success criteria

- [ ] Adding, listing and marking done each take one command
- [ ] `python3 test_todo.py` passes

## 8. Out of scope

Things we are deliberately **not** doing in this version. The coding agent must not build these.

- Due dates
- Multiple lists

## 11. Assumptions

Gaps filled with a default instead of a user decision, including anything the AI proposed. Confirm or change these.

- Assumed one person uses the list at a time

## 12. Open questions

- None

## Change log

- 2025-06-01: Created.
MD
cat > docs/blueprint/SPEC.md <<'MD'
# SPEC: todo

> Technical specification. Explains **how** the requirements in `PRD.md` will be built, in enough detail that a coding agent can start without guessing.
> Status: Confirmed — Last updated: 2025-06-01
>
> Markers: **[User]** decided by the user · **[AI]** a technical decision the AI made because the user can't be expected to judge it · **[Code]** read from code that already exists. [AI] items can be overridden at any time.

## 1. Overview

A single Python script, `todo.py`, with three subcommands. Tasks are stored in `todos.json` next to the script.

## 2. Tech stack

| Area | Choice | Why |
|---|---|---|
| Language | Python 3, standard library only | Already installed; nothing to manage [AI] |
| Storage | `todos.json`, a JSON list | Human-readable, one file [AI] |

## 3. Interfaces

### `todo.py add TEXT` — R1

- Input: the task text (all remaining arguments)
- Output: `added N. TEXT`
- Errors and edge cases: empty text is stored as is
- Code: `todo.py` `add()`

### `todo.py list` — R2

- Input: none
- Output: one line per task, `[x] N. TEXT` or `[ ] N. TEXT`; `nothing to do` when empty
- Errors and edge cases: none
- Code: `todo.py` `list_()`

### `todo.py done N` — R3

- Input: the task number N as shown by `list`
- Output: `done N. TEXT`
- Errors and edge cases: an unknown N prints `error: no task N` and exits 1
- Code: `todo.py` `done()`

## 4. Data

### todos.json

| Field | Type | Notes |
|---|---|---|
| text | string | required |
| done | boolean | default false |

## 6. Rules and edge cases

- Task numbers are positions in the list, starting at 1; they change when the list changes.

## 7. Decisions

| Decision | Reason | Rejected alternatives |
|---|---|---|
| One file, no packages (§2) [AI] | Nothing to install | A `click` CLI |

## 8. Project conventions

- Run: `python3 todo.py list`
- Test: `python3 test_todo.py`

## 9. Open questions

- None
MD
cat > docs/blueprint/TASKS.md <<'MD'
# TASKS: todo

> Ordered work plan. A coding agent should do **one task at a time**, top to bottom, and check it off when its "Done when" items pass.
> Read `PRD.md` and `SPEC.md` before starting any task.
> Tasks marked 👤 need a person. The agent prepares what the person needs, then stops; it does not fake the result. When a later session finds a 👤 task first, the agent asks whether the person has done it, checks what it can, and checks the task off once they confirm.

## How to use

Tell your coding agent:

> Read docs/blueprint/PRD.md, docs/blueprint/SPEC.md and docs/blueprint/TASKS.md. Do the first unchecked task only. When finished, verify every "Done when" item, check the task off, and stop.

## Tasks

### [x] T1. Project setup

- Serves: R1, R2, R3
- Do: Create `todo.py` with `add`, `list` and `done`, `todos.json` storage (SPEC §3, §4), and `test_todo.py` covering the empty list and add-then-list.
- Done when:
  - [x] `python3 todo.py add a` then `python3 todo.py list` prints `[ ] 1. a`
  - [x] `python3 test_todo.py` passes

### [ ] T2. Test for done

- Serves: R3
- Do: Add a test to `test_todo.py` that `done 1` marks the first task as done.
- Done when:
  - [ ] `python3 test_todo.py` passes with the new test

### [ ] T3. Reject empty task text

- Serves: R1
- Do: `todo.py add` with no text prints `error: empty task` and exits 1.
- Done when:
  - [ ] `python3 todo.py add` exits 1 and stores nothing
MD
git init -q
git -c user.name=fixture -c user.email=fixture@example.com add -A
git -c user.name=fixture -c user.email=fixture@example.com commit -q -m "todo: add, list, done"
