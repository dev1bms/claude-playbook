#!/usr/bin/env bash
# Remove the devbms-playbook global layer:
#   - delete the DEVBMS-PLAYBOOK:BEGIN/END block from ~/.claude/CLAUDE.md (other content kept);
#   - remove the "attribution" key from ~/.claude/settings.json only if it is exactly the one this
#     playbook writes ({"commit":"","pr":"","sessionUrl":false}); any other value is left alone.
# Options: --restore <file>   restore ~/.claude/CLAUDE.md or settings.json from a named backup
#                             (the file's basename decides which); repeatable
#          --list-backups     show the backups install-global.sh made
# Both files are backed up again before any change. Plugin removal itself:
#   claude plugin uninstall devbms-playbook@devbms && claude plugin marketplace remove devbms
set -euo pipefail
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
SETTINGS="$CLAUDE_DIR/settings.json"
STAMP="$(date +%Y%m%d-%H%M%S)"

if [ "${1:-}" = "--list-backups" ]; then ls -1 "$CLAUDE_DIR"/*.bak-playbook-* 2>/dev/null || echo "no backups"; exit 0; fi
if [ "${1:-}" = "--restore" ]; then
  shift
  for f in "$@"; do
    [ -f "$f" ] || { echo "no such backup: $f" >&2; exit 1; }
    case "$(basename "$f")" in
      CLAUDE.md.bak-playbook-*) cp "$CLAUDE_MD" "$CLAUDE_MD.bak-playbook-$STAMP" 2>/dev/null || true; cp "$f" "$CLAUDE_MD"; echo "✓ restored $CLAUDE_MD from $f" ;;
      settings.json.bak-playbook-*) cp "$SETTINGS" "$SETTINGS.bak-playbook-$STAMP" 2>/dev/null || true; cp "$f" "$SETTINGS"; echo "✓ restored $SETTINGS from $f" ;;
      *) echo "not a playbook backup name: $f" >&2; exit 1 ;;
    esac
  done
  exit 0
fi

if [ -f "$CLAUDE_MD" ] && grep -q "DEVBMS-PLAYBOOK:BEGIN" "$CLAUDE_MD"; then
  cp "$CLAUDE_MD" "$CLAUDE_MD.bak-playbook-$STAMP"
  python3 - "$CLAUDE_MD" <<'EOF'
import re, sys
p = sys.argv[1]; s = open(p, encoding="utf-8").read()
s = re.sub(r"\n*<!-- DEVBMS-PLAYBOOK:BEGIN.*?<!-- DEVBMS-PLAYBOOK:END -->\n*", "\n", s, count=1, flags=re.S)
open(p, "w", encoding="utf-8").write(s.strip("\n") + ("\n" if s.strip() else ""))
EOF
  echo "✓ block removed from $CLAUDE_MD (backup: $CLAUDE_MD.bak-playbook-$STAMP)"
else
  echo "= no playbook block in $CLAUDE_MD"
fi

if [ -f "$SETTINGS" ]; then
  OUT="$(python3 - "$SETTINGS" <<'EOF'
import json, sys
p = sys.argv[1]; d = json.load(open(p, encoding="utf-8"))
if d.get("attribution") == {"commit": "", "pr": "", "sessionUrl": False}:
    del d["attribution"]; print(json.dumps(d, indent=2, ensure_ascii=False) + "\n")
else:
    print("keep")
EOF
)"
  if [ "$OUT" != "keep" ]; then
    cp "$SETTINGS" "$SETTINGS.bak-playbook-$STAMP"; printf '%s' "$OUT" > "$SETTINGS"
    echo "✓ attribution key removed from $SETTINGS (backup: $SETTINGS.bak-playbook-$STAMP)"
  else
    echo "= attribution in $SETTINGS is not the playbook's value (or absent); left as is"
  fi
fi
