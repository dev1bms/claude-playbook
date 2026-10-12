# Example — SetOdoo (verified, 2026-10-12)

Status: **معتمد** — the admin app grid and the launch video were accepted by Belal on 2026-10-12;
facts below were read from the repository and the server during that work. Repo: private
`dev1bms/setodoo`.

## What it is

Marketing site + headless CMS for SetOdoo, Bidata's Odoo division (Spanish SMEs). Spanish is the
authoritative copy; English second.

## Project-specific choices (not general preferences)

- Stack: Django 6.1 + DRF + SQLite (WAL) headless CMS with an editorial engine (drafts, per-locale
  publish, revisions, preview tokens, roles); React Router 7 SSR + Vite + Tailwind 4 + GSAP + Lenis
  + Motion; React Bits components adapted; Lucide icons.
- Identity: navy `#10233F`, blue `#355CFF`, teal `#13B8A6`, page `#F7F9FD`; Hanken Grotesk; logo
  "Encaje" (two interlocking halves). Approved docs under `docs/design/`.
- Hosting: `ubuntu-server-devbms` over Tailscale, Docker Compose (`deploy/`), Cloudflare tunnel
  `setodoo`, admin at `/gestion/`, site noindex until launch; `deploy/deploy.sh` ships `git archive`,
  backs up the DB, migrates, runs `setup_roles`; backups + restore test on cron.
- Authorization recorded there: full implement/commit/merge/push/deploy mandate for the agreed
  phases; public launch (noindex removal, legal texts, SMTP) is Belal's call.

## Practices born here that became general (now in PROFILE/WORKFLOW)

- Brief saved verbatim; council rounds with before/after captures; owner follow-up rounds.
- Admin home as an app grid with server-side permission checks, section pages, GET search that
  works without JS, compact work strip; verification matrix per role/size/zoom/dark/no-JS.
- Launch video via brag + Hyperframes (pinned), local Kokoro voice, audio rights documented, ASR
  check of the mix, posters baked as frame 0, one-command reproduction.
- Attribution-free commits adopted as a global setting after this project exposed the gap.

## Where the details live

`docs/design/admin-app-grid.md`, `docs/design/council-review.md`, `docs/cms/06-guia-del-editor.md`,
`produccion-audiovisual/video-lanzamiento-2026-10/README.md`, and the project memory
(`setodoo-project-state`, `setodoo-dev-quirks`, `setodoo-launch-video`).
