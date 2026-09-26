#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="$(cd "$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$BIN_DIR/.." && pwd)"
MISE_BIN="\${MISE_BIN:-\${HOME}/.local/bin/mise}"

cd "$ROOT_DIR"

compose() {
  docker compose -f compose.yml "$@"
}

ruby_exec() {
  "$MISE_BIN" exec -- "$@"
}
