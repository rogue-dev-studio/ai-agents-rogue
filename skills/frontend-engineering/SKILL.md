---
name: frontend-engineering
description: >-
  Expert frontend application engineering: accessible UI structure, state and
  data-fetching discipline, form/validation UX, responsive layouts, performance
  budgets, and integration with API contracts. Use when building or refining
  SPA/web screens, design-system consumption, client-side routing, or fixing
  UI reliability (loading, empty, and error states).
expertise_level: expert
---

# Frontend Engineering (Canonical)

**Expertise: expert.** Aliases: `frontend`, `spa`, `react-ui` (framework-agnostic patterns; runtime tooling via `nodejs` / `nodejs-devtools`).

## When to use

- Halaman/komponen, routing, state, form, tabel, modal
- Integrasi API (loading/empty/error), pagination UI
- Accessibility dasar + performa render

## When not to use

- Desain flow/mockup/theme gate → `ui-ux-design`
- Hanya token/brand system murni → `canvas-design` / Design System role
- Hanya kontrak API → `api-engineering`
- Browser E2E automation → `browser-automation`

## Procedure

1. **Theme lock** — Pastikan implementasi mengikuti tema project aktif (hasil gate `ui-ux-design` / UI existing); jangan mengganti arah visual diam-diam.
2. **One job per view** — Satu tujuan jelas; hormati design system / UI rule project.
2. **States** — Loading, empty, error, success selalu ditangani.
3. **Data** — Fetch sesuai kontrak; jangan asumsikan shape array jika envelope `items/meta`.
4. **A11y** — Label, fokus keyboard, kontras; modal trap fokus & restore.
5. **Performance** — Hindari re-render berat; list besar paginated; lazy route/assets bila perlu.
6. **Security** — Jangan simpan secret di bundle; sanitize URL/HTML berbahaya.
7. **Verify** — Manual atau `browser-automation`; responsive smoke.

Detail: `reference.md`.

## DoD

- [ ] States lengkap; a11y dasar OK
- [ ] Selaras kontrak API + pagination
- [ ] Modal tidak merusak layout/performa
- [ ] Tidak ada dead UI / handler kosong
- [ ] Evidence smoke atau blocker

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
