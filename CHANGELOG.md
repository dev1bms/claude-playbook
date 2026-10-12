# CHANGELOG

## 1.0.0 — 2026-10-12

- الإصدار الأول. المصدر: `Belal_AI_Development_Playbook_v1.md` (محفوظ حرفياً في `docs/sources/`)
  مدموجاً مع ما ثبت في جلسات SetOdoo (2026-10-11/12) وذاكرات Hablero وTeorico وOasis وGames
  وCDR وLifelineCommand.
- قرار: تعطيل إسناد Claude في الـcommits والـPRs بإعداد `attribution` على الشكل
  `{"commit": "", "pr": "", "sessionUrl": false}` لأن Claude Code المثبت (2.1.195) يرفض القيمة
  `false` (تحتاج 2.1.281+) ويتجاهل ملف الإعدادات كله عندها. إشعارات تراخيص الطرف الثالث لا
  علاقة لها بهذا وتبقى.
- قرار: اسم السوق `devbms` لا `claude-playbook` تجنباً لقاعدة انتحال الأسماء الرسمية؛ اسم
  المستودع يبقى `dev1bms/claude-playbook`.
- لم يُعد كتابة أي تاريخ Git (SetOdoo يحمل 88 commit بسطر الإسناد القديم؛ تُركت كما هي).
- المهارات: project-start، phase، ui-review، release-check، project-close، deploy-devbms،
  launch-video.
