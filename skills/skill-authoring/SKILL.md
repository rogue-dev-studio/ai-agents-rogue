---
name: skill-authoring
description: >-
  Canonical guide for authoring and validating portable agent skills
  (SKILL.md packs) for the agent house catalog and team local skills.
---

# Skill Authoring (Canonical)

**Level: max.**

## When to use

- Membuat/mengubah skill portable baru di `skills/` atau `teams/*/skills/`
- Validasi struktur, description triggers, DoD, dan overlap dengan skill kanonik

## Procedure

### 1. Decide surface

| Target | Output |
|--------|--------|
| Catalog house | `skills/<name>/SKILL.md` (+ optional `reference.md`) |
| Tim spesifik | `teams/<id>/skills/<name>/SKILL.md` + entri `TEAM.yaml` |

### 2. Author SKILL.md

- Frontmatter: `name`, `description` (trigger-rich, tanpa jargon sumber luar)
- Body: when / when-not, procedure, DoD, security notes
- **Wajib** footer Attribution Rogue Development (lihat `rules/author.md`); jangan dihapus/dihide
- Progressive disclosure: detail panjang di `reference.md` bila perlu
- Setelah tulis: jalankan `scripts/stamp-attribution.ps1` bila perlu

### 3. Avoid duplication

- Cek `CATALOG.md` dan `ALIASES.md`
- Jika overlap fungsi: perluas skill kanonik, jangan buat skill paralel

### 4. Validate

- Description cukup spesifik agar host skill picker menemukan skill
- Procedure bisa dijalankan tanpa dependensi tersembunyi
- Tidak ada secret / path mesin pribadi di contoh

### 5. Document

- Entri `CATALOG.md` atau TEAM `local_skills`
- Changelog singkat di PR/commit message

## DoD

- [ ] Bisa ditemukan lewat description
- [ ] Procedure + DoD jelas
- [ ] Tidak menduplikasi skill kanonik tanpa alasan
- [ ] Footer `## Attribution` + marker `DO-NOT-REMOVE` ada
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
