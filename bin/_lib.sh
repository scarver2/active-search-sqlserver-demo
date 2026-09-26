#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$BIN_DIR/.." && pwd)"
MISE_BIN="${MISE_BIN:-$(command -v mise || true)}"
MISE_BIN="${MISE_BIN:-${HOME}/.local/bin/mise}"

cd "$ROOT_DIR"

ENV_FILE="$ROOT_DIR/.env"

if [[ ! -f "$ENV_FILE" ]]; then
  password="$(/usr/bin/openssl rand -hex 24)Aa1!"
  printf 'MSSQL_SA_PASSWORD=%s\nSQLSERVER_PASSWORD=%s\n' "$password" "$password" > "$ENV_FILE"
  chmod 600 "$ENV_FILE"
fi

set -a
source "$ENV_FILE"
set +a

compose() {
  docker compose -f compose.yml "$@"
}

ruby_exec() {
  "$MISE_BIN" exec -- "$@"
}

create_databases() {
  compose exec -T sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C \
    -Q "IF DB_ID('active_search_demo_development') IS NULL CREATE DATABASE active_search_demo_development; IF DB_ID('active_search_demo_test') IS NULL CREATE DATABASE active_search_demo_test"
}
