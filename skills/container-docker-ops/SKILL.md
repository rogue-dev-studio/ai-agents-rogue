---
name: container-docker-ops
description: >-
  Canonical container workflows: Docker/Compose development plus MCP-style
  container management patterns.
---

# Container Docker Ops (Canonical)

**Level: max.** Aliases: `docker`.

## Procedure

1. Prefer Compose untuk local multi-service; satu network/project name jelas.
2. Secrets via env files yang di-gitignore / secret store.
3. Healthcheck + logs; jangan `latest` diam-diam di prod-like.
4. Migrasi/volume: backup sebelum reset volume.
5. MCP manager hanya untuk operasi yang tidak bisa lewat Compose files.

## DoD

- [ ] `up` sehat untuk services P0
- [ ] Tidak ada secret di image/git
- [ ] Perintah reproduksi tertulis di docs/notes
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
