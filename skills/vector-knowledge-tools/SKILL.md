---
name: vector-knowledge-tools
description: >-
  Canonical vector DB / knowledge-graph tooling for code and embeddings:
  RuVector CLI, RVF format, and GitNexus-style knowledge graphs.
---

# Vector Knowledge Tools (Canonical)

**Level: max.** Aliases: `ruvector-cli`, `rvf-cli`, `gitnexus`.

## Procedure

1. Definisikan corpus (repo paths, docs) dan tujuan retrieval.
2. Pilih store: embeddings RuVector/RVF vs graph GitNexus.
3. Index incrementally; jangan commit blob embedding raksasa tanpa kebijakan.
4. Query dengan evaluasi: precision pada 5 pertanyaan emas project.
5. Integrasi agent: expose lewat MCP/CLI; cache hasil bila perlu.

## DoD

- [ ] Index reproducible terdokumentasi
- [ ] 5 golden queries dievaluasi
- [ ] Secrets tidak ikut ter-embed
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
