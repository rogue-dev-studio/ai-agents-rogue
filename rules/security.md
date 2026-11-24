# Security Rules

Version: 0.1.0

Berlaku untuk semua install. Tim/domain boleh menambah local skill, bukan mengabaikan rule ini.

## Must always

- Apply least privilege and default-deny to users, workloads, services, and agents
- Treat credentials, tokens, API keys as secrets — env / secret manager, bukan source tree
- Authn/authz: default deny; cek role/permission di setiap endpoint sensitif
- Validasi & sanitize input di boundary (API, form, query)
- Log tanpa PII berlebih (nama lengkap, NIK, rekam medis, token)
- Dependency baru: alasan + cek CVE kasar bila relevan
- Scope security review to owned code/assets or systems with explicit authorization; record evidence and limitations
- Separate observed facts, hypotheses, severity, and remediation; never claim an audit/certification without evidence

## Must never

- Commit `.env` berisi secret nyata
- Disable TLS / verifikasi sertifikat "sementara" di kode yang tersisa
- Soft-delete data sensitif / finansial tanpa jejak audit jika domain membutuhkannya
- Expose stack trace / internal path ke client production
- Test arbitrary public targets or perform exploitation, credential collection, persistence, evasion, or destructive activity
- Execute unknown malware on the host or broaden an incident investigation beyond approved scope

## Review triggers (wajib libatkan Security role atau checklist ini)

- Login, reset password, OTP, session
- Upload file
- Pembayaran / billing
- Export data massal
- Integrasi pihak ketiga (BPJS, payment, SMS)
- Reverse engineering atau pengujian target live; wajib validasi otorisasi dan scope
- Kontrol OBS lokal; password wajib di secret/environment dan endpoint wajib loopback
- Cloud IAM, security groups/firewalls, encryption, key management, or production posture changes
- Security incidents, personal-data processing, compliance/audit evidence, or automated security testing

## Canonical guidance

- Application code, secure SDLC, CodeQL/SAST, OWASP, and ASVS → `skills/appsec/SKILL.md`
- Identity lifecycle and protocols → `skills/auth-access-control/SKILL.md`
- Cloud posture and Zero Trust → `skills/cloud-security/SKILL.md` and `skills/zero-trust/SKILL.md`
- Threat scenarios and PASTA workshops → `skills/threat-modeling/SKILL.md`
- CVE intake and remediation → `skills/vulnerability-management/SKILL.md`
- SOC and detection engineering → `skills/security-operations/SKILL.md`
- Incidents → `skills/incident-response/SKILL.md`
- Personal data → `rules/privacy.md` and `skills/privacy-engineering/SKILL.md`
- Compliance evidence → `skills/compliance-security/SKILL.md`

Rules may be strengthened by domain policy but must not be weakened or bypassed.
