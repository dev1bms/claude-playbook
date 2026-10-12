---
name: phase
description: Deliver one numbered phase of a project Belal's way — isolate the work, implement to acceptance criteria, verify, commit without AI attribution, write the Arabic three-state phase report, and release only within the authorization recorded in docs/PROJECT_CONTEXT.md. Use for "نفّذ المرحلة", "أكمل المرحلة", "/devbms-playbook:phase", or any delivered brief that asks for implementation plus testing plus delivery.
---

# phase

## Before coding

- Read `docs/PROJECT_CONTEXT.md` (authorization ladder, exclusions) and `docs/PROJECT_STATE.md`.
  If they are missing, run `/devbms-playbook:project-start` first.
- Save any new brief verbatim in `docs/`; keep decisions in a companion doc.
- Isolate: own branch (and worktree when another session may use the folder), own dev ports,
  a copied dev database, dedicated test accounts (`prueba.*` / `tech-*` style). Never act as
  Belal's own account; never `force_login` an account with a pending password link.
- Take "before" evidence for anything visual or measurable (screens, query counts, timings).
- Write the phase's stories with acceptance criteria; with fablize installed, `goals.py create`
  from the repo root and checkpoint each story with evidence.

## While building

- Inspect, then change; prefer the project's existing conventions and approved stack.
- Preferred libraries (GSAP, Lenis, React Bits, Three.js) are evaluated per screen; note why one
  is not used. Pin new dependencies to releases ≥ 2 weeks old and check the upload date.
- Every external asset: source, licence, commercial rights recorded before use.
- Routine decisions: decide and list them in the report. Impactful ones: 2–3 alternatives, wait.
- Keep secrets out of chat, screenshots and Git; back up before DB or settings changes.

## Verification gate (do not skip)

- Run the checks that cover the change and the existing suites; fix, do not disable.
- Visual and flow verification per `/devbms-playbook:ui-review` when the change is visible.
- Measure before/after where numbers exist (page height, queries, timing, loudness…).

## Commit

- Small English commits describing the change. **No AI attribution lines** (the global
  `attribution` setting removes them; if a trailer still appears, remove it before committing).
- Never rewrite history or force-push without an explicit request.

## Release — only what PROJECT_CONTEXT authorizes

Push / merge / deploy / distribute / submit / publish each only if its line says so for this
project. Otherwise stop at the commit and say what the next authorized step is. After any release
step, read the real state back (server REVISION, response headers, store status) and record it in
`PROJECT_STATE.md`.

## Report (Arabic, `templates/PHASE_REPORT.ar.md`)

Result first; what changed; implemented-and-tested / implemented-unverified / deferred with
evidence and measurements; where to try it (links, files, commit, real release state); what
remains and the batched questions; decisions taken alone. Update `PROJECT_STATE.md`.
