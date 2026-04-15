# connection-engine-reference

An open-source, anonymized reconstruction of connection-engine, assembled entirely from [System Zero](https://systemzero.dev) modules.

This repo has no source code of its own. It contains only a pinned System Zero profile and a bootstrap script. The actual behavior comes from public catalog modules fetched through the System Zero protocol.

Run:

```bash
bash bootstrap.sh
```

The bootstrap installs `sz` if needed, points it at the public System Zero catalog, installs the reconstructed modules, runs a tick, and prints the installed module list.
