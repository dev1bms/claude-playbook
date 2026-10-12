---
name: launch-video
description: Produce a launch or marketing video for one of Belal's products with brag + Hyperframes (pinned versions, local Kokoro voice), in square and vertical formats with and without voice, posters, Spanish/Arabic copy, documented audio rights and a one-command reproduction. Use for "فيديو إطلاق", "vídeo de lanzamiento", "/devbms-playbook:launch-video", or a /brag request on a product of Belal's.
---

# launch-video

Runs the full `/brag --full --voice` workflow (install `brag@brag` if missing) with Belal's
constraints layered on top. Keep everything in a separate production folder
(`produccion-audiovisual/<video>-<yyyy-mm>/`), never inside the site's source.

## Constraints that always apply

- Only public, approved claims from the product itself (published API/content); no people,
  portraits, clients, numbers, savings, certifications, guarantees, admin screens or private data.
- Real logo and fonts from the approved identity; diagrams redrawn from the product's own visuals.
- Pin `hyperframes` and `gsap` to releases ≥ 2 weeks old (`npm view <pkg> time`); Kokoro in its own
  venv with every Python pin dated (`pip install --dry-run --report` + PyPI upload dates).
- Document commercial rights of every audio asset (ende.app CC BY 4.0 — credit in the post, no
  Content ID; Kenney CC0; Kokoro Apache-2.0) in `derechos-y-fuentes.md`.
- Disable Hyperframes telemetry; no network at render (local GSAP, fonts, audio).

## Craft notes learned (SetOdoo, 2026-10)

- One Hyperframes project = one root composition → generate variants into `variantes/<name>/`
  from a single `template.html` with a build script; never edit generated `index.html`.
- `tl.set(...)` at time 0 does not render at t=0: hide late elements in CSS too.
- Spanish voice `ef_dora`, phonemizer `es`; respell the brand phonetically for TTS only
  («Set Odú»), keep official spelling on screen; normalize each line to −16 LUFS with a soft
  limiter; keep SFX off the spoken brand name; music bed ≈16 dB under the voice, raise it to ≈0.85
  for the no-voice copies; start the bed so a strong beat lands on the key reveal.
- Verify by transcribing the rendered mix (parakeet-mlx, direct call) and by contact sheets of
  every scene/transition from the final MP4s; bake the poster as frame 0 with ffmpeg.
- Deliverables: 1080×1080 and 1080×1920 (true re-layout), with and without voice, a poster per
  format, post copy, `README.md` with creative decisions, `npm run render` reproduction.
