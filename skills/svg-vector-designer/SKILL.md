---
name: svg-vector-designer
description: >-
  Create, optimize, and animate structured SVG/vector graphics for icons, logos,
  and diagrams. Perform clean raster-to-vector tracing, maintain design system
  consistency, and optimize SVG code for production.
---

# SVG & Vector Designer (Canonical)

Alises: `svg`, `vector`, `icon-generator`, `svg-animator`.

## When to use

- Design and optimize SVG icons, logos, or illustrations.
- Animate vectors with CSS/SMIL (e.g., stroke-dashoffset).
- Convert raster bitmaps/sketches to clean SVG paths.
- Build design system icon kits with token variables (`currentColor`).
- Clean up or optimize SVG code (SVGO-like cleanup).
- Generate vector-based charts or technical diagrams.

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk alignment brand/tema.
2. **Setup** — Tentukan grid (mis. 24x24px), struktur path, atau token warna.
3. **Drafting** — Buat/tracings/animasi.
4. **Cleanup** — Hapus metadata sampah, gabung path, optimasi viewBox.
5. **Verify** — Cek visual, a11y (jika interaktif), dan ukuran file.
6. **Deliver** — Simpan di `project/{id}/artifacts/design/` (sebagai `.svg` atau source asal seperti `.ai`/`.svg`).

## When not to use

- Manipulasi foto/raster → `photoshop`
- 3D modeling → `blender`
- Desain UI general / flow (wireframe) → `ui-ux-design`

## DoD

- [ ] Desain selaras tema project (Theme Gate)
- [ ] Path bersih dan viewBox proporsional
- [ ] Kualitas aset produksi (tidak ada artefak/slop)
- [ ] Artifact tersimpan di folder project
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
