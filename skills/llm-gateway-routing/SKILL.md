---
name: llm-gateway-routing
description: >-
  Canonical LLM gateway/routing/proxy playbook: multi-provider failover,
  token reduction proxies, and cost wrappers.
---

# LLM Gateway Routing (Canonical)

**Level: max.** Aliases: `claude-code-mux`, `rtk`, `zai-service`, `claudish` (routing/proxy aspect).

## Procedure

1. Catat provider yang diizinkan + budget.
2. Satu gateway entrypoint per environment.
3. Failover policy: primary → secondary; jangan loop tak terbatas.
4. Token/cost controls (`rtk` / wrapper) dengan logging tanpa PII.
5. Jangan hardcode API keys; rotasi terdokumentasi.

## DoD

- [ ] Entry URL/env terdokumentasi
- [ ] Failover diuji
- [ ] Tidak ada key di git
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
