---
name: api-engineering
description: >-
  Expert API design and delivery: resource modeling, versioning, consistent
  error envelopes, pagination/filtering, idempotency, OpenAPI/contracts, and
  boundary validation. Use when defining or changing REST (or HTTP) APIs,
  DTO/request-response shapes, client integration contracts, or when reviewing
  endpoint consistency before frontend or third-party consumers bind to them.
expertise_level: expert
---

# API Engineering (Canonical)

**Expertise: expert.** Aliases: `api`, `rest-api`, `openapi`, `http-api`.

## When to use

- Desain atau ubah endpoint HTTP/REST
- Kontrak request/response, status code, error body
- Pagination, filtering, sorting, idempotency keys
- Spesifikasi OpenAPI / API docs untuk konsumen FE/integrasi

## When not to use

- Schema DB murni → `database-engineering`
- UI rendering → `frontend-engineering`
- Auth protocol detail → `auth-access-control` (koordinasi wajib)

## Procedure

1. **Contract first** — Identifikasi resource, verb, identitas, dan side-effect.
2. **Consistency** — Samakan envelope sukses/error dengan konvensi project.
3. **Boundary** — Validasi input di edge; tolak early; jangan bocorkan detail internal.
4. **Scale reads** — Pagination wajib untuk koleksi; filter eksplisit; urutan deterministic.
5. **Writes** — Idempotency untuk POST yang bisa di-retry; transaksi di service layer.
6. **Authz** — Setiap endpoint sensitif: default deny (lihat `auth-access-control` + `security`).
7. **Document** — Update kontrak/OpenAPI atau docs project; breaking change = version/migrate plan.
8. **Verify** — Smoke happy-path + 4xx validation + 401/403; catat path artifact.

Detail: `reference.md`.

## DoD

- [ ] Kontrak endpoint jelas (path, method, auth, payload, errors)
- [ ] Pagination/filter pada koleksi besar
- [ ] Tidak ada breaking change diam-diam
- [ ] Validasi + authz di boundary
- [ ] Evidence smoke atau blocker eksplisit

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
