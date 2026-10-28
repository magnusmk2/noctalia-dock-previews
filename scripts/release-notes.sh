#!/usr/bin/env bash
set -euo pipefail

tag="${1:-}"
if [[ ! "$tag" =~ ^v([0-9]+\.[0-9]+\.[0-9]+)$ ]]; then
  printf 'Usage: %s vMAJOR.MINOR.PATCH\n' "$0" >&2
  exit 2
fi
version="${BASH_REMATCH[1]}"

awk -v heading="## $version" '
  $0 == heading { found = 1; next }
  found && /^## / { exit }
  found {
    lines[++count] = $0
    if ($0 ~ /[^[:space:]]/) has_content = 1
  }
  END {
    if (!found) {
      printf "No changelog section found for %s\n", heading > "/dev/stderr"
      exit 1
    }
    if (!has_content) {
      printf "Changelog section %s is empty\n", heading > "/dev/stderr"
      exit 1
    }
    first = 1
    while (first <= count && lines[first] ~ /^[[:space:]]*$/) first++
    while (count >= first && lines[count] ~ /^[[:space:]]*$/) count--
    for (i = first; i <= count; i++) print lines[i]
  }
' CHANGELOG.md
