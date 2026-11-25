---
name: content-moderation
description: >-
  Moderate AI-generated content before publication. Flags and blocks prohibited
  material, enforces content policy, and records review decisions for
  accountability.
---

# Content Moderation

**Level: max.** Aliases: `moderation`, `content-filter`, `policy-gate`, `safety-review`.

## When to use

- Periksa aset yang dihasilkan AI (gambar, teks, audio, video) terhadap kebijakan konten project.
- Tandai atau blokir materi yang dilarang (kekerasan, kasar, ilegal, PII, dll.).
- Terapkan aturan konten yang ditetapkan sebelum aset diterbitkan.
- Catat keputusan moderasi untuk audit dan tanggung jawab.

## When not to use

- Validasi kualitas teknis aset → `quality-gate`
- Konsistensi karakter/brand → `consistency-gate`
- Analisis aset secara mendalam → `asset-analysis`

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk kebijakan konten project.
2. **Tentukan aturan moderasi** — Jenis konten yang dilarang, ambang batas, dan konsekuensi pelanggaran.
3. **Tinjau aset** — Periksa isi aset terhadap aturan yang ditetapkan.
4. **Tentukan keputusan** — Setuju, tandai untuk revisi, atau blokir dengan alasan tertulis.
5. **Catat hasil** — Simpan laporan moderasi dan keputusan di `project/{id}/docs/moderation/`.
6. **Hapus atau revisi** — Aset yang diblokir dihapus atau direvisi sebelum diterbitkan ulang.

## DoD

- [ ] Kebijakan konten project tersimpan di `project/{id}/docs/design/` atau `project/{id}/docs/policy/`
- [ ] Setiap aset dicek terhadap aturan moderasi sebelum diterbitkan
- [ ] Keputusan moderasi (setuju/tandai/blokir) dengan alasan dicatat
- [ ] Laporan moderasi tersimpan di `project/{id}/docs/moderation/`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
