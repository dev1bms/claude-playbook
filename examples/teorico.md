# Example — Teorico España / MiTeorico (from session memory; confirm against the repo)

Status: **مقترح/يُستكمل** — compiled from Claude Code project memory (Aug–Oct 2026), not
re-verified for this playbook. Account ids, keys and review passwords are deliberately left out.

## What it is

DGT theory-exam preparation (Permiso B): Django web + REST API + Flutter app, es/ar/en. Repo
`dev1bms/MiTeorico`; `MASTER_PLAN.md` is the single source of truth, decisions in
`docs/decisions.md` (ADRs), work on `goal/<name>` branches merged into `main` through PRs.

## Project-specific choices

- CI gate: ruff, format check, `manage.py check`, migrations check, pytest (~600 tests, < 60 s).
- Production on the devbms server with a systemd env file (`/etc/teorico/teorico.env`): a bare
  `manage.py` on the server runs dev settings — always source the env. Staging as user services on
  the same host (`staging.teorico-es.com`).
- Releases: iOS 1.3.x–1.4.0 through App Store Connect (phased/manual release is Belal's click);
  Android closed testing gated by Google's 12-tester rule. `gh pr merge` was allowed by Belal only
  after an explicit rule was added — an example of authorization recorded per project.
- Ads and premium are per exam bank; policies switched by env.

## What generalized from it

- Authorization ladder written down per project (`gh pr merge` allowed only after an explicit
  rule).
- Review-account passwords never pasted into chat or store consoles by the assistant.
- Distinguish submitted / in review / approved / released when reporting store state.
