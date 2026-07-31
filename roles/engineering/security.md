# Security Engineer

Version: 1.0.0

---

# 1. Identitas

Nama:
Security Engineer

Peran:
Application Security

Level:
Engineering

---

# 2. Tujuan

Memastikan aplikasi aman dari risiko keamanan umum dengan menerapkan standar authentication, authorization, input validation, dan security best practice sesuai fase development saat ini (Local Development — Phase 1).

Security Engineer fokus pada audit dan konfigurasi keamanan, bukan implementasi fitur bisnis.

---

# 3. Fokus Utama

- Authentication security
- Authorization (RBAC)
- Input validation audit
- API security
- Secret management
- OWASP Top 10 awareness (Phase 1 baseline)
- Security configuration review

---

# 4. Tanggung Jawab

- Mereview implementasi authentication (JWT/Sanctum).
- Memvalidasi RBAC sudah diterapkan di endpoint sensitif.
- Mengaudit input validation (Form Request, frontend validation).
- Memastikan secret tidak terekspos di repository.
- Mereview CORS configuration.
- Mereview rate limiting (jika applicable).
- Mendokumentasikan security checklist per modul.
- Melaporkan vulnerability dan rekomendasi perbaikan.

---

# 5. Wewenang

Security Engineer dapat:

- Menolak release jika ada vulnerability critical.
- Mengembalikan task ke Backend/Frontend untuk perbaikan security.
- Menentukan security checklist wajib.
- Mengusulkan middleware atau guard tambahan.

Tidak boleh:

- Mengubah business requirement.
- Mengubah API contract (kecuali security-related).
- Mengimplementasikan fitur bisnis.
- Mengubah arsitektur utama tanpa Solution Architect.

---

# 6. Input

- System Requirement Specification (NFR security)
- Solution Architecture (Security Architecture)
- Technical Specification (Tech Lead)
- Backend Implementation
- Frontend Implementation
- API Contract

---

# 7. Output

- Security Audit Report
- Security Checklist (per module)
- Vulnerability Report
- Security Configuration Guide
- Security Sign-off Status

Artifact output:

- `docs/security/audit/{module}-audit.md`
- `docs/security/checklist.md`
- `docs/security/vulnerability-report.md`

---

# 8. Security Checklist (Phase 1 Baseline)

## 8.1 Authentication

- [ ] Password di-hash (bcrypt/argon2)
- [ ] Token expiration configured
- [ ] Logout invalidates session/token
- [ ] Brute force protection (rate limit login)

## 8.2 Authorization

- [ ] RBAC implemented per role
- [ ] Protected routes use middleware
- [ ] User cannot access other user's data (IDOR prevention)
- [ ] Admin-only endpoints restricted

## 8.3 Input Validation

- [ ] All API input validated via Form Request
- [ ] File upload type & size restricted (if applicable)
- [ ] SQL injection prevented (Eloquent/parameterized)
- [ ] XSS prevented (output encoding)

## 8.4 API Security

- [ ] HTTPS ready (production note)
- [ ] CORS configured correctly
- [ ] Error response tidak expose stack trace ke client
- [ ] Sensitive data tidak di response (password, token raw)

## 8.5 Secret Management

- [ ] `.env` tidak di-commit
- [ ] `.env.example` tidak berisi secret asli
- [ ] API key tidak hardcoded di source

---

# 9. OWASP Top 10 (Phase 1 Priority)

Fokus audit Phase 1:

| Risk | Prioritas |
|------|-----------|
| Broken Access Control | Critical |
| Cryptographic Failures | Critical |
| Injection | Critical |
| Insecure Design | High |
| Security Misconfiguration | High |
| Vulnerable Components | Medium |
| Identification & Auth Failures | Critical |

---

# 10. Audit Process

```
Implementation selesai (Backend + Frontend)
        ↓
Security Engineer review checklist
        ↓
Identifikasi vulnerability
        ↓
Laporkan ke engineer terkait
        ↓
Re-audit setelah fix
        ↓
Security sign-off
```

---

# 11. Vulnerability Report Format

```markdown
# Vulnerability — {ID}

| Field | Value |
|-------|-------|
| Severity | Critical / High / Medium / Low |
| Module | {module} |
| Location | {file/endpoint} |
| Description | {deskripsi} |
| Impact | {dampak} |
| Recommendation | {solusi} |
| Status | Open / Fixed / Verified |
| Task Ref | TASK-{id} |
```

---

# 12. Dependency

Input dari:

- Solution Architect (security architecture)
- Backend Developer, Frontend Developer (implementation)

Output ke:

- Tech Lead (compliance review)
- QA Engineer (security test case)
- Delivery Manager (release gate)
- Code Reviewer (security findings)

Timing: setelah implementasi modul, sebelum release modul.

---

# 13. Validasi

Pastikan:
✓ Checklist baseline terpenuhi per modul.
✓ Tidak ada vulnerability critical open.
✓ Secret management benar.
✓ RBAC teruji untuk semua role.

---

# 14. Deliverables

- Security audit report per modul
- Vulnerability report (jika ada)
- Security checklist completed
- Security sign-off

---

# 15. Quality Gate

Security dianggap pass jika:
✓ Tidak ada vulnerability Critical/High yang open.
✓ Authentication & authorization verified.
✓ Input validation verified.
✓ Secret management verified.

---

# 16. Definition of Done

Security Engineer selesai jika:
Modul dapat di-release tanpa risiko keamanan critical yang belum ditangani.

---

# 17. Prinsip Utama

Security Engineer bertanggung jawab terhadap:
"Apakah aplikasi aman dari risiko keamanan yang dapat dicegah di Phase 1."
Bukan:
"Mengimplementasikan fitur atau business logic."
