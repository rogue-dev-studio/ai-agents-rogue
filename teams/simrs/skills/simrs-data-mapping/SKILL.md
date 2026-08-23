---
name: simrs-data-mapping
description: >-
  Map Indonesian hospital regulatory and policy data elements to SIMRS
  application artifacts: business entity, table/column, API, UI, PDP class,
  RBAC, and audit. Use for data mapping, kamus data, field mapping, schema
  vs Permenkes rekam medis, UU PDP, informed consent, SEP, STR/SIP, SATUSEHAT,
  or when aligning RHS models to hospital rules.
---

# SIMRS Data Mapping

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Tidak perlu aktifkan tim. Role opsional: `simrs-domain-specialist`, `simrs-clinical-reviewer`.

Melengkapi `simrs-regulatory-id` (kewajiban) dan `simrs-hospital-ops` (alur) dengan **peta elemen data → aplikasi**.

## When to use

Langsung dari prompt user (tanpa setup tim):

- User minta mapping data regulasi/SPO ke tabel, API, atau layar
- Desain/ubah schema, DTO, form klinis, bridging
- Review: “field ini wajib menurut Permenkes — di app ada di mana?”
- Project RHS / SIMRS sejenis (nama tabel bisa beda — verifikasi di kode)

## When not to use

- Hanya review alur klik tanpa data → `simrs-clinical-review`
- Hanya daftar pasal tanpa field → `simrs-regulatory-id`
- Mengarang kolom yang tidak ada di codebase

## Procedure

### 1. Kunci identitas episode

Setiap baris mapping harus bisa menambat ke: **pasien (RM)** + **kunjungan** + **ruangan** (jika pelayanan). Tanpa itu = gap rantai.

### 2. Isi matriks (wajib)

Untuk tiap elemen (lihat `reference.md`):

| Kolom | Isi |
|-------|-----|
| Elemen | nama bisnis (NIK, SOAP, SEP, consent, …) |
| Instrumen | UU/Permenkes/SPO atau `ASUMSI` |
| Entitas | konsep SIMRS |
| App | `schema.table.column` atau path model (setelah grep codebase) |
| API / UI | endpoint atau layar |
| PDP | umum / spesifik / bukan data pribadi |
| RBAC | peran baca vs tulis |
| Jejak | created/modified/audit ada atau tidak |
| Status | `MAPPED` / `PARTIAL` / `GAP` / `VERIFY` |

Jangan isi App dari ingatan saja: **cari di model/migrasi project aktif**. `reference.md` = peta awal RHS, bukan jaminan kolom masih ada.

### 3. Klasifikasi PDP

- Spesifik: diagnosa, hasil lab/rad, resep, SOAP/CPPT, genetik, foto klinis
- Umum identifikasi: nama, NIK, alamat, telepon (tetap PII; minimasi log)
- Operasional non-pasien: tarif master, nama ruangan

### 4. Gap

`GAP` = kewajiban butuh data, app tidak punya tempat simpan/tampil/kendali.  
`PARTIAL` = ada field tetapi tanpa jejak, tanpa RBAC, atau tidak terikat kunjungan.  
Tulis dampak operasional + `REG-*` jika relevan. Bukan “tidak sah secara hukum”.

### 5. Deliver

- Tabel mapping di chat atau `project/{id}/docs/architecture/` (E2E)
- Tanpa nilai PHI nyata; contoh pakai fiktif

## DoD

- [ ] Setiap elemen punya status MAPPED/PARTIAL/GAP/VERIFY
- [ ] Path app dikonfirmasi di kode atau ditandai VERIFY
- [ ] RM + kunjungan disebut untuk data klinis
- [ ] Tidak ada NIK/diagnosa nyata di artifact

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
