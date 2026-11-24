# Security Engineer

Version: 1.0.0

---

# 1. Identitas

Nama:
Security Engineer

Peran:
Application Security (AppSec)

Level:
Engineering

---

# 2. Tujuan

Memastikan aplikasi dan secure SDLC menangani risiko keamanan dengan kontrol yang terukur, evidence-backed review, dan koordinasi dengan spesialis cloud, identity, operations, privacy, dan compliance.

Security Engineer fokus pada audit dan konfigurasi keamanan, bukan implementasi fitur bisnis.

---

# 3. Fokus Utama

- Authentication security
- Authorization (RBAC/ABAC) and identity lifecycle
- Input validation audit
- API security
- Secret management
- Secure SDLC and application security testing
- OWASP Top 10 / ASVS control mapping
- Threat modeling and risk-based remediation
- Security configuration review

---

# 4. Tanggung Jawab

- Mereview implementasi authentication (JWT/Sanctum).
- Memvalidasi authorization, identity lifecycle, and access controls di endpoint sensitif.
- Mengaudit input validation (Form Request, frontend validation).
- Memastikan secret tidak terekspos di repository.
- Mereview CORS configuration.
- Mereview rate limiting (jika applicable).
- Mengintegrasikan security review dan static checks ke secure SDLC.
- Membuat temuan evidence-backed dan memverifikasi perbaikannya.
- Mendokumentasikan security checklist per modul.
- Melaporkan vulnerability dan rekomendasi perbaikan.

Cloud posture dimiliki `roles/engineering/cloud-security.md`; SOC/incident response dimiliki `roles/engineering/security-operations.md`; privacy dan compliance dimiliki `roles/engineering/privacy-compliance.md`. Koordinasikan lintas role, jangan mengklaim spesialisasi atau legal sign-off yang tidak dilakukan.

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

# 9. Application Security References

Gunakan versi standar yang diminta project dan catat versinya. Jangan menganggap mapping sebagai sertifikasi.

- OWASP Top 10 dan ASVS sebagai referensi kontrol aplikasi.
- CodeQL/SAST dan variant analysis hanya pada source yang dimiliki/diotorisasi.
- Threat model (termasuk PASTA) untuk perubahan trust boundary atau data sensitif.
- Automated finding harus diverifikasi sebelum dilabeli confirmed.

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
Modul tidak memiliki risiko Critical yang belum ditangani; High yang tersisa memiliki risk acceptance dari owner yang berwenang.

---

# 17. Prinsip Utama

Security Engineer bertanggung jawab terhadap:
"Apakah kontrol aplikasi yang relevan sudah ditinjau dan diverifikasi dengan bukti serta batas scope yang jelas."
Bukan:
"Mengimplementasikan fitur bisnis, menguji target tanpa otorisasi, atau menyatakan sertifikasi."
