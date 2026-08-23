---
name: hr-employee-ops
description: >-
  Employee onboarding checklists, policy FAQ from supplied documents,
  leave-request policy checks, coverage notes, and performance-review
  frameworks. Use for onboarding, karyawan baru, cuti, KPI, performance
  review, handbook, code of conduct, people ops.
---

# HR Employee Ops

**Level: expert.** Prompt-routed skill (sumber pack: `teams/hr`). Tidak perlu aktifkan tim. Role opsional: `hr-specialist`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- Checklist onboarding + urutan tugas / dokumen
- FAQ kebijakan **hanya** dari file/handbook yang user berikan
- Cek permintaan cuti vs kebijakan (kuota, notice, jenis cuti)
- Kerangka review kinerja, goal, development plan (bukan nilai final)
- Kata kunci: onboarding, karyawan baru, cuti, KPI, performance review, handbook, people ops

## When not to use

- Mengirim email massal / memakai password email di source tree
- Menjawab kebijakan dari “pengetahuan umum” seolah resmi perusahaan
- Mengganti keputusan legal/HRBP (PHK, pelanggaran berat, gaji)

## Procedure

### 1. Source of truth

Jika tidak ada dokumen kebijakan: jawab dengan **template generik** dan label `DRAFT — bukan kebijakan perusahaan`.

Jika ada dokumen: kutip bagian relevan; jika tidak ketemu → “tidak ada di dokumen”.

### 2. Onboarding

Output:

- Checklist hari 1 / minggu 1 / hari 30 (akses, tools, buddy, training)
- Daftar dokumen (kontrak, NPWP, rekening) tanpa menyimpan nomor asli di repo
- Risiko: akses berlebih, akun bersama, secret di chat

### 3. Leave

- Jenis cuti, syarat, dampak coverage
- Flag konflik kebijakan; **jangan** auto-approve
- Sarankan siapa yang harus approve (manajer / HR)

### 4. Performance

- Goal SMART dari input manajer + karyawan
- Pertanyaan review 360 (opsional)
- Development plan: skill gap + aksi 30/60/90
- Jangan mengarang penilaian orang yang tidak ada datanya

### 5. Privacy

Rule `hr-people-data`. Log/artifact tanpa gaji, NIK, diagnosa, atau isi surat peringatan lengkap.

## DoD

- [ ] Sumber kebijakan eksplisit (dokumen user vs draft generik)
- [ ] Onboarding punya owner per item
- [ ] Cuti: hasil = rekomendasi, bukan approval
- [ ] Tidak ada secret / PII di git

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
