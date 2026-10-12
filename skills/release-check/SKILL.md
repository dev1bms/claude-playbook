---
name: release-check
description: Check readiness and authorization before any release step (push, merge, deploy, TestFlight/closed testing, store review, public release, marketing) and read the real post-release state instead of assuming it. Use for "انشر", "ارفع", "قدّم للمراجعة", "هل جاهز للنشر", "/devbms-playbook:release-check", or at the end of a phase that touches production or stores.
---

# release-check

Never invent a permission. The ladder in `docs/PROJECT_CONTEXT.md` is the only source; a
permission given in another project or an earlier task does not carry over.

## 1. Readiness

- Phase acceptance criteria met and the report written; checks green; no secret, credential or
  real customer data in the diff, screenshots or docs.
- Dependencies pinned; new assets have documented rights.
- The change is on a branch; `main` is clean and up to date with origin.
- Rollback known (previous release kept, DB backup path, store "previous build").

## 2. Authorization ladder (stop at the first rung not authorized)

commit → push → merge to main → production deploy → internal distribution (TestFlight / Play
closed testing) → review submission → public release → marketing publication / paid campaigns.
When a rung is "Belal's click" (store release, noindex removal, legal go-live), prepare everything
and hand over the exact next action.

## 3. Execute what is authorized, then read the truth back

- Web (devbms pattern): `/devbms-playbook:deploy-devbms`; then `cat REVISION` on the server,
  `curl -sI` the public URLs (status, `x-robots-tag`, security headers), one authenticated
  server-side render where appropriate, and smoke checks. Confirm the public site did not pick up
  admin-only assets.
- Stores: read the actual state from App Store Connect / Play Console APIs (version state, build
  attached, review state); report submitted / in review / approved / released as distinct states.
  Review-account passwords are never pasted into chat or consoles by the assistant.
- Record the result with date/time in `docs/PROJECT_STATE.md`.

## 4. Report (Arabic)

The rung reached, the commit or build identifiers, the real state read back, what remains
Belal's click, and anything deferred.
