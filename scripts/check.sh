#!/usr/bin/env bash
# Repo self-check: manifests validate, every skill has frontmatter with name + description,
# scripts parse, adapter markers are present, versions agree. Run before tagging a release.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$HERE"
fail=0
echo "== claude plugin validate (plugin + marketplace)"
claude plugin validate . || fail=1
echo "== skills"
for s in skills/*/SKILL.md; do
  head -1 "$s" | grep -q '^---$' || { echo "no frontmatter: $s"; fail=1; }
  grep -q '^name: ' "$s" || { echo "no name: $s"; fail=1; }
  grep -q '^description: ' "$s" || { echo "no description: $s"; fail=1; }
  [ "$(grep -m1 '^name: ' "$s" | cut -d' ' -f2)" = "$(basename "$(dirname "$s")")" ] || { echo "name != folder: $s"; fail=1; }
done
echo "   $(ls skills | wc -l | tr -d ' ') skills"
echo "== scripts"
for f in scripts/*.sh; do bash -n "$f" && echo "   ok $f" || fail=1; done
echo "== adapter"
grep -q 'DEVBMS-PLAYBOOK:BEGIN' adapters/claude/CLAUDE.md && grep -q 'DEVBMS-PLAYBOOK:END' adapters/claude/CLAUDE.md || { echo "adapter markers missing"; fail=1; }
echo "== versions"
PV="$(python3 -c "import json;print(json.load(open('.claude-plugin/plugin.json'))['version'])")"
grep -q "BEGIN v$PV" adapters/claude/CLAUDE.md || { echo "adapter block version != plugin.json ($PV)"; fail=1; }
grep -q "^## $PV " CHANGELOG.md || { echo "CHANGELOG has no entry for $PV"; fail=1; }
[ $fail = 0 ] && echo "ALL OK ($PV)" || { echo "FAILED"; exit 1; }
