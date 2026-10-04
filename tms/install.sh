#!/usr/bin/env bash
# Configure tmux-sessionizer.
#
# Search paths are applied with `tms config` rather than by symlinking
# ~/Library/Application Support/tms/config.toml, because tms owns that file:
# it rewrites it whenever a bookmark, mark or session config changes.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

have tms || { say "tms is not installed - skipping"; exit 0; }

paths=()
depths=()
while read -r path depth; do
    [ -n "${path}" ] || continue
    paths+=( "${path}" )
    depths+=( "${depth}" )
done < <(read_list "${ENV_ROOT}/tms/paths")

[ "${#paths[@]}" -gt 0 ] || die "no search paths in tms/paths"

tms config --paths "${paths[@]}" --max-depths "${depths[@]}" \
    --full-path true >/dev/null

for i in "${!paths[@]}"; do
    say "path   ${paths[i]} (depth ${depths[i]})"
done
