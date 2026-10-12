---
name: ui-review
description: Verify a web or admin UI the way Belal expects — every role, 390/768/1366/1440/1920 and 200% zoom, dark mode, reduced motion, no-JavaScript where it applies, real flows, before/after contact sheets and a short walkthrough recording, all with dev data. Use for "راجع الواجهة", "صور قبل وبعد", "تسجيل مرور", "/devbms-playbook:ui-review", or before closing any visual phase.
---

# ui-review

Automated checks support the judgement; the screen decides. Dev servers and dev accounts only —
never production, never Belal's account, never real customer data in a capture.

## Matrix

| Axis | Values |
| --- | --- |
| Roles | every role the product defines (e.g. editor, publisher, enquiry reviewer, admin, superuser) |
| Widths | 390, 768, 1366, 1440, 1920; plus 1366 at `deviceScaleFactor: 2` with a 683-wide viewport (= 200 % zoom) |
| Themes | light, dark (`colorScheme`), and the app's own toggle if it has one |
| Motion | normal and `reducedMotion: "reduce"` — entrances must resolve instantly, nothing hidden |
| Script | JavaScript disabled where the page is server-rendered: links, forms (GET search), menus still work |
| Access | direct URLs that a role must not open return 403/404; counts or names of unseen content never appear in the HTML |

## How (Playwright, from the project's own install)

- Log in with a dev account in one context; capture pages with `fullPage: true`; record
  `document.documentElement.scrollWidth > innerWidth` (horizontal overflow), `pageerror` and
  console errors per capture; write a `report.json` next to the PNGs.
- Before/after sheets: scale captures to ~1/3 and tile them with labels (Pillow from the project
  venv works when ffmpeg lacks `drawtext`).
- Walkthrough: a `recordVideo` context after logging in (so the login never appears), 15–25 s,
  showing the real flow (hover, search, keyboard, open a section, toggle theme); convert with
  `ffmpeg -c:v libx264 -crf 24 -pix_fmt yuv420p -movflags +faststart -an`.
- Interaction checks: keyboard focus order and visible focus ring, hover states, idle cost (count
  `requestAnimationFrame` calls over 1 s when nothing moves — expect 0), live search results.
- Admin pages: a Django test client pass per role with `CaptureQueriesContext` for query count,
  median time and HTML size, before and after.

## Judge against Belal's taste

Immediate readability of the important content; density without empty space; clear page
changes; coloured, meaningful icons; comfortable targets; the phone laid out on purpose, not a
crop; nothing repeated under two names; motion that explains and stops. Fix what the captures
show, re-capture, and keep the final set under `docs/design/review/<task>/{before,after}/` with
comparison sheets and the recording. Report in Arabic with the measured numbers.
