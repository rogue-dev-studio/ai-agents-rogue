---
name: code-review
description: >-
  Expert code review against architecture and coding standards: readability,
  maintainability, security, performance, layering, Sonar-equivalent cleanliness,
  comment and formatting discipline, modal safety, and a strict ban on raw SQL
  or database queries outside the persistence layer. Author/date file headers are
  identity metadata only and are out of review scope. Use when reviewing pull
  requests, developer diffs, or E2E Review phase outputs; produces approve/reject
  with actionable findings for Tech Lead and engineers.
expertise_level: expert
---

# Code Review (Canonical)

**Expertise: expert.** Aliases: `review`, `code-reviewer`, `pr-review`.

Aligns with role **Code Reviewer** (`roles/quality/reviewer.md`) and hard rule `coding.md`. Complements `agentic-qe` (behavioral QA) and does not replace Security review triggers.

## When to use

- Review diff / PR / hasil implementasi developer
- Fase Review pada `e2e-delivery`
- Gate sebelum merge atau handoff QA

## When not to use

- Menulis fitur baru (kecuali contoh minimal untuk menjelaskan temuan)
- Mengganti requirement atau arsitektur utama → escalate Tech Lead / Architect
- Pengujian fungsional mendalam saja → `agentic-qe`

## Procedure

1. **Scope** — Batasi pada diff + kontrak terkait (API, schema, UI).
2. **Architecture** — Layering, service boundary, no UI→DB.
3. **Coding rule gate** — Jalankan checklist `rules/coding.md` lengkap (lihat `reference.md`).
4. **Query ban** — Tolak raw SQL / query di controller, service sembarangan, view, frontend; akses data hanya ORM/repository–model.
5. **Security & API** — Authz default deny; tidak bocorkan secret/stack; selaras `security` / `api` bila relevan.
6. **Report** — Temuan berprioritas (blocker / major / minor) + rekomendasi; **jangan** mengimplementasi perbaikan sendiri kecuali diminta.
7. **Verdict** — Approve / Request changes / Reject; simpan catatan di `project/{id}/docs/review/` saat E2E.

## DoD

- [ ] Checklist coding.md selesai (termasuk larangan query)
- [ ] Tidak ada major architecture violation tanpa escalate
- [ ] Verdict dan path laporan jelas
- [ ] Developer mendapat rekomendasi yang dapat ditindaklanjuti

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
