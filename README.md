# devbms-playbook — دليل عمل بلال مع الذكاء الاصطناعي

المرجع الشخصي لطريقة عمل Belal Alswerki (devbms) في تطوير المشاريع بمساعدة الذكاء الاصطناعي،
وطبقة تنفيذ له في Claude Code (إضافة + مهارات).

الإصدار: **1.0.0** — 12 أكتوبر 2026. سجل التغييرات في [CHANGELOG.md](CHANGELOG.md).

## الطبقات

| الطبقة | الملفات | لمن |
| --- | --- | --- |
| **المرجع** (قابل للاستخدام مع أي مساعد) | [PROFILE.md](PROFILE.md) التفضيلات · [WORKFLOW.md](WORKFLOW.md) دورة العمل ومعيار القبول · [TOOLS.md](TOOLS.md) الأدوات ومتى تفيد | بلال، وأي مساعد يُرفق له الملف |
| **المحوّلات** | [adapters/claude/CLAUDE.md](adapters/claude/CLAUDE.md) الكتلة التي تُدمج في `~/.claude/CLAUDE.md` · [adapters/generic/PLAYBOOK_SUMMARY.md](adapters/generic/PLAYBOOK_SUMMARY.md) ملخص يُلصق في ChatGPT أو غيره | Claude Code / مساعدات أخرى |
| **القوالب** | `templates/` سياق المشروع، حالته، تقرير المرحلة، CLAUDE.md للمشروع | كل مشروع جديد |
| **الأمثلة** | `examples/` SetOdoo (معتمد)، Hablero وTeorico (من الذاكرة، تُستكمل) | مرجع للقرارات الخاصة بكل مشروع |
| **المهارات** | `skills/` سبع مهارات تُستدعى بـ`/devbms-playbook:<name>` | Claude Code |

الفصل الحاكم: **PROFILE/WORKFLOW/TOOLS** تحمل ما يصح على كل المشاريع فقط. لغة المنتج والتقنيات
والخادم وصلاحيات الدمج والنشر وإصدارات المتاجر تبقى في `PROJECT_CONTEXT.md` داخل كل مشروع
(القالب في `templates/`). وجود تفويض في مشروع لا يمنحه لمشروع آخر.

## التثبيت في Claude Code

```bash
claude plugin marketplace add dev1bms/claude-playbook
```

```bash
claude plugin install devbms-playbook@devbms
```

ثم دمج الكتلة الشخصية في `~/.claude/CLAUDE.md` وتعطيل إسناد Claude في الـcommits (مع نسخة
احتياطية مؤرخة لكل ملف يُلمس):

```bash
bash ~/.claude/plugins/cache/devbms/devbms-playbook/*/scripts/install-global.sh
```

التثبيت المتكرر آمن: الكتلة تُستبدل بين علامتي `DEVBMS-PLAYBOOK:BEGIN/END` ولا تُكرَّر، والإعدادات
تُدمج دون حذف مفاتيح قائمة (fablize والإضافات الأخرى تبقى كما هي).

## التحديث

```bash
claude plugin marketplace update devbms && claude plugin update devbms-playbook@devbms
```

ثم أعد تشغيل `install-global.sh` إذا تغيّر المحوّل (يُذكر في CHANGELOG).

## إلغاء التثبيت واستعادة الإعدادات

```bash
bash ~/.claude/plugins/cache/devbms/devbms-playbook/*/scripts/uninstall-global.sh
```

يزيل الكتلة من `~/.claude/CLAUDE.md` ويعيد إعداد `attribution` إلى وضعه السابق من آخر نسخة
احتياطية (أو `--restore <ملف>` لاختيار نسخة بعينها). ثم:

```bash
claude plugin uninstall devbms-playbook@devbms && claude plugin marketplace remove devbms
```

## الاستخدام في مشروع جديد

```text
/devbms-playbook:project-start
```

يقرأ المرجع، يفحص المشروع، ويكتب `docs/PROJECT_CONTEXT.md` و`CLAUDE.md` من القوالب مع تسجيل
إصدار الدليل المعتمد. رسالة البدء المقترحة في [WORKFLOW.md §7](WORKFLOW.md).

## ملاحظتان بعد التثبيت

- الإضافة المثبّتة في منتصف جلسة لا تظهر فيها؛ افتح جلسة جديدة لاستعمال `/devbms-playbook:*`.
- `claude -p` من الطرفية داخل تطبيق Desktop غير مسجَّل الدخول (يحتاج `claude login` مستقلاً).
- سجل التحقق: [docs/VERIFICATION-2026-10-12.md](docs/VERIFICATION-2026-10-12.md).

## الصيانة

- التعديل على المرجع يمر بـcommit في هذا المستودع مع سطر في CHANGELOG؛ لا يُغيَّر سلوك كل
  المشاريع من تعديل غير مراجَع.
- كل مشروع يسجل الإصدار الذي اعتمده في `PROJECT_CONTEXT.md`.
- التحقق قبل كل إصدار: `bash scripts/check.sh` (يشغّل `claude plugin validate` ويفحص المهارات).
- المصدر الأصلي للإصدار 1.0: [docs/sources/Belal_AI_Development_Playbook_v1.md](docs/sources/Belal_AI_Development_Playbook_v1.md) محفوظ حرفياً.
