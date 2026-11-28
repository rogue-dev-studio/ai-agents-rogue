---
name: brand-kit
description: >-
  Build and maintain a visual identity system: SVG logos, wordmarks, color
  palettes, typography specs, gated variants, and application guidelines for
  production-ready brand assets.
---

# Brand Kit

Aliases: `brand`, `brand-system`, `visual-identity`, `brand-guidelines`.

## When to use

- Buat identitas visual baru: logo SVG, wordmark, palet warna, spesifikasi tipografi.
- Definisikan varian brand (warna gelap/terang, ukuran, full vs ikonik) dengan aturan penggunaan.
- Bangun brand guidelines untuk konsistensi di seluruh aset produk.
- Siapkan aset branding siap produksi untuk tim desain dan engineering.

## When not to use

- Desain UI/UX umum atau wireframe → `ui-ux-design`
- Membuat ikon tunggal tanpa konteks brand → `svg-vector-designer`
- Rendering materi 3D → `pbr-rendering`

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk alignment tema/brand project.
2. **Intake** — Kumpulkan requirement brand: nama, nilai inti, audiens, channel penggunaan.
3. **Logo & wordmark** — Buat dasar logo dalam SVG (vektor), variant warna gelap/terang, dan versi ikonik (singkat).
4. **Palet warna** — Definisikan primary, secondary, accent, neutral, dan status warna (success/warning/error) dengan kode hex + token.
5. **Tipografi** — Pilih font family, ukuran hierarki (H1–H6, body, caption), dan aturan penggunaan.
6. **Varian & aturan** — Tentukan clear space, minimum size, background yang diizinkan/dilarang, dan dos/don'ts.
7. **Dokumentasi** — Simpan brand guidelines ke `project/{id}/docs/brand/` dan aset ke `project/{id}/artifacts/brand/`.

## DoD

- [ ] Logo SVG tersimpan sebagai vektor bersih (tidak ada raster embed)
- [ ] Palet warna dokumentasi lengkap dengan token dan kode hex
- [ ] Spesifikasi tipografi ditetapkan
- [ ] Varian brand (gelap/terang, full/ikonik) tersedia
- [ ] Brand guidelines tersimpan di `project/{id}/docs/brand/`
- [ ] Semua aset tersimpan di `project/{id}/artifacts/brand/`
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
