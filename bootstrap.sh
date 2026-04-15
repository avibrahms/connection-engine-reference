#!/usr/bin/env bash
set -euo pipefail
command -v sz >/dev/null || curl -sSL https://systemzero.dev/i | sh
export SZ_CATALOG="${SZ_CATALOG:-https://raw.githubusercontent.com/avibrahms/system-zero/main/catalog/index.json}"
sz init --host generic --no-genesis --yes --force
cp .sz/repo-profile.seed.json .sz/repo-profile.json
MODULES=(
  heartbeat
  immune
  subconscious
  action-card-cleanup-ce
  agent-dashboard-ce
  check-linkedin-autopost-policy-ce
  chronicle-ce
  context-assembler-ce
  eidetic-ce
  mcp-server-launcher-ce
  queue-gate-ce
  registry-validator-ce
  rollback-email-verification-ce
  sentinel-ce
  session-bootstrap-ce
  skill-library-ce
  spec-dependency-graph-ce
  spec-lint-ce
  start-preamble-ce
  system-zero-ce
)
for module_id in "${MODULES[@]}"; do
  sz install "$module_id" --force
done
sz reconcile
sz tick --reason bootstrap
sz doctor
sz list
