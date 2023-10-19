#!/bin/bash
set -euo pipefail

declare -r SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR/.."

exec semgrep scan -c slog-patch --autofix "$@"
