# [Project] — project instructions

## Reference documents (read before non-trivial work)

- **Delivered brief / study:** `docs/[file].md` — kept verbatim as delivered; do not edit. Record
  decisions and deviations in the working docs below.
- **Project context and authorization:** `docs/PROJECT_CONTEXT.md` (what Belal authorized here).
- **Current state:** `docs/PROJECT_STATE.md` (read first in every session).
- **Decisions:** `docs/decisions.md` (ADR style, append only).

The personal working preferences come from `~/.claude/CLAUDE.md` (devbms-playbook, adopted
version: [x.y.z]). Where this file conflicts with them, this file wins for this project; Belal's
latest explicit message wins over both.

## Commands

```bash
# install / run / test / lint — keep this list exact and short
```

## Working rules

- Stack and what must not change:
- Where content, config and secrets live (secrets only in env files, never in Git):
- Test accounts and data conventions (prefix, never real customers):
- Dev isolation for parallel sessions (ports, DB copy, worktrees):
- Release path and who presses what (mirror of PROJECT_CONTEXT authorization):
