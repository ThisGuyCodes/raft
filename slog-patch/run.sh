#!/bin/bash
set -euo pipefail

declare -r SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR/.."

semgrep scan -c slog-patch --autofix "$@"
# for some reason I can't get them all in one go
semgrep scan -c slog-patch --autofix "$@"

PATH="$PATH:$(go env GOPATH)/bin"

$(go env GOPATH)/bin/goimports -w -local 'github.com/hashicorp' .

rm -rf testing.go *_test.go fuzzy


go mod edit -module github.com/thisguycodes/raft
go mod tidy
