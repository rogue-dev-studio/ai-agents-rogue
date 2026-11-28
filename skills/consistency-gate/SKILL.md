---
name: consistency-gate
description: >-
  Enforce character and brand consistency across AI-generated assets. Locks
  visual identity, pose, palette, and style so output stays coherent across
  runs and deliverables.
---

# Consistency Gate

Aliases: `consistency`, `character-lock`, `brand-lock`, `style-lock`.

## When to use

- Pastikan karakter yang sama tampil konsisten di seluruh generasi AI (pose, wajah, pakaian, prop).
- Kunci palet warna dan gaya visual agar output tidak bervariasi antar run.
- Terapkan brand guidelines secara konsisten di semua aset desain dan marketing.
- Validasi apakah aset baru sesuai identitas yang telah ditetapkan sebelum diterbitkan.

## When not to use

- Membuat identitas brand baru dari nol → `brand-kit`
- Desain ikon atau ilustrasi tunggal → `svg-vector-designer`
- Review kode sumber → `code-review`

## Procedure

1. **Theme Gate (wajib)** — Baca `PROJECT.md` atau `project/{id}/docs/design/` untuk referensi brand dan karakter yang terkunci.
2. **Kumpulkan referensi** — Siapkan character sheet, brand kit, dan contoh aset yang sudah disetujui.
3. **Definisikan parameter kunci** — Warna, tipografi, bentuk karakter, gaya ilustrasi, dan elemen visual yang tidak boleh berubah.
4. **Generate atau review aset** — Buat aset baru atau tinjau aset yang ada terhadap parameter kunci.
5. **Bandandingkan** — Cek konsistensi visual: palet, proporsi karakter, gaya garis, dan elemen brand.
6. **Terbitkan atau tolak** — Terima jika konsisten, tolak dan minta revisi jika ada simpangan.
7. **Simpan bukti** — Catatan hasil gate dan aset disimpan di `project/{id}/docs/consistency/`.

## DoD

- [ ] Referensi brand dan karakter tersimpan di `project/{id}/docs/design/`
- [ ] Parameter kunci (warna, tipografi, bentuk, gaya) terdefinisi
- [ ] Setiap aset dicek terhadap parameter kunci sebelum diterbitkan
- [ ] Hasil gate (terima/tolak) dan aset tersimpan di `project/{id}/docs/consistency/`
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
