#!/usr/bin/env bash
# Copy skills from this repo into a project as reviewable, editable files.
#
#   scripts/sync.sh <target-repo> [skill ...]     all skills when none are named
#
# Each copied skill gets .claude/skills/<name>/.synced-from holding the commit it
# came from, and a .agents/skills/<name> symlink so Codex finds it too.
# On a later sync, a copy that still matches its recorded commit is updated; a
# copy with local edits is left alone and the diff against the new version is
# printed, so the edit can be ported by hand.
set -euo pipefail

usage() { echo "usage: $0 <target-repo> [skill ...]" >&2; exit 2; }
[ $# -ge 1 ] || usage

src="$(cd "$(dirname "$0")/.." && pwd)"
target="$(cd "$1" && pwd)"
shift

repo_url="$(git -C "$src" remote get-url origin 2>/dev/null || echo agent-skills)"
head="$(git -C "$src" rev-parse HEAD)"

# Skills are taken from HEAD, not the working tree, so .synced-from always names
# the exact content that was copied.
if [ -n "$(git -C "$src" status --porcelain -- skills)" ]; then
  echo "note: uncommitted changes under skills/ are not synced; commit them first" >&2
fi

if [ $# -eq 0 ]; then
  set -- $(git -C "$src" ls-tree --name-only HEAD skills/ | sed 's#^skills/##')
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

extract() {
  local rev="$1" name="$2" out="$3"
  mkdir -p "$out"
  git -C "$src" archive "$rev" "skills/$name" | tar -x -C "$out"
  echo "$out/skills/$name"
}

same_tree() {
  diff -rq -x .synced-from "$1" "$2" >/dev/null 2>&1
}

mkdir -p "$target/.claude/skills" "$target/.agents/skills"
updated=() unchanged=() skipped=()

for name in "$@"; do
  if ! git -C "$src" cat-file -e "HEAD:skills/$name" 2>/dev/null; then
    echo "error: no skill named '$name' at $head" >&2
    exit 1
  fi

  new="$(extract HEAD "$name" "$tmp/new-$name")"
  dest="$target/.claude/skills/$name"

  if [ -d "$dest" ]; then
    if same_tree "$new" "$dest"; then
      unchanged+=("$name")
    else
      old_rev=""
      [ -f "$dest/.synced-from" ] && old_rev="$(sed -n 's/^commit: //p' "$dest/.synced-from")"
      if [ -z "$old_rev" ] || ! git -C "$src" cat-file -e "$old_rev" 2>/dev/null; then
        echo "== $name: no usable .synced-from; local copy left alone. Diff (local -> upstream):"
        diff -ru -x .synced-from "$dest" "$new" || true
        skipped+=("$name")
        continue
      fi
      old="$(extract "$old_rev" "$name" "$tmp/old-$name")"
      if ! same_tree "$old" "$dest"; then
        echo "== $name: edited locally since ${old_rev:0:7}; left alone. Upstream changes to port:"
        diff -ru "$old" "$new" || true
        skipped+=("$name")
        continue
      fi
      rm -rf "$dest"
      cp -R "$new" "$dest"
      updated+=("$name")
    fi
  else
    cp -R "$new" "$dest"
    updated+=("$name")
  fi

  printf 'source: %s\ncommit: %s\n' "$repo_url" "$head" > "$dest/.synced-from"

  link="$target/.agents/skills/$name"
  if [ ! -e "$link" ] && [ ! -L "$link" ]; then
    ln -s "../../.claude/skills/$name" "$link"
  fi
done

echo
echo "synced from ${head:0:7}"
[ ${#updated[@]} -gt 0 ] && echo "  copied/updated: ${updated[*]}"
[ ${#unchanged[@]} -gt 0 ] && echo "  unchanged:      ${unchanged[*]}"
[ ${#skipped[@]} -gt 0 ] && echo "  local edits, skipped: ${skipped[*]}"
exit 0
