---
name: quality-gate
description: >-
  Quality gate for AI-generated assets. Validates output against project
  standards before acceptance: no slop, clean structure, correct format, and
  production-ready quality.
---

# Quality Gate

**Level: max.** Aliases: `qc`, `asset-qc`, `output-gate`, `acceptance-gate`.

## When to use

- Validasi aset yang dihasilkan AI (gambar, video, audio, 3D, teks) sebelum diterima.
- Pastikan output bebas dari artefak, slop, atau kualitas rendah.
- Verifikasi format, resolusi, dan struktur file sesuai spesifikasi project.
- Terapkan standar kualitas minimal sebelum aset masuk ke produksi.

## When not to use

- Review kode sumber → `code-review`
- Moderasi konten (kecualian/penolakan isi) → `content-moderation`
- Analisis aset secara mendalam → `asset-analysis`

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk standar kualitas project.
2. **Tentukan kriteria terima** — Resolusi, format file, ukuran, warna, kebisingan, artefak yang diperbolehkan/dilarang.
3. **Tinjau aset** — Periksa visual dan teknis: tidak ada artefak, struktur bersih, metadata valid.
4. **Uji coba** — Buka aset di aplikasi target (viewer, engine, browser) untuk konfirmasi kompatibilitas.
5. **Tentukan keputusan** — Terima, revisi, atau tolak dengan alasan tertulis.
6. **Catat hasil** — Simpan laporan QC dan aset yang lolos ke `project/{id}/docs/qc/`.

## DoD

- [ ] Kriteria terima ditetapkan berdasarkan standar project
- [ ] Setiap aset dicek visual dan teknis sebelum diterima
- [ ] Keputusan QC (terima/revisi/tolak) dengan alasan dicatat
- [ ] Aset yang lolos tersimpan di `project/{id}/docs/qc/` atau `project/{id}/artifacts/`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
