#!/usr/bin/env bash
# Install the Python CLI tools from uv/tools.
#
# uv itself is deliberately not installed here: it lives in ~/.local/bin from
# its own installer and updates with `uv self update`, so a brew copy would
# only shadow it. The module skips when uv is missing.
source "$(dirname -- "${BASH_SOURCE[0]}")/../lib.sh"

have uv || {
    say "uv is not installed - skipping"
    say "install it with: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 0
}

installed="$(uv tool list 2>/dev/null | awk '$1 != "-" { print $1 }')"

while IFS= read -r spec; do
    name="${spec%%[*}"
    if printf '%s\n' "${installed}" | grep -qxF "${name}"; then
        say "tool   ${name} already installed"
    elif uv tool install "${spec}"; then
        say "tool   ${spec}"
    else
        warn "tool ${spec} failed to install"
    fi
done < <(read_list "${ENV_ROOT}/uv/tools")
