# Verification — 1.0.0 install on Belal's Mac (2026-10-12)

Environment: Claude Code 2.1.195 (desktop app session), macOS. No product repo or server was
touched; tests used a throwaway project in the session scratchpad and copies of the real config.

| Check | Result |
| --- | --- |
| `claude plugin validate .` | Validation passed (plugin + marketplace) |
| `scripts/check.sh` | ALL OK (7 skills with frontmatter, scripts parse, adapter markers, version = CHANGELOG) |
| Sandbox install on copies of `~/.claude/CLAUDE.md` + `settings.json` | block inserted; fablize block intact (1 BEGIN/1 END); `attribution` set; every other key unchanged; enabledPlugins untouched |
| Second install (idempotency) | "already current" / "already off" — no duplicate block |
| `uninstall-global.sh` | block removed; attribution key removed; both files back to original |
| `uninstall-global.sh --restore <backup>` | restored from the timestamped backup |
| Real install | backups `*.bak-playbook-20261012-231248` and `-232132`; block at lines 13–54 after fablize (1–11) |
| Private repo | https://github.com/dev1bms/claude-playbook, visibility PRIVATE, branch main |
| `claude plugin marketplace add dev1bms/claude-playbook` | marketplace `devbms` added |
| `claude plugin install devbms-playbook@devbms` | 1.0.0 enabled, scope user |
| `claude plugin details` | Skills (7): deploy-devbms, launch-video, phase, project-close, project-start, release-check, ui-review; ~732 always-on tokens |
| Repeat install / marketplace update / plugin update | "already installed" / updated / "already at the latest version" |
| Uninstall → list → reinstall | uninstalled; 0 listed; reinstalled 1.0.0 enabled |
| Project-level conflicts | 9 project settings files scanned, 0 set `attribution`/`includeCoAuthoredBy`; no project CLAUDE.md asks for AI attribution |
| Skill run in a throwaway project | `project-start` executed from the installed copy: `docs/PROJECT_CONTEXT.md` (authorization ladder, adopted version 1.0.0), `docs/PROJECT_STATE.md`, `CLAUDE.md`; commit `d86251f`; 0 attribution lines |
| Attribution-off in a live session | the session harness switched to "no attribution lines" right after the setting was written; this repo's later commits carry none |

Known limits:

- A plugin installed in the middle of a session is not callable in that session (skills register at
  session start); open a new session to use `/devbms-playbook:*`.
- `claude -p` from a shell inside the desktop app is not signed in (separate `claude login`); the
  headless skill run therefore could not be used as evidence and the skill was executed from its
  installed copy instead.
