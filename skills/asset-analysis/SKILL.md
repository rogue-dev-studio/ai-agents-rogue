---
name: asset-analysis
description: >-
  Analyze AI-generated assets in depth: structure, metadata, quality markers,
  provenance, and composition. Produces a structured report for review and
  archival.
---

# Asset Analysis

Aliases: `asset-scan`, `asset-inspect`, `generative-audit`.

## When to use

- Analisis aset yang dihasilkan AI secara mendalam: struktur, metadata, dan komposisi.
- Identifikasi penanda kualitas, artefak, dan masalah struktural pada aset.
- Catat provenance (sumber, prompt, parameter, model) untuk audit dan pelacakan.
- Buat laporan terstruktur untuk review dan arsip aset.

## When not to use

- Validasi kualitas sebelum penerimaan → `quality-gate`
- Moderasi konten (kecualian/penolakan isi) → `content-moderation`
- Konsistensi karakter/brand → `consistency-gate`

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk standar analisis project.
2. **Kumpulkan aset** — Siapkan file aset yang akan dianalisis beserta metadata terkait (prompt, parameter, model, waktu generate).
3. **Analisis struktural** — Periksa format file, resolusi, ukuran, lapisan, dan komposisi aset.
4. **Analisis metadata** — Ekstrak dan catat provenance: sumber, prompt, parameter, model, dan versi.
5. **Identifikasi masalah** — Tandai artefak, kebisingan, atau anomali struktural yang ditemukan.
6. **Buat laporan** — Susun laporan analisis terstruktur dan simpan di `project/{id}/docs/analysis/`.
7. **Arsip** — Simpan aset dan laporan ke `project/{id}/artifacts/` atau `project/{id}/docs/analysis/`.

## DoD

- [ ] Metadata aset (sumber, prompt, parameter, model) dicatat
- [ ] Analisis struktural dan komposisi selesai
- [ ] Masalah atau artefak teridentifikasi dan dicatat
- [ ] Laporan analisis tersimpan di `project/{id}/docs/analysis/`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
