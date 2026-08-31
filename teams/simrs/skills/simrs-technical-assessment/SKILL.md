---
name: simrs-technical-assessment
description: >-
  Technical assessment for SIMRS and hospital software roles: clinical workflows,
  API design for visits and orders, PHI handling, RBAC, BPJS integration scenarios,
  regulatory awareness, live coding, and take-home rubrics. Use for SIMRS technical
  interview, technical test rumah sakit, assessment developer SIMRS, wawancara
  teknis klinis, tes coding SIMRS, review kandidat IT rumah sakit.
---

# SIMRS Technical Assessment

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Role opsional: `simrs-technical-assessor` / `simrs-domain-specialist` / Tech Lead. Tidak perlu aktifkan tim.

## When to use

Langsung dari prompt user:

- **Pewawancara:** sesi technical assessment developer/analyst SIMRS, soal domain + teknis, rubrik
- **Kandidat:** persiapan technical test untuk posisi IT rumah sakit / SIMRS vendor
- **Review:** take-home modul SIMRS (ringkas; detail kode → `code-review`)
- Kata kunci: SIMRS technical interview, assessment IT RS, wawancara teknis klinis, tes developer SIMRS

## When not to use

- Review regulasi hukum final → `simrs-regulatory-id` (bukan vonis hukum)
- Mapping elemen data saja → `simrs-data-mapping`
- Review alur klinis tanpa konteks assessment → `simrs-clinical-review`
- HR behavioral rekrutmen umum → `hr-cv-lifecycle` / `hr-technical-interview`

## Procedure

### 1. Context

Kumpulkan:

- Role: backend SIMRS / frontend SIMRS / fullstack / integrasi / QA klinis
- Level: junior / mid / senior
- Modul fokus: pendaftaran, poli, IGD, ranap, farmasi, kasir, penunjang, RM
- Integrasi: BPJS, SATUSEHAT, bridging (jika relevan JD)
- Format: live / take-home / score submission
- Mode: interviewer | candidate prep | score work
- Bahasa (ID / EN)

Default: **mid backend SIMRS**, live 90 mnt, modul poli + rawat inap, bahasa Indonesia.

### 2. Safety & compliance gate

Ikuti rules `simrs-patient-health-data`, `simrs-hospital-regulatory-id`:

- Jangan simpan PHI/NIK/rekam medis nyata di artifact git
- Jangan vonis “legal compliance” — tandai gap vs floor regulasi
- RBAC dan audit trail wajib di rubrik security
- Keputusan hire = manusia

### 3. Dimensi assessment

| Dimensi | Fokus |
|---------|--------|
| **Alur klinis** | Kunjungan, order, identitas pasien konsisten |
| **Data model** | RM, kunjungan, ruangan, order, billing |
| **API & integrasi** | REST, idempotency, error envelope, bridging |
| **PHI & security** | Minimasi data, authz peran klinis, log tanpa PII berlebih |
| **Regulatory awareness** | Consent, retensi RM, PDP — bukan legal advice |
| **Code / debugging** | Service kecil terikat domain RS |

Detail soal: `reference.md`.

### 4. Struktur sesi live (90 mnt)

| Blok | Waktu | Isi |
|------|-------|-----|
| Warm-up | 10 mnt | Pengalaman SIMRS / sistem institusi |
| Alur & data | 25 mnt | Journey pasien → modul → tabel kunci |
| API / integrasi | 20 mnt | Endpoint kunjungan/order atau bridging |
| Coding / debugging | 25 mnt | Logic klinis kecil (status order, validasi) |
| Q&A | 10 mnt | |

### 5. Rubrik (1–5)

Skor per dimensi. Pass contoh (mid): rata-rata ≥3.5, tidak ada dimensi wajib di bawah 2, **PHI/security tidak di bawah 3**.

Rekomendasi: `advance` / `clarify` / `reject-for-this-role`.

### 6. Take-home (opsional)

Contoh: mini API registrasi kunjungan + RBAC peran (resepsionis vs dokter), README, test dasar, tanpa data pasien nyata.

Review submission → ringkas hiring-relevant, handoff `code-review` untuk detail.

### 7. Handoff

- Domain alur RS → `simrs-hospital-ops`
- Review aplikasi → `simrs-clinical-review`
- Regulasi → `simrs-regulatory-id`
- Mapping data → `simrs-data-mapping`
- PHI → `simrs-patient-data`
- Rekrutmen engineer umum → `hr-technical-interview` atau `engineering-technical-interview`

## DoD

- [ ] Soal terikat modul RS + peran klinis
- [ ] Rubrik PHI/security eksplisit
- [ ] Tidak ada PHI nyata di output git
- [ ] Gap regulasi dilabel, bukan vonis hukum
- [ ] Keputusan final manusia

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
