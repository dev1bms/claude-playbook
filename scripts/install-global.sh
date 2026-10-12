#!/usr/bin/env bash
# Install the devbms-playbook global layer on this machine, idempotently:
#   1. back up ~/.claude/CLAUDE.md and ~/.claude/settings.json (timestamped copies);
#   2. insert or replace the block between DEVBMS-PLAYBOOK:BEGIN/END in ~/.claude/CLAUDE.md,
#      leaving everything else (e.g. the fablize block) untouched;
#   3. set "attribution" to {"commit": "", "pr": "", "sessionUrl": false} in settings.json unless
#      an attribution key already exists (--force-attribution replaces it), merging every other key.
# Options: --no-attribution   skip step 3
#          --force-attribution replace an existing attribution key
#          --dry-run           print what would change, write nothing
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
SETTINGS="$CLAUDE_DIR/settings.json"
BLOCK="$HERE/adapters/claude/CLAUDE.md"
STAMP="$(date +%Y%m%d-%H%M%S)"
DO_ATTR=1; FORCE_ATTR=0; DRY=0
for a in "$@"; do
  case "$a" in
    --no-attribution) DO_ATTR=0 ;;
    --force-attribution) FORCE_ATTR=1 ;;
    --dry-run) DRY=1 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done
mkdir -p "$CLAUDE_DIR"
[ -f "$BLOCK" ] || { echo "missing $BLOCK" >&2; exit 1; }

# --- CLAUDE.md -------------------------------------------------------------------------------
touch "$CLAUDE_MD"
NEW_MD="$(python3 - "$CLAUDE_MD" "$BLOCK" <<'EOF'
import re, sys
current = open(sys.argv[1], encoding="utf-8").read()
block = open(sys.argv[2], encoding="utf-8").read().strip("\n")
pat = re.compile(r"<!-- DEVBMS-PLAYBOOK:BEGIN.*?<!-- DEVBMS-PLAYBOOK:END -->", re.S)
if pat.search(current):
    out = pat.sub(lambda m: block, current, count=1)
else:
    out = current.rstrip("\n") + ("\n\n" if current.strip() else "") + block + "\n"
sys.stdout.write(out)
EOF
)"
if [ "$NEW_MD" != "$(cat "$CLAUDE_MD")" ]; then
  if [ $DRY = 1 ]; then echo "would update $CLAUDE_MD (block inserted/replaced)"; else
    cp "$CLAUDE_MD" "$CLAUDE_MD.bak-playbook-$STAMP"
    printf '%s\n' "$NEW_MD" > "$CLAUDE_MD"
    echo "✓ $CLAUDE_MD updated (backup: $CLAUDE_MD.bak-playbook-$STAMP)"
  fi
else
  echo "= $CLAUDE_MD already current"
fi

# --- settings.json: attribution ----------------------------------------------------------
if [ $DO_ATTR = 1 ]; then
  [ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
  RESULT="$(python3 - "$SETTINGS" "$FORCE_ATTR" <<'EOF'
import json, sys
path, force = sys.argv[1], sys.argv[2] == "1"
data = json.load(open(path, encoding="utf-8"))
wanted = {"commit": "", "pr": "", "sessionUrl": False}
if "attribution" in data and not force:
    print("exists" if data["attribution"] != wanted else "same")
    sys.exit(0)
data["attribution"] = wanted
print(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
EOF
)"
  case "$RESULT" in
    same) echo "= attribution already off in $SETTINGS" ;;
    exists) echo "! $SETTINGS already has an 'attribution' key; left as is (use --force-attribution to replace)" ;;
    *) if [ $DRY = 1 ]; then echo "would set attribution={commit:'',pr:'',sessionUrl:false} in $SETTINGS"; else
         cp "$SETTINGS" "$SETTINGS.bak-playbook-$STAMP"
         printf '%s' "$RESULT" > "$SETTINGS"
         python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$SETTINGS"
         echo "✓ attribution off in $SETTINGS (backup: $SETTINGS.bak-playbook-$STAMP)"
       fi ;;
  esac
fi
echo "done — restart Claude Code sessions to pick up the global instructions"
