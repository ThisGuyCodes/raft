#!/bin/bash
set -euo pipefail

declare -r SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR/.."

semgrep scan -c slog-patch --autofix "$@"

PATH="$PATH:$(go env GOPATH)/bin"

$(go env GOPATH)/bin/goimports -w -local 'github.com/hashicorp' .
