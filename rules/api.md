# API Rules

Version: 0.1.0

Hard constraints untuk kontrak HTTP/API. Detail: skill `api-engineering`.

## Must always

- Envelope respons & error **konsisten** di seluruh modul project
- Validasi input di boundary; tolak field/aksi yang tidak diizinkan
- Koleksi memakai pagination (atau pembatasan hasil eksplisit)
- Authn/authz default deny pada endpoint sensitif (`auth-access-control` + `security`)
- Status HTTP mencerminkan semantik (jangan 200 untuk kegagalan bisnis yang mestinya 4xx)
- Breaking change disengaja: versioning atau rencana migrasi konsumen

## Must never

- Mengembalikan stack trace, path internal, atau secret ke klien produksi
- Mengubah kontrak response diam-diam tanpa update konsumen/docs
- Mass assignment tanpa allowlist
- Mengandalkan “tombol disembunyikan di UI” sebagai otorisasi

## Review triggers

- Endpoint auth, upload, pembayaran, export massal, integrasi pihak ketiga
- Perubahan pagination/meta envelope
- Perubahan error code yang sudah dikonsumsi klien
