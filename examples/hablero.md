# Example — Hablero (from session memory; confirm against the repo before relying on it)

Status: **مقترح/يُستكمل** — compiled from Claude Code project memory written in Sep–Oct 2026, not
re-verified for this playbook. Identifiers (App Store Connect ids, keys) are deliberately left out;
they live in the project's own memory and docs.

## What it is

Spanish-learning app for Arabic/English speakers. Django 5.2 backend, Flutter 3.44 mobile app, a
React web client at `/app/`. Private repo `dev1bms/Hablero`.

## Project-specific choices

- Phased delivery named FOUNDATION-01, MEDIA-01, BRAND-01…, each closed with a report
  (`docs/FOUNDATION_REPORT.md`, `docs/PROJECT_STATE.md`).
- Production at hablero.es on the devbms server: Cloudflare tunnel straight to gunicorn, user-level
  systemd units, secrets in `backend/.env` (600), WhiteNoise statics; release = rsync, migrate,
  collectstatic, `kill -HUP` gunicorn (no sudo).
- iOS released on the App Store (1.0 then 1.0.1); release toolchain documented in memory because
  the plain `flutter build ipa` fails on a cached provisioning profile.
- Verification on the iOS simulator through `integration_test` + a local answer helper, not hand
  taps.

## What generalized from it

- The three-state honest report format.
- "An upload is not approval": reading App Store state from the API before claiming anything.
- One tunnel + one systemd pair per domain on the shared server.
