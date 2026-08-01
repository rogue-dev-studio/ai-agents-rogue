---
name: database-engineering
description: >-
  Expert database engineering for application data layers: schema and ERD design,
  relational modeling, indexing, query performance gates, views, triggers,
  functions, mapping/junction tables, versioned migrations, seeders, and
  PostgreSQL/MySQL operational practice. Use for Database Engineer delivery,
  migration work, integrity constraints, and measurable read/write performance.
expertise_level: expert
---

# Database Engineering (Canonical)

**Expertise: expert.** Aliases: `database`, `postgresql`, `sql`, `migrations`, `dba`, `schema-design`.

Data-layer playbook for the **Database Engineer** role. It does not replace `supabase-cli` (Supabase runtime) or the global `security` rule (auth/PII policy).

## When to use

- Desain/ubah schema, ERD, **relasi**, constraint, **index**
- Migration / seeder (Laravel `database/migrations`, SQL generik, dll.)
- **Performance**: pagination di DB, anti-N+1, EXPLAIN, index strategy, transaksi pendek
- Objek DB lanjutan: **VIEW**, **TRIGGER**, **FUNCTION** / procedure (bila stack mengizinkan)
- Tabel **mapping / junction / `_mp`** (N:M dan pemetaan referensi)
- Integritas data, unique/FK, cascade, soft-delete vs hard-delete
- PostgreSQL (default Phase 1 house) atau MySQL/MariaDB bila stack project memakai itu
- Review perubahan DB sebelum Backend mengikat API

## When not to use

- Hanya business logic / API contract → Backend / Tech Lead
- Hanya UI list/filter → Frontend
- Operasi container DB saja tanpa schema → `container-docker-ops`
- Edge functions / Supabase CLI spesifik → `supabase-cli`
- Kebijakan auth/secret global tanpa perubahan schema → `security`
- Memindahkan seluruh domain workflow ke trigger tanpa ADR (anti-pattern)

## Procedure

1. **Context** — Baca SRS/architecture data (`docs/architecture/database-design.md` bila ada), `PROJECT.md`, rule `database` + `security` + `coding`.
2. **Model** — Entitas, PK/FK, kardinalitas, normalisasi (3NF; denormalisasi sadar + terdokumentasi). Sertakan mapping/`_mp` untuk N:M.
3. **Relations** — FK di DB; cascade default restrict; pivot/mapping punya unique composite.
4. **Migrate** — Satu concern per migration; **up + down**; incremental; jangan edit migration yang sudah di-apply di shared env.
5. **Index** — FK, filter/join/sort hot path; composite berurutan benar; ukur sebelum index spekulatif.
6. **Performance gate** — Setiap perubahan schema/query: pastikan path baca/tulis utama tetap efisien (index, pagination, transaksi pendek, no full-scan yang bisa dihindari).
7. **Views / functions / triggers** — Hanya jika ada alasan jelas (lihat `reference.md`); versioned di migration; down menghapus objek; dokumentasikan side-effect.
8. **Seed** — Master/reference saja; bukan data transaksi produksi.
9. **Security** — Parameterized / builder / Eloquent; least-privilege; tidak log PII/secret.
10. **Verify** — migrate + rollback smoke; relasi tidak orphan; EXPLAIN untuk query kritis bila diubah; docs di `project/{id}/docs/` saat E2E.
11. **Handoff** — Path migration/seeder/DDL objek, risiko rollback, catatan index & performa.

Detail: `reference.md`.

## Quality bar

- **Performance terjaga**: tidak merusak hot path; index & pagination selaras akses data
- Relasi & mapping eksplisit di DB (bukan hanya di ORM)
- VIEW/FUNCTION/TRIGGER idempotent di migration, terdokumentasi, reversible
- Naming konsisten; tidak ada schema/kolom mati
- Performa + integritas setara prioritas dengan “jalan dulu”
- Selaras rule `coding` (header file **baru** saja)

## DoD

- [ ] Migration apply + rollback smoke OK (atau blocker eksplisit)
- [ ] Relasi, mapping/`_mp`, dan constraint sesuai design; tidak orphan by design
- [ ] Index untuk path query utama ada / terukur
- [ ] Performance gate: tidak ada regresi sadar pada list/join/write utama
- [ ] VIEW/TRIGGER/FUNCTION (jika ada) punya migration up/down + catatan perilaku
- [ ] Seeder (jika ada) hanya master/reference
- [ ] Keamanan data layer dicek
- [ ] Handoff Backend lengkap (path + risiko)

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
