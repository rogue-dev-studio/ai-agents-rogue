---
name: engineering-technical-interview
description: >-
  General engineering technical interviews: backend, frontend, fullstack, mobile,
  DevOps tracks — live coding, debugging, system design light, take-home briefs,
  rubrics, and candidate practice. Not HR-specific; use for technical interview,
  technical test, mock interview, live coding, system design interview, persiapan
  tes teknis, simulasi interview engineer, take-home review rubric.
expertise_level: expert
---

# Engineering Technical Interview

**Level: expert.** Katalog umum — hiring, internal promo, atau persiapan kandidat. Role opsional: Tech Lead / Code Reviewer. HR pipeline rekrutmen → juga `hr-technical-interview` (pack HR).

## When to use

- Susun atau jalankan technical interview engineer (live / take-home)
- Mock interview dan latihan jawaban untuk kandidat
- Rubrik penilaian 1–5 per dimensi teknis
- Brief take-home + ringkasan review sebelum `code-review`
- Kata kunci: technical interview, live coding, system design, mock interview, tes teknis

## When not to use

- HR behavioral / psikotest → pack HR (`hr-cv-lifecycle`, `hr-psychometric`)
- SIMRS / rumah sakit domain → `simrs-technical-assessment`
- Review PR produksi tanpa konteks assessment → `code-review`
- Vonis hire otomatis

## Procedure

### 1. Context

- Track: backend / frontend / fullstack / mobile / QA automation / DevOps
- Level: junior / mid / senior / lead
- Stack (jika ada)
- Format: live 60–90 mnt / take-home / score submission
- Mode: interviewer | candidate prep | score work

Default: mid backend, live 90 mnt, interviewer mode.

### 2. Session structure (live)

| Blok | Waktu | Isi |
|------|-------|-----|
| Warm-up | 10 mnt | Pengalaman & stack |
| Deep-dive | 25 mnt | API, UI, data, infra sesuai track |
| Coding / debug | 25 mnt | Fungsi kecil atau fix snippet |
| Trade-offs | 15 mnt | Skala, reliability, security |
| Q&A | 10 mnt | |

### 3. Tracks & rubrics

Detail dimensi, soal contoh, take-home: `reference.md`.

Pass contoh (mid): rata-rata dimensi ≥3.5, tidak ada dimensi wajib <2.

### 4. Take-home

Brief: scope terbatas, README, test minimal, tidak over-engineer.

Submission review: hiring-relevant summary → handoff `code-review` untuk detail diff.

### 5. Handoff

| Konteks | Skill |
|---------|--------|
| Rekrutmen + etika HR | `hr-technical-interview` |
| SIMRS / rumah sakit | `simrs-technical-assessment` |
| Review kode submission | `code-review` |
| Domain backend/frontend deep | `backend-engineering`, `frontend-engineering`, `api-engineering` |

## DoD

- [ ] Agenda + soal terikat track/level
- [ ] Rubrik per dimensi + threshold pass
- [ ] Mode interviewer vs candidate prep jelas
- [ ] Rekomendasi = bantuan; keputusan manusia

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
