---
name: simrs-hospital-ops
description: >-
  SIMRS and hospital operations domain: patient journeys, clinical roles
  (dokter, spesialis, DPJP, perawat, bidan, farmasi, lab, radiologi, gizi, RM,
  kasir, pendaftaran), module map, ruangan/workspace, order-result-meds-billing
  chains. Use for SIMRS, rumah sakit, rekam medis, rawat jalan, rawat inap,
  IGD, BPJS, poli, resep, when designing or explaining hospital workflows.
---

# SIMRS Hospital Ops

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Tidak perlu aktifkan tim. Role opsional: `simrs-domain-specialist`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- Menjelaskan atau merancang alur pelayanan rumah sakit di SIMRS
- Menulis AC berbasis **peran** (bukan user generik)
- Memetakan modul (pendaftaran, rajal, IGD, ranap, lab, rad, farmasi, kasir, RM, …)
- Menjawab “siapa boleh melakukan apa” di konteks RS Indonesia
- Bekal sebelum `simrs-clinical-review`

## When not to use

- Diagnosis atau terapi pasien nyata
- Klaim hukum (malpraktik, izin praktik) seolah counsel
- Review kode murni tanpa alur klinis → `code-review`
- Handle PII saja tanpa alur → `simrs-patient-data` + rule `patient-health-data`

## Procedure

### 1. Identifikasi episode

Tentukan: jenis pelayanan (rajal / IGD / ranap / penunjang murni), status pasien (baru/lama), penjamin (umum / BPJS / asuransi), dan ruangan/poli aktif.

Tanpa nomor **RM** + **kunjungan** (atau setara), alur dianggap belum tertambat.

### 2. Petakan peran

Pakai tabel peran di `reference.md`. Setiap aksi UI/API harus punya pelaku: dokter umum, dokter spesialis, DPJP, konsulen, perawat, bidan, apoteker, analis, radiografer, ahli gizi, petugas pendaftaran, kasir, RM, sysadmin.

### 3. Ikuti rantai data

Urutan kanonik (boleh paralel di penunjang, tidak boleh loncat identitas):

```text
Identitas (RM) → Kunjungan / registrasi → Workspace ruangan
  → Pelayanan (dokter/perawat)
  → Order penunjang (lab/rad/gizi/fisio) → Hasil → dibaca klinisi
  → Resep → verifikasi farmasi → dispensing / stok
  → Tindakan / kamar / OK (jika ada)
  → Resume / pulang → Billing / klaim → Berkas RM
```

### 4. Tulis AC

Format wajib per cerita:

- **Pelaku** (peran + ruangan)
- **Prasyarat** (pasien terdaftar, kunjungan terbuka, hak akses)
- **Aksi**
- **Dampak data** (status kunjungan, order, stok, tagihan)
- **Yang tidak boleh** (peran lain)

### 5. Flag risiko

Lihat `reference.md` § risiko khas: order yatim, pulang tanpa billing, resep tanpa kunjungan, bridging SEP tidak selaras, RBAC longgar.

## DoD

- [ ] Modul dan peran disebut
- [ ] Rantai RM → kunjungan → ruangan tidak putus
- [ ] AC membedakan dokter vs perawat vs administrasi
- [ ] PHI tidak tertulis di artifact

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
