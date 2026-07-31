# Security Rules

Version: 0.1.0

Berlaku untuk semua install. Tim/domain boleh menambah local skill, bukan mengabaikan rule ini.

## Must always

- Treat credentials, tokens, API keys as secrets — env / secret manager, bukan source tree
- Authn/authz: default deny; cek role/permission di setiap endpoint sensitif
- Validasi & sanitize input di boundary (API, form, query)
- Log tanpa PII berlebih (nama lengkap, NIK, rekam medis, token)
- Dependency baru: alasan + cek CVE kasar bila relevan

## Must never

- Commit `.env` berisi secret nyata
- Disable TLS / verifikasi sertifikat "sementara" di kode yang tersisa
- Soft-delete data sensitif / finansial tanpa jejak audit jika domain membutuhkannya
- Expose stack trace / internal path ke client production

## Review triggers (wajib libatkan Security role atau checklist ini)

- Login, reset password, OTP, session
- Upload file
- Pembayaran / billing
- Export data massal
- Integrasi pihak ketiga (BPJS, payment, SMS)
