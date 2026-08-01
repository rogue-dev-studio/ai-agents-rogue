---
name: observability-engineering
description: >-
  Expert application observability: structured logging, correlation IDs, health
  checks, metrics/SLIs, error tracking, and safe diagnostics without leaking
  secrets or excess PII. Use when adding logging/monitoring for services,
  diagnosing production-like failures, defining health/readiness endpoints, or
  improving operational visibility in Phase 2+ quality work.
expertise_level: expert
---

# Observability Engineering (Canonical)

**Expertise: expert.** Aliases: `observability`, `logging`, `metrics`, `tracing`, `healthchecks`.

This skill covers **application observability**. It does not replace `monitoring` (assistant/CLI usage metering).

## When to use

- Structured log, request id, audit trail teknis
- Health/readiness/liveness endpoints
- Metrics dasar (latency, error rate) atau integrasi error tracker
- Diagnosis kegagalan lokal/compose mendekati Phase 2

## When not to use

- Tracking usage Claude/CLI → `monitoring`
- Hanya UI empty-state → `frontend-engineering`
- Infra cluster penuh → `infra-tools` / `cloud-tools`

## Procedure

1. **Signals** — Tentukan log/metric/trace yang menjawab “apa rusak?”.
2. **Structure** — Log JSON/key-value konsisten; level benar (info/warn/error).
3. **Correlation** — Request/correlation id across API → job bila ada.
4. **Safety** — Redact token, password, PII berlebih (selaras `security`).
5. **Health** — Dependensi kritis (DB) dicek; bedakan liveness vs readiness bila ada.
6. **Noise** — Hindari log per-row di hot path; sample atau aggregate.
7. **Verify** — Reproduksi error terlihat di log dengan id; runbook singkat di docs bila E2E.

Detail: `reference.md`.

## DoD

- [ ] Log terstruktur pada path error utama
- [ ] Tidak ada secret/PII berlebih di log
- [ ] Healthcheck bermakna untuk dependensi P0
- [ ] Cara membaca sinyal tertulis singkat (docs/handoff)

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
