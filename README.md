# connection-engine-reference

An open-source, anonymized reconstruction of connection-engine, assembled entirely from [System Zero](https://systemzero.dev) modules.

This repo has no source code of its own. It has:
- A pre-seeded `.sz/repo-profile.json` that names the reconstructed modules.
- A `.sz.yaml` that pins them.
- A one-line `bootstrap.sh` that installs `sz`, installs the pinned modules, and runs a smoke check.

Run:

    bash bootstrap.sh

The bootstrap installs the public System Zero base modules and then fetches the generated `sz-module-*-ce` mirrors for the reconstructed modules. During this run those mirrors may be private; authenticated GitHub CLI access is enough to clone them.
