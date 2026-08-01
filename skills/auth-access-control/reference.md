# Auth & Access Control — Reference

## Authn

- Password: hash modern (bcrypt/argon2); never plain/reversible
- Session server-side atau token dengan expiry + revoke list/rotation policy
- Brute-force: rate limit / lockout sesuai ancaman
- Logout invalidates server state / token family

## Authz models

| Model | Kapan |
|-------|--------|
| RBAC | Peran stabil + permission matrix |
| ABAC / policy | Aturan berbasis atribut (owner, status, scope) |
| Scope | Filter query wajib di server, bukan hanya FE |

## UI vs API

- Sembunyikan menu ≠ otorisasi
- FE `can()` hanya UX; API wajib enforce ulang

## Anti-patterns

- Role check string tersebar tanpa registry
- Trust `user_id` dari body tanpa binding ke principal
- Permission “semua modul” tidak sengaja tersync ke role terbatas
