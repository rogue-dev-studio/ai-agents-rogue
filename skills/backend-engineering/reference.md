# Backend Engineering — Reference

## Layering

| Layer | Tanggung jawab |
|-------|----------------|
| Transport | HTTP/CLI: parse, authorize entry, map response |
| Application/Service | Use-case, transaksi, orkestrasi |
| Domain | Aturan bisnis murni bila project memisahkan |
| Persistence | Eloquent/Query/Repository |

## Laravel-oriented notes (bila stack Laravel)

- Form Request untuk validasi; Policy untuk authz
- Resource/API Resource untuk shaping response
- Job + queue untuk kerja async
- Jangan business rule panjang di Migration/Observer tanpa dokumen

## Node-oriented notes (bila stack Node)

- Router tipis; service module; schema validation (Zod/etc. sesuai project)
- Error middleware terpusat

## Anti-patterns

- God service tanpa batas
- Query di Blade/React via raw SQL string
- Silent catch yang menelan error
- Cache tanpa TTL/invalidation
