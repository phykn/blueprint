#!/bin/bash
# Seeds the workspace with a small Python todo CLI that has one planted bug:
# `done N` marks the task shown as N-1 (and `done 1` fails), while the README says it marks task N.
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
git init -q
git -c user.name=fixture -c user.email=fixture@example.com add -A
git -c user.name=fixture -c user.email=fixture@example.com commit -q -m "todo: add, list, done"
