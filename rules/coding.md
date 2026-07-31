# Coding Rules

Version: 0.1.0

## Must always

- Ikuti struktur & konvensi repo yang sudah ada (jangan ganti stack diam-diam)
- Perubahan kecil, terfokus, bisa dijelaskan
- Type-safe sejauh stack mendukung; handle error di boundary
- Nama yang jelas; hindari magic number tanpa konstanta bermakna
- Tulis tes untuk perilaku baru yang kritis (lihat skill `agentic-qe`)

## Must never

- Refactor besar di luar scope task
- Copy-paste blok besar tanpa mengekstrak yang perlu
- Menambah dependency tanpa alasan di task/PR note
- Meninggalkan `TODO` kritis tanpa ticket/task id

## Layering (default)

- UI tidak akses DB langsung
- Business rules tidak tercecer hanya di controller/widget
- Migrasi DB mundur/aman dipertimbangkan sebelum apply

Sesuaikan detail framework di Tech Lead / role Engineering project aktif.
