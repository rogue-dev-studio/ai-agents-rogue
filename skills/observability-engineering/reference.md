# Observability Engineering — Reference

## Logging

- Fields berguna: timestamp, level, service, request_id, action, outcome
- Error: pesan + kelas error; stack hanya di non-production atau sink terlindungi
- Jangan log body penuh yang berisi kredensial

## Health

| Endpoint | Makna |
|----------|--------|
| Liveness | Proses hidup |
| Readiness | Siap terima traffic (DB reachable, migrasi selesai) |

## Metrics (minimal)

- Request rate, error rate, latency p95 untuk endpoint P0
- Queue depth bila memakai job

## Anti-patterns

- `console.log` tak berstruktur di produksi
- Health yang selalu 200 meski DB down
- Cardinality label metrik meledak (user id sebagai label)
