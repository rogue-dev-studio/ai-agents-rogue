# Database Rules

Version: 0.1.0

Hard constraints untuk pekerjaan data layer. Detail prosedur: skill `database-engineering` + role Database Engineer.

## Must always

- Desain schema selaras SRS / architecture; perubahan kolom punya alasan teknis atau requirement yang jelas
- Migration **versioned** dan **reversible** (`up` + `down`) sejauh stack mendukung
- Integrity di DB: PK, FK eksplisit, unique bisnis yang wajib, tipe data tepat
- Index untuk path filter/join/sort yang sering dipakai
- Pagination / pembatasan hasil untuk dataset besar di query layer
- Query parameterized (Eloquent / query builder / bind) — zero string-concat SQL dari input user
- Secret koneksi DB hanya di env / secret manager
- Dokumentasikan keputusan schema penting di `project/{id}/docs/architecture/` (atau ADR) saat E2E
- Ikuti skill **`database-engineering`** (tingkat keahlian: expert) untuk migrasi, indeks, relasi, mapping/`_mp`, view/trigger/function, seeder, dan gerbang performa

## Must never

- Edit migration yang sudah di-apply di environment bersama — buat migration baru
- Cross-database join antar service (microservice: integrasi via API/event)
- Seeder berisi data transaksi riil, secret, atau PII produksi
- Cascade delete massal tanpa analisis dampak / audit domain
- Menyimpan secret atau token di kolom tanpa enkripsi/hash yang disepakati arsitektur
- Me-reset volume DB bersama tanpa konfirmasi eksplisit
- Mengabaikan rule `security` untuk data sensitif, export massal, atau soft-delete finansial/klinis

## Review triggers (wajib cek Database Engineer + Security bila relevan)

- Tabel auth / session / token
- Kolom PII (NIK, medis, kontak)
- Pembayaran / billing / saldo
- Export atau anonymization
- Soft-delete vs hard-delete pada data wajib audit
