#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[smoke] checking local saved session..."
if ! uv run python -m xhs_cli.cli status >/dev/null 2>&1; then
  echo "[smoke] no valid saved session. run 'uv run python -m xhs_cli.cli login' first."
  exit 1
fi

echo "[smoke] running integration smoke tests..."
uv run pytest tests/test_integration.py -v --override-ini="addopts=" -m integration "$@"
