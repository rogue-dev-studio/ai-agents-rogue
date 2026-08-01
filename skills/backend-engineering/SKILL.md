---
name: backend-engineering
description: >-
  Expert backend application engineering: layered architecture, domain services,
  validation, transactions, caching boundaries, background jobs, and framework
  idioms (e.g. Laravel/Node) without leaking business rules into controllers.
  Use when implementing or refactoring server-side features, services, form
  requests/DTOs, policies, queues, or integrating persistence with APIs.
expertise_level: expert
---

# Backend Engineering (Canonical)

**Expertise: expert.** Aliases: `backend`, `server-side`, `laravel-backend` (framework-agnostic patterns; PHP runtime also uses `php`).

## When to use

- Implementasi fitur server: service, policy, job, mail, storage
- Refactor agar controller tipis; business rules di service/domain
- Integrasi DB (`database-engineering`) + API (`api-engineering`)

## When not to use

- Hanya schema/index → `database-engineering`
- Hanya kontrak HTTP tanpa logic → `api-engineering`
- Hanya UI → `frontend-engineering`

## Procedure

1. **Layering** — Controller/handler = transport; Service = use-case; Persistence = repository/ORM.
2. **Validation** — Di boundary (Form Request / DTO / schema); fail fast.
3. **Transactions** — Multi-write atomik di service; transaksi pendek.
4. **Authz** — Policy/gate per aksi; default deny.
5. **Errors** — Domain exception → mapping HTTP konsisten; log dengan correlation id bila ada.
6. **Side-effects** — Queue/job untuk kerja lambat; idempotent consumer.
7. **Performance** — Eager load; hindari N+1; cache dengan invalidation eksplisit.
8. **Verify** — Unit/feature test kritis + smoke API; handoff FE jika kontrak berubah.

Detail: `reference.md`.

## DoD

- [ ] Layering terjaga (no fat controller / no DB dari UI)
- [ ] Validasi + authz + transaksi benar
- [ ] Tidak ada N+1 sadar di path utama
- [ ] Tes/smoke untuk perilaku kritis
- [ ] Kontrak API selaras `api-engineering`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
