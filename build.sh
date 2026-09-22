#!/usr/bin/env bash
# Build entrypoint for CI (Netlify) and local use.
#
# Bootstraps mise if it is not installed (Netlify's build image does not
# ship it), installs the tools pinned in mise.toml, then runs the build.
# mise.toml stays the single source of truth for tool versions.
set -euo pipefail

command -v mise >/dev/null 2>&1 || curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

mise install
python3 .agents/skills/build/scripts/build.py
