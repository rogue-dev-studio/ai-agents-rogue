---
name: hr-cv-lifecycle
description: >-
  Write, rewrite, and review CVs/résumés; screen candidates against a job
  description; summarize interview notes; generate interview questions.
  Use for CV, résumé, screening, ATS, talent, recruiter, kandidat, lamaran.
---

# HR CV Lifecycle

**Level: expert.** Prompt-routed skill (sumber pack: `teams/hr`). Tidak perlu aktifkan tim. Role opsional: `talent-recruiter` / `hr-specialist`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- User minta **buat / perbaiki CV** (diri sendiri atau dari bahan yang diberi)
- **Review CV** vs job description / role
- Ringkas catatan wawancara atau bullet kandidat
- Buat pertanyaan wawancara dari JD + profil
- Kata kunci: CV, résumé, screening, ATS, talent, recruiter, kandidat, lamaran

## When not to use

- Background check ilegal, doxxing, atau scraping data orang tanpa izin
- Memalsukan riwayat kerja, gelar, atau sertifikat
- Keputusan hiring otomatis tanpa reviewer manusia (skor AI = bantuan, bukan vonis)

## Procedure

### 1. Ingest

Kumpulkan: target role/JD, bahan mentah (CV lama, catatan, LinkedIn text), locale (ID/EN), panjang target.

Jika JD tidak ada: tulis **asumsi role** 3–5 bullet, lanjut.

### 2. Privacy gate

Ikuti rule `hr-people-data`. Jangan tulis NIK, rekening, alamat lengkap, atau data kesehatan ke artifact git. Redaksi di output jika user menempel PII berlebih.

### 3. Mode

| Mode | Output |
|------|--------|
| **Write** | CV terstruktur (lihat `reference.md`) dari fakta user saja |
| **Review** | Temuan: kejelasan, bukti, gap JD, ATS, bias, klaim lemah |
| **Screen** | Matriks skill wajib/nice-to-have + skor 1–5 + alasan + risiko |
| **Notes** | Ringkasan catatan pewawancara → kekuatan, risiko, pertanyaan lanjutan |

### 4. Evidence vs claim

Setiap bullet kuat harus punya **bukti** (metrik, scope, stack, outcome). Tandai `UNVERIFIED` jika user tidak memberi bukti.

### 5. Bias check

Jangan skor berdasarkan usia, gender, foto, agama, status pernikahan, atau nama. Flag jika CV memuat data yang tidak relevan untuk role.

### 6. Deliver

- Markdown di chat atau `project/{id}/artifacts/other/` jika project aktif
- File `.docx`/PDF hanya jika user minta → skill `office-document-tools`
- Review: daftar P0 (blokir) vs P1 (perbaiki)

## DoD

- [ ] Fakta tidak ditambah di luar input user
- [ ] Review punya temuan konkret + saran rewrite (bukan “bagus saja”)
- [ ] Screening memisahkan must-have vs nice-to-have
- [ ] PII berlebih tidak disimpan ke repo

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
