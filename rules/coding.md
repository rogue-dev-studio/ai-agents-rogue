# Coding Rules

Version: 0.3.0

## Must always

- Ikuti struktur & konvensi repo yang sudah ada (jangan ganti stack diam-diam)
- Perubahan kecil, terfokus, bisa dijelaskan
- Type-safe sejauh stack mendukung; handle error di boundary
- Nama yang jelas; hindari magic number tanpa konstanta bermakna
- Tulis tes untuk perilaku baru yang kritis (lihat skill `agentic-qe`)
- Kode/prototype **generate** → `project/{id}/artifacts/code/` kecuali monorepo app (`backend/`/`frontend/`/…) sudah menjadi target yang jelas
- Tulis kode yang **readable** dan **maintainable** (nama bermakna, struktur jelas, mudah diubah tanpa efek samping tersembunyi)
- Tulis kode yang **scalable** dan **efficient** (hindari kerja berlebih, N+1, alokasi sia-sia; siapkan pertumbuhan data/pengguna yang wajar)
- Tulis kode yang **secure** dan **robust** (validasi di boundary, gagal dengan aman, tangani error yang dapat diperkirakan)
- Utamakan **high performance** dan **high security** pada setiap perubahan
- Ikuti standar bahasa, framework, linter, formatter, dan konvensi project yang aktif
- Akses data hanya melalui **ORM / query builder / repository–model** pada lapisan persistence yang disepakati Tech Lead; parameterized by default
- File **baru**: sisipkan header atribusi developer di bagian paling atas (sesuaikan sintaks komentar bahasa terkait). Identitas saja (bukan gate code review). Identitas = username GitHub aktif developer (`gh` login / identitas repo yang disepakati); tanggal/waktu = saat file dibuat (ISO lokal atau UTC konsisten di project):

```text
/**
 * @Author: {github_username}
 * @Date:   {YYYY-MM-DD HH:mm:ss}
 * @Last Modified by:   {github_username}
 * @Last Modified time: {YYYY-MM-DD HH:mm:ss}
 */
```

- Modal / overlay / dialog: isolasi dari layout lain (portal/stacking/scroll lock sesuai stack); jangan ubah posisi elemen di belakang; jangan memicu re-render atau work berat yang tidak perlu

## Must never

- Refactor besar di luar scope task
- Copy-paste blok besar tanpa mengekstrak yang perlu (larangan **duplicate code**)
- Menambah dependency tanpa alasan di task/PR note
- Meninggalkan `TODO` kritis tanpa ticket/task id
- Menambah komentar yang tidak perlu, terlalu panjang, berlebihan, atau yang hanya menjelaskan ulang perilaku fungsional yang sudah jelas dari nama/kode
- Menyisakan **dead code**, kode spekulatif, atau kode yang tidak dipakai
- Membiarkan error tidak terduga tanpa penanganan di boundary (API, form, job, integrasi)
- Mengirim perubahan yang masih memunculkan **error atau warning SonarQube** (atau setara di pipeline project)
- Menyisipkan lebih dari **satu baris kosong beruntun** (maksimal satu baris kosong sebagai pemisah)
- Menambahkan header `@Author` / `@Date` / `@Last Modified` pada file yang **sudah ada** (hanya untuk file baru)
- Membiarkan modal merusak layout halaman lain atau menurunkan performa secara tidak wajar
- Menyisipkan **raw SQL / string query** di kode aplikasi (controller, service, job, view, frontend, script ad-hoc)
- Menjalankan **query basis data** dari UI/frontend, controller gemuk, atau lapisan di luar persistence yang ditetapkan
- Memakai `DB::select` / `DB::statement` / SQL literal di application code kecuali dikecualikan tertulis oleh Tech Lead (mis. migration DDL atau laporan yang tidak bisa di ORM) dan tetap parameterized

## Layering (default)

- UI tidak akses DB langsung
- Business rules tidak tercecer hanya di controller/widget
- Query & persistence terkonsentrasi di model/repository (bukan di controller/UI)
- Migrasi DB mundur/aman dipertimbangkan sebelum apply (detail: rule `database` + skill `database-engineering`)

Developer dan Code Reviewer wajib menegakkan rule ini. Detail review: skill `code-review` + role Code Reviewer / Tech Lead.

Sesuaikan detail framework di Tech Lead / role Engineering project aktif.
