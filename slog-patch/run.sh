#!/bin/bash
set -euo pipefail

# this must be run when the CWD is the repo we want to change
declare -r REPO_DIR="$(git rev-parse --show-toplevel)"
cd "$REPO_DIR"

semgrep scan -c slog-patch --autofix "$@"
# for some reason I can't get them all in one go
semgrep scan -c slog-patch --autofix "$@"

PATH="$PATH:$(go env GOPATH)/bin"

$(go env GOPATH)/bin/goimports -w -local 'github.com/hashicorp' .

rm -rf testing.go *_test.go fuzzy


go mod edit -module github.com/thisguycodes/raft
go mod edit -go 1.21
go mod tidy
exec go build
