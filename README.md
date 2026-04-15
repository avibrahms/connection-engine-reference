# connection-engine-reference

An open-source, anonymized reconstruction of connection-engine, assembled entirely from [System Zero](https://systemzero.dev) modules.

This repo is the safe public reference stack. It contains a pinned System Zero profile and a bootstrap script; the behavior comes from public catalog modules fetched through the System Zero protocol.

The private, real working engine remains separate. On Avi's machine it is available from:

```text
/Users/avi/Documents/Projects/connection-engine
```

That path points at the private engine with real state, products, profiles, outbox, and credentials. Do not push that private engine to a public repository.

Run:

```bash
bash bootstrap.sh
```

The bootstrap installs `sz` if needed, points it at the public System Zero catalog, installs the reconstructed modules, runs a tick, and prints the installed module list.

## How It Works

1. `bootstrap.sh` installs or reuses the `sz` CLI.
2. `sz init --host generic --no-genesis --yes --force` creates the local `.sz/` runtime.
3. `.sz/repo-profile.seed.json` is copied into `.sz/repo-profile.json` so the stack has a deterministic purpose and module plan.
4. The module list in `bootstrap.sh` installs the reconstructed modules from the public System Zero catalog.
5. `sz reconcile` wires module capabilities through the registry.
6. `sz tick --reason bootstrap` runs one full pulse.
7. `sz doctor` and `sz list` verify that every module is healthy.

The expected result is 20 installed healthy modules, including `heartbeat`, `immune`, `subconscious`, and the reconstructed `*-ce` organs such as `context-assembler-ce`, `sentinel-ce`, `skill-library-ce`, and `system-zero-ce`.

## Verified Locally

This stack was bootstrapped successfully on 2026-04-15 with the local public System Zero catalog:

```bash
SZ_CATALOG=file:///Users/avi/Documents/Projects/system-zero/catalog/index.json bash bootstrap.sh
```

Result: `Reconciled 20 modules, 1 bindings, 0 unsatisfied`, then all 20 modules reported `healthy`.
