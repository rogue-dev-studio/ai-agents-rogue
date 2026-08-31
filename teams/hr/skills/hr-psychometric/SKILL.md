---
name: hr-psychometric
description: >-
  Design and interpret workplace psychometric assessments for hiring: cognitive
  aptitude, work-style, integrity, collaboration, and stress scenarios. Generate
  rubrics, score sheets, and hiring recommendations for engineers and other roles.
  Use for psikotest, psychometric, aptitude test, personality assessment, DISC-like,
  cognitive test, integrity test, kandidat baru, screening perilaku.
---

# HR Psychometric Assessment

**Level: expert.** Prompt-routed skill (sumber pack: `teams/hr`). Tidak perlu aktifkan tim. Role opsional: `talent-recruiter` / `hr-specialist`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- User minta **buat soal psikotest** untuk kandidat (terutama engineer/programmer)
- **Rubrik penilaian** psikometri + lembar skor pewawancara
- **Interpretasi hasil** tes yang sudah diisi kandidat (bukan diagnosis klinis)
- Paket assessment: kognitif + gaya kerja + integritas + kolaborasi
- Kata kunci: psikotest, psychometric, aptitude, DISC, cognitive test, integrity test, work style

## When not to use

- Diagnosis klinis, gangguan mental, atau keputusan medis
- Mengklaim sebagai tes berlisensi resmi (PAPI, IST, MBTI® resmi, dll.) tanpa vendor berlisensi
- Auto-hire / auto-reject hanya dari skor AI
- Tes yang meminta data SARA, kesehatan reproduksi, atau agama sebagai skor
- Psikotest untuk PHK, sanksi, atau promosi tanpa kebijakan HR resmi

## Procedure

### 1. Scope & role context

Kumpulkan:

- Role target (frontend / backend / fullstack / mobile / QA / DevOps)
- Level (junior / mid / senior / lead)
- Kompetensi perilaku yang dicari (mis. ownership, komunikasi, ketelitian)
- Durasi tes (30 / 60 / 90 menit)
- Bahasa (ID / EN)

Jika tidak ada: asumsikan **mid engineer**, 60 menit, bahasa Indonesia.

### 2. Privacy & ethics gate

Ikuti rule `hr-people-data`:

- Jangan simpan nama lengkap + jawaban mentah ke git tanpa redaksi
- Jangan skor berdasarkan usia, gender, agama, disabilitas, status keluarga
- Label output: **bantuan rekrutmen**, bukan diagnosis psikologis
- Rekomendasi akhir: manusia (HR + hiring manager)

### 3. Pilih modul assessment

| Modul | Tujuan | Durasi tipikal |
|-------|--------|----------------|
| **A. Kognitif** | Logika, pola, numerik dasar | 20–30 mnt |
| **B. Gaya kerja** | Preferensi kolaborasi, detail vs big-picture | 15–20 mnt |
| **C. Integritas & etika** | Skenario kejujuran, deadline, konflik | 15 mnt |
| **D. Kolaborasi & komunikasi** | Situasi tim, feedback, stakeholder | 15 mnt |
| **E. Tekanan & adaptasi** | Prioritas, insiden produksi, perubahan scope | 10–15 mnt |

Untuk engineer: default **A + B + C** (junior), tambah **D** (mid+), tambah **E** (senior/lead).

Detail soal & rubrik: lihat `reference.md`.

### 4. Generate deliverable

Output minimal:

1. **Instruksi kandidat** (waktu, aturan, tidak ada jawaban benar tunggal untuk modul perilaku)
2. **Bank soal** per modul (dengan kunci/rubrik untuk pewawancara)
3. **Lembar skor** (1–5 per dimensi + catatan bukti)
4. **Interpretasi** (kekuatan, risiko, pertanyaan lanjutan wawancara)
5. **Rekomendasi** `advance` / `clarify` / `reject-for-this-role` + alasan audit

Simpan ke chat atau `project/{id}/artifacts/other/` jika project aktif.

### 5. Interpretasi hasil (mode review)

Jika user memberi jawaban kandidat:

- Pisahkan **fakta jawaban** vs **inferensi**
- Skor per dimensi dengan kutipan jawaban sebagai bukti
- Flag inkonsistensi atau jawaban evasif
- Saran 3 pertanyaan klarifikasi di wawancara HR/teknis
- Jangan satu angka “IQ” atau label patologis

### 6. Handoff

- Screening CV → skill `hr-cv-lifecycle`
- Technical interview → skill `hr-technical-interview` (+ `code-review` untuk submission); paket contoh: `examples/engineer-recruitment-pack.md`
- Onboarding setelah hire → skill `hr-employee-ops`

## DoD

- [ ] Disclaimer etis & non-klinis ada di output
- [ ] Rubrik terikat role/level, bukan generik kosong
- [ ] Skor per dimensi + alasan, bukan satu angka hire/no-hire
- [ ] Tidak ada PII kandidat di artifact git
- [ ] Rekomendasi = bantuan; keputusan final manusia

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
