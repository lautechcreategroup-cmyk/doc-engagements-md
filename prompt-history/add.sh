#!/bin/sh
# Add one prompt-history entry as its own file, so branches that each log prompts never conflict.
#
# Usage:
#   prompt-history/add.sh "<title>" <<'EOF'
#   **Prompt:** <prompt>
#
#   **Summary:** <what was done>
#   EOF
#
# Writes prompt-history/YYYY-MM/YYYY-MM-DDTHHMM-<title-slug>-<4 random chars>.md, creating the
# month's folder when needed, and never reads or changes another file. The entry is a heading
# "## YYYY-MM-DD HH:MM +ZZZZ — <title>" (local time and UTC offset), a blank line, then the body.
# File names sort by time, so `cat prompt-history/YYYY-MM/*.md` reads a month in order.
#
# Quote the heredoc delimiter ('EOF') so backticks and $ in the body are kept literally.
set -eu

[ $# -eq 1 ] && [ -n "$1" ] || { echo "usage: $0 \"<title>\" < body" >&2; exit 2; }

dir=$(cd "$(dirname "$0")" && pwd)
body=$(cat)
[ -n "$body" ] || { echo "$0: empty body on stdin" >&2; exit 2; }

month=$(date +%Y-%m)
stamp=$(date +%Y-%m-%dT%H%M)
# The title in lower case, runs of anything but a-z and 0-9 as one "-", at most 60 characters.
slug=$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | LC_ALL=C sed -e 's/[^a-z0-9][^a-z0-9]*/-/g' -e 's/^-//' | cut -c1-60 | sed 's/-$//')
[ -n "$slug" ] || slug=entry

mkdir -p "$dir/$month"
# The random suffix keeps two entries with the same minute and title apart.
while :; do
  rand=$(LC_ALL=C tr -dc 'a-z0-9' </dev/urandom | dd bs=4 count=1 2>/dev/null)
  file="$dir/$month/$stamp-$slug-$rand.md"
  [ -e "$file" ] || break
done

printf '## %s — %s\n\n%s\n' "$(date '+%Y-%m-%d %H:%M %z')" "$1" "$body" > "$file"
echo "added ${file#"$dir"/}"
