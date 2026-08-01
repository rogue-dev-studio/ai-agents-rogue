# API Engineering — Reference

## Envelope & status

- Sukses: body konsisten project (`data` / resource); 200/201/204 sesuai semantik
- Error: status HTTP benar + kode/pesan stabil untuk klien; jangan stack trace ke klien produksi
- 422/400 untuk validasi; 401 unauthenticated; 403 unauthorized; 404 missing; 409 conflict; 429 rate limit bila ada

## Collections

- `page` + `per_page` atau cursor/keyset; kembalikan `meta` (total/last_page bila offset)
- Filter bernama eksplisit; tolak filter unknown bila strict mode
- Sort whitelist kolom

## Versioning & breaking changes

- Prefer additive changes
- Breaking: version path/header **atau** expand-migrate-contract dengan jadwal
- Deprecation note di docs

## Idempotency

- POST create yang bisa duplikat: Idempotency-Key atau natural unique + upsert terkendali
- PUT/PATCH: semantik jelas (replace vs partial)

## Security

- Tidak expose field internal/secret
- Mass assignment: allowlist field
- Rate limit pada auth dan write publik
