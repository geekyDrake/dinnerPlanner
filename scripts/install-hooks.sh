#!/usr/bin/env bash
# One-time setup per clone: point git at the versioned hooks in .githooks/.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
git config core.hooksPath .githooks
chmod +x .githooks/* ./*/.hooks/* 2>/dev/null || true
echo "Git hooks installed (core.hooksPath=.githooks)"
