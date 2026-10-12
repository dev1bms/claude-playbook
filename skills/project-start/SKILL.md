---
name: project-start
description: Start or resume a project Belal's way — read the playbook, inspect the real repository and environment, write docs/PROJECT_CONTEXT.md and a project CLAUDE.md from the templates, record the adopted playbook version, and report in Arabic. Use when Belal says "ابدأ مشروع", "جهّز المشروع", "استأنف", "/devbms-playbook:project-start", or hands over a new brief for a repository that has no PROJECT_CONTEXT.md yet.
---

# project-start

Set a project up so every later session knows the goal, the facts and the authorization.

## 1. Read, in this order

1. `${CLAUDE_PLUGIN_ROOT}/PROFILE.md`, `WORKFLOW.md`, `TOOLS.md` (the reference).
2. The project's `CLAUDE.md`, `docs/PROJECT_CONTEXT.md`, `docs/PROJECT_STATE.md` if they exist, and
   the project memory index. Resume from them; do not redo work that is recorded as done.
3. Any brief Belal attached: save it verbatim under `docs/` (compare bytes) and never edit it.

## 2. Inspect before writing

- `git status`, branch, last commits, remotes, other worktrees and running dev servers
  (`.claude/launch.json`); who else may be working on the folder.
- Stack and commands (package manifests, Dockerfiles, deploy scripts, CI), environments, test
  accounts and data conventions, secrets location (never read secret values).
- For visual work: start the dev server and take "before" screens at 1366 and 390 px per role,
  into `docs/design/review/<task>/before/`, with dev accounts only.

## 3. Write

- `docs/PROJECT_CONTEXT.md` from `${CLAUDE_PLUGIN_ROOT}/templates/PROJECT_CONTEXT.md`: fill only
  what was observed or stated; leave unknown fields visibly empty and list them under blockers.
  Copy the **authorization ladder exactly as Belal wrote it** in this project; inherit nothing.
  Record `Adopted devbms-playbook version: <version from ${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json>`.
- `docs/PROJECT_STATE.md` from the template if missing.
- `CLAUDE.md` from `templates/CLAUDE.project.md` if the project has none; if it exists, add only
  the reference lines that are missing.
- A `.claude/launch.json` entry for the dev servers when the project has them and none exists.

## 4. Decide the task shape

- Define the acceptance criteria for the current task with Belal's brief; if absent, propose them
  in the report and proceed.
- Batch every question that needs Belal into one list; continue with everything that does not.
- Impactful decisions (identity, architecture, economy models): prepare 2–3 alternatives, do not
  implement them yet.
- Two or more sequential stories: track them with fablize `goals.py` when that plugin is installed
  (`python3 ~/.claude/plugins/cache/fablize/fablize/*/scripts/goals.py`); otherwise keep a numbered
  checklist in `PROJECT_STATE.md`.

## 5. Report (Arabic)

Use `${CLAUDE_PLUGIN_ROOT}/templates/PHASE_REPORT.ar.md` as "المرحلة 0 — الجرد": what the project
is, what runs today, the recorded authorization, the batched questions, and the proposed plan.
Then continue with `/devbms-playbook:phase` unless Belal's message says to stop at the inventory.
