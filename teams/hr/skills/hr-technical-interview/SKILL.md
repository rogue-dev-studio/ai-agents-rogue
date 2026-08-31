---
name: hr-technical-interview
description: >-
  Design and run technical interviews for hiring: backend, frontend, fullstack,
  live coding, system design light, take-home rubrics, and candidate prep.
  Score sheets and practice Q&A for recruiters and candidates. Use for technical
  interview, technical test, live coding, take-home assignment, wawancara teknis,
  tes coding, backend interview, frontend interview, simulasi interview engineer.
---

# HR Technical Interview

**Level: expert.** Prompt-routed skill (sumber pack: `teams/hr`). Role opsional: `technical-interviewer` / `talent-recruiter` / Tech Lead. Tidak perlu aktifkan tim.

## When to use

Langsung dari prompt user:

- **Pewawancara / Tech Lead:** susun sesi technical interview, soal, rubrik 1–5, lembar skor
- **Kandidat:** persiapan technical test, latihan jawaban, mock interview, take-home planning
- **Review:** nilai hasil live coding atau take-home (ringkas; detail kode → `code-review`)
- Kata kunci: technical interview, technical test, live coding, take-home, wawancara teknis, tes coding

## When not to use

- HR behavioral / culture fit saja → `hr-cv-lifecycle` atau `hr-psychometric`
- Diagnosis klinis atau psikotest → `hr-psychometric`
- Vonis hire/no-hire otomatis dari AI
- Review PR produksi mendalam tanpa konteks rekrutmen → `code-review`

## Procedure

### 1. Context

Kumpulkan:

- Role track: backend / frontend / fullstack / mobile / QA / DevOps
- Level: junior / mid / senior / lead
- Stack target (PHP/Laravel, Node, React, dll.)
- Format: live (60–90 mnt) / take-home (2–4 jam efektif) / hybrid
- Mode: **interviewer** | **candidate prep** | **score submitted work**
- Bahasa (ID / EN)

Default: **mid backend**, live 90 mnt, bahasa Indonesia, mode interviewer.

### 2. Ethics & privacy

Ikuti rule `hr-people-data`:

- Jangan simpan nama kandidat + jawaban mentah ke git tanpa redaksi
- Jangan skor berdasarkan atribut dilindungi
- Label: bantuan rekrutmen; keputusan final manusia (HR + hiring manager + Tech Lead)

### 3. Pilih format

| Format | Durasi | Output utama |
|--------|--------|----------------|
| **Live technical** | 60–90 mnt | Agenda blok + soal + rubrik dimensi |
| **Live coding** | 20–30 mnt dalam sesi | Soal kecil + kriteria lulus |
| **Take-home** | 3–4 jam efektif | Brief kandidat + rubrik review |
| **Candidate prep** | — | Topik, jawaban contoh, pertanyaan balik |

Detail soal per track: `reference.md`. Paket lengkap: `examples/engineer-recruitment-pack.md`.

### 4. Struktur sesi live (default)

| Blok | Waktu | Isi |
|------|-------|-----|
| Warm-up | 10 mnt | Pengalaman & stack |
| Domain deep-dive | 25 mnt | API / UI / data sesuai track |
| Coding / debugging | 25 mnt | Fungsi kecil atau fix bug snippet |
| System / trade-off | 15 mnt | Skala, error, security awareness |
| Q&A | 10 mnt | Kandidat tanya balik |

### 5. Rubrik (1–5)

Skor per **dimensi**, bukan satu angka tunggal. Dimensi wajib track ada di `reference.md`.

Pass contoh (mid): rata-rata ≥3.5, tidak ada dimensi wajib di bawah 2.

Rekomendasi: `advance` / `clarify` / `reject-for-this-role` + alasan audit.

### 6. Mode candidate prep

- 5–8 pertanyaan teknis terikat JD + stack
- Jawaban singkat (bullet + contoh dari CV user jika diberi)
- 3 pertanyaan balik ke interviewer
- Catatan jujur untuk gap stack (mis. Yii vs Laravel)

### 7. Take-home & code review handoff

Brief take-home: scope, batas waktu, README wajib, tidak over-engineer.

Review submission:

1. Ringkas temuan hiring-relevant (struktur, test, security dasar, README)
2. Handoff detail ke skill `code-review` untuk diff-level review

### 8. Handoff

- CV screening → `hr-cv-lifecycle`
- Psikotest → `hr-psychometric`
- Engineering umum (non-HR pipeline) → skill katalog `engineering-technical-interview`
- Onboarding setelah hire → `hr-employee-ops`

## DoD

- [ ] Agenda + soal terikat role/level/stack
- [ ] Rubrik per dimensi + threshold pass contoh
- [ ] Mode interviewer vs candidate prep jelas
- [ ] Tidak ada PII kandidat di artifact git
- [ ] Rekomendasi = bantuan; keputusan final manusia

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
