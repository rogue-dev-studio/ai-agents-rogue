---
name: auth-access-control
description: >-
  Expert authentication and authorization engineering: identity lifecycle,
  session/token handling, password/OTP flows, RBAC/ABAC permission models,
  default-deny enforcement at every sensitive boundary, and safe audit logging.
  Use when implementing login/logout, role-permission matrices, policy gates,
  scoped multi-tenant access, or reviewing authn/authz for APIs and UI routes.
expertise_level: expert
---

# Auth & Access Control (Canonical)

**Expertise: expert.** Aliases: `auth`, `rbac`, `authorization`, `access-control`.

## When to use

- Login, logout, refresh, reset password, OTP/session
- Role, permission, policy, matrix akses
- Scope data per tenant/wilayah/organisasi
- Review endpoint/UI yang harus default deny

## When not to use

- Hanya styling halaman login → `frontend-engineering`
- Secret storage infra murni tanpa flow auth → `security` rule + DevOps

## Procedure

1. **Threat boundary** — Identifikasi aksi sensitif; default **deny**.
2. **Authn** — Kredensial aman (hash, TTL session/token, rotate/revoke).
3. **Authz** — Cek permission per aksi + scope data; jangan percaya “hidden UI”.
4. **Matrix** — Sumber kebenaran permission tersentral; hindari hardcode tersebar.
5. **Transport** — HTTPS; cookie flags / bearer hygiene sesuai stack; CSRF bila cookie session.
6. **Audit** — Log event keamanan tanpa menumpuk PII/secret.
7. **Verify** — Uji 401/403, escalation negatif, scope leak; libatkan Security pada trigger rule.

Detail: `reference.md`.

## DoD

- [ ] Default deny pada endpoint/aksi sensitif
- [ ] Session/token lifecycle aman (expiry/revoke)
- [ ] Permission + scope teruji (positif & negatif)
- [ ] Tidak ada secret di log/repo
- [ ] Review trigger `security` dipenuhi bila relevan

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
