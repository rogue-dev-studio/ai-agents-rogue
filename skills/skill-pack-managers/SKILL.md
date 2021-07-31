---
name: skill-pack-managers
description: >-
  Canonical skill/pack marketplace management: install, update, and audit
  agent skills across hosts (OpenSkills, agent-skills-cli, Claude marketplace).
---

# Skill Pack Managers (Canonical)

**Level: max.** Aliases: `openskills`, `agent-skills-cli`, `claude-marketplace`.

## Procedure

1. Inventaris skills terpasang vs `TEAM.yaml` (jangan install katalog penuh ke tim sempit).
2. Install hanya yang di allowlist tim / diminta user.
3. Pin versi bila tool mendukung; catat sumber (GitHub/marketplace).
4. Audit: hapus skill orphan; cek duplikat vs `ALIASES.md`.
5. Jangan install skill yang mengeksekusi remote script tanpa review.

## DoD

- [ ] Terpasang = allowlist
- [ ] Sumber tercatat di notes project/tim
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
