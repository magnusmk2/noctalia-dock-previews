#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${1:-}"
expected_commit="125a30d4f13e86200e704a013d17ac0ed88a8044"
patch_file="$repo_root/patches/noctalia-v5.4.0-window-previews.patch"

if [[ -z "$source_root" ]]; then
  printf 'Usage: %s /path/to/noctalia-v5.4.0\n' "$0" >&2
  exit 2
fi
if [[ ! -d "$source_root/.git" && ! -f "$source_root/.git" ]]; then
  printf 'Not a Git checkout: %s\n' "$source_root" >&2
  exit 2
fi

actual_commit="$(git -C "$source_root" rev-parse HEAD)"
if [[ "$actual_commit" != "$expected_commit" ]]; then
  printf 'Expected Noctalia v5.4.0 at %s, got %s\n' "$expected_commit" "$actual_commit" >&2
  exit 1
fi

git -C "$source_root" apply --check "$patch_file"
printf 'Patch applies cleanly to Noctalia v5.4.0 (%s).\n' "$actual_commit"
