---
name: deploy-devbms
description: Deploy a Django-based project to Belal's own Ubuntu server (ubuntu-server-devbms over Tailscale) following the house pattern — one Cloudflare tunnel per domain, user-level systemd or Docker Compose without sudo, DB backup before migrate, verify REVISION and headers after. Use for "انشر على السيرفر", "اربط الدومين بالنفق", "/devbms-playbook:deploy-devbms", only when docs/PROJECT_CONTEXT.md authorizes production deployment.
---

# deploy-devbms

Parameters come from `docs/PROJECT_CONTEXT.md` (host, user, paths, ports, tunnel name, deploy
script). Defaults seen across projects (verify, do not assume): host `100.90.40.92` over
Tailscale, user `devbms`, SSH key from the Mac, `sudo` needs a password and is avoided.

## House pattern

- **Per domain**: its own Cloudflare tunnel (`cloudflared tunnel login` for *that* zone — reusing
  another zone's certificate writes DNS into the wrong zone), its own config under
  `~/.cloudflared/<name>.yml`, and a matching pair of **user** systemd units with lingering on,
  or a Docker Compose stack (newer projects) bound to `127.0.0.1:<port>`.
- **Code**: shipped as a `git archive` of a commit (never the local DB, `.env` or dev credentials);
  previous release kept (`src.prev`); `REVISION` file written.
- **Data**: SQLite + media under the project's data dir; secrets in an env file mode 600; the DB
  backed up before `migrate` (`sqlite3 .backup`), and scheduled backups with an isolated restore
  test for anything that holds customer data.
- **Statics**: WhiteNoise with hashed names; `collectstatic` in the image/build step, never files
  generated on the dev machine.
- **Pre-launch**: `noindex` headers/meta until Belal approves launch; security headers set.

## Steps

1. Confirm authorization and that `main` (or the agreed ref) is pushed; note the commit.
2. Run the project's deploy script (`deploy/deploy.sh <ref>` or `scripts/deploy_upgrade.sh`); if
   none exists, write one following the pattern and commit it first.
3. Read back: `cat <project>/src/REVISION`, service status, `curl -sI` public URLs (200,
   `x-robots-tag`, HSTS/nosniff), an authenticated or server-side render of one admin page where
   relevant, smoke checks of the key flows with `[TEST]`-marked data only.
4. Confirm nothing else on the host changed (other domains still answer).
5. Record the deployed commit, backup file name and time in `docs/PROJECT_STATE.md`; report in
   Arabic.

Never run tests against production data, never create accounts on production for testing, never
force-login or alter Belal's own account.
