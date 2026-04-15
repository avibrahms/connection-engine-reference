#!/usr/bin/env bash
set -euo pipefail
command -v sz >/dev/null || curl -sSL https://systemzero.dev/i | sh
sz init --host generic --no-genesis --force
cp .sz/repo-profile.seed.json .sz/repo-profile.json
mkdir -p .sz/module-sources
BASE_MODULES=(heartbeat immune subconscious)
CE_MODULES=(
  action-card-cleanup-ce
  agent-dashboard-ce
  argentina-ce
  business-ce
  check-linkedin-autopost-policy-ce
  chronicle-ce
  context-assembler-ce
  eidetic-ce
  google-ads-ce
  identity-ce
  linkedin-content-pipeline-ce
  linkedin-messaging-ce
  mass-market-ce
  mcp-server-launcher-ce
  moonshot-init-tracking-files-ce
  moonshot-ventures-ce
  queue-gate-ce
  registry-validator-ce
  rollback-email-verification-ce
  sentinel-ce
  session-bootstrap-ce
  solo-venture-ce
  spec-dependency-graph-ce
  spec-lint-ce
  start-preamble-ce
  system-zero-ce
)
for module_id in "${BASE_MODULES[@]}"; do
  sz install "$module_id" --force
done
for module_id in "${CE_MODULES[@]}"; do
  repo="avibrahms/sz-module-${module_id}"
  dest=".sz/module-sources/${module_id}"
  if [ ! -d "$dest/.git" ]; then
    rm -rf "$dest"
    if command -v gh >/dev/null 2>&1; then
      gh repo clone "$repo" "$dest" >/dev/null
    else
      git clone --depth 1 "https://github.com/${repo}.git" "$dest" >/dev/null
    fi
  else
    git -C "$dest" fetch --quiet origin main || true
    git -C "$dest" checkout --quiet main || true
    git -C "$dest" pull --quiet --ff-only || true
  fi
  sz install "$module_id" --source "$dest/$module_id" --force
done
sz reconcile
sz tick --reason bootstrap
sz doctor
sz list
