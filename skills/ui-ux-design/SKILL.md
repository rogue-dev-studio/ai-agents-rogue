---
name: ui-ux-design
description: >-
  Expert UI/UX design for product interfaces: user flows, information
  architecture, wireframes, interaction patterns, accessibility, and a mandatory
  theme/brand alignment gate against the active project (PROJECT.md, design
  docs, existing tokens/visual language). Use before or alongside frontend work
  when designing screens, reviewing mockups, or validating that proposed UI
  matches the project theme already in progress or about to ship.
expertise_level: expert
---

# UI/UX Design (Canonical)

**Expertise: expert.** Aliases: `ui-ux`, `ux`, `ui-design`, `usability`.

Aligns with role **UI/UX Designer**. Tokens/components ownership: Design System Specialist + skill `canvas-design`. Implementation: `frontend-engineering`. Browser verification: `browser-automation`.

## When to use

- Merancang atau mereview flow, wireframe, mockup, interaction
- Memastikan layar baru selaras tema/brand project aktif
- Menulis UI specification / AC visual sebelum Frontend mengimplementasi
- Review desain terhadap rule `ui`

## When not to use

- Hanya coding komponen tanpa keputusan desain → `frontend-engineering`
- Hanya mendefinisikan token/library design system → `canvas-design` / Design System Specialist
- Mengubah requirement bisnis → Product Owner / BA

## Procedure

1. **Theme gate (wajib dulu)** — Baca sumber tema project aktif:
   - `PROJECT.md` / nama & deskripsi produk
   - `project/{id}/docs/design/` (bila ada)
   - Design system / CSS variables / komponen existing di repo
   - Brand tone (formal/informatif/operasional, dll.) yang sudah dipakai layar lain
   - Jika tema belum terdokumentasi: catat asumsi tertulis singkat, lalu selaraskan ke pola UI yang **sudah ada** di project — jangan mengimpor estetika generik luar.
2. **Compatibility check** — Tolak atau revisi usulan yang bentrok warna, tipografi, radius, density, ikonografi, atau “AI slop” default bila project sudah punya bahasa visual.
3. **IA & flow** — Satu tujuan per layar/section; happy path + empty/loading/error.
4. **Wire → fidelity** — Low-fi lalu hi-fi sesuai kebutuhan; interaksi (focus, modal, navigasi) eksplisit.
5. **A11y** — Kontras, label, target sentuh/fokus keyboard.
6. **Handoff** — Spec ke Frontend + catatan tema (token/komponen yang dipakai); AC UI dapat diuji.
7. **Verify** — Checklist `reference.md`; bila E2E, artifact di `project/{id}/docs/design/`.

## DoD

- [ ] Theme gate lulus: desain selaras tema project aktif/akan dibuat (atau asumsi tertulis + selaras UI existing)
- [ ] Flow + states (empty/loading/error) lengkap untuk lingkup layar
- [ ] A11y dasar terpenuhi
- [ ] Tidak ada pola AI-slop yang bertentangan dengan brand project
- [ ] Spec/handoff siap untuk `frontend-engineering`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
