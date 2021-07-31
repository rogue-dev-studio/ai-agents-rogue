---
name: clarity
description: >-
  Canonical spec and requirements skill: 5-phase clarity workflow plus
  Spec-Kit / markdown-agent spec patterns. Use for PRD, SRS, AC, and
  implementable specifications before coding.
---

# Clarity — Spec and Requirements (Canonical)

**Level: max.** Aliases: `spec-kit`, `mdflow` (untuk jalur spec/agent-from-markdown).

## When to use

- Brief kabur → spec / SRS / AC
- Sebelum Development di `e2e-delivery`
- User minta Spec-Kit / markdown executable agents untuk requirement

## When not to use

- Tanya singkat tanpa deliverable
- Spec sudah approved dan hanya bugfix kecil

## 5-phase workflow (wajib)

### 1. Ingest

Sumber: brief, issue, mockup, repo notes, regulasi domain bila relevan.  
Output: daftar sumber + ringkasan bullet.

### 2. Clarify

Tanya **hanya** blocker. Sisanya → asumsi tertulis.

### 3. Structure

Wajib section:

1. Problem & goal  
2. Actors  
3. In/out scope  
4. FR + NFR  
5. AC (Given/When/Then bila cocok)  
6. Open questions  
7. Risks / assumptions  

Tulis ke `project/{id}/docs/srs/`.

### 4. Validate

- [ ] Setiap FR P0 punya AC  
- [ ] Tidak kontradiktif  
- [ ] Out-of-scope eksplisit  
- [ ] Data sensitif disebut di NFR bila relevan  

### 5. Handoff

- Siap planning/architecture?  
- Skill berikutnya: `agentic-flow` / roles Architect  

## Spec-Kit / mdflow bridge

- Kalau repo memakai Spec-Kit: hasil Clarity harus kompatibel dengan artefak spec kit project
- Markdown agents: satu file = satu tanggung jawab; jangan menyembunyikan requirement di prosa tanpa ID FR

## DoD

- [ ] File SRS/spec di path project  
- [ ] AC P0 lengkap  
- [ ] Asumsi & pertanyaan terbuka tercatat
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
