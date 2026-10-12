---
name: project-close
description: Close a project or a large phase Belal's way — final deliverables, PROJECT_STATE and decisions updated, project memory for local facts, and candidate general lessons proposed as a playbook change (never applied silently); includes a read-only check for AI attribution in the history. Use for "أغلق المشروع", "سلّم", "ما الدروس", "/devbms-playbook:project-close".
---

# project-close

## 1. Deliverables in one place

Links, files, commit and release state; a short run/reproduce guide; before/after evidence;
open questions. Verify every link and file exists before listing it.

## 2. Update the project's own records

- `docs/PROJECT_STATE.md`: deployed/released table, deferred items, open questions.
- `docs/decisions.md` (or the project's ADR file): decisions taken in this phase with dates.
- Project memory (auto-memory): only facts that are not derivable from the repo — environment
  quirks, external ids' locations (not values), gotchas that cost time.

## 3. Separate the general from the local

List candidate **general** lessons (apply to every project) versus **local** ones. For general
lessons, draft the change to `PROFILE.md` / `WORKFLOW.md` / `TOOLS.md` in the playbook repo as a
commit on a branch with a CHANGELOG line and show it to Belal; a playbook change is never applied
to all projects from an unreviewed edit. Mark each item مؤكد / مقترح per WORKFLOW §8.

## 4. Hygiene checks (report only)

- `git log --format=%B | grep -ci 'co-authored-by: claude\|generated with \[claude'` — report the
  count; do **not** rewrite history or force-push unless Belal explicitly asks.
- Third-party licence notices still present where required (React Bits, fonts, icons, audio).
- No secrets or dev credentials tracked; backups and restore test still scheduled where relevant.

## 5. Report (Arabic)

Final result, where everything is, what was verified, what remains for Belal, and the proposed
playbook changes (as a list, with the branch name).
