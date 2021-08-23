# Pack: SIMRS / Hospital Operations

ID: `simrs`  
Mode: **prompt → skill** (bukan “aktifkan tim dulu”). Pack lokal = tempat file skill/role/rule. **Jangan** `install.ps1 -Team simrs` pada workspace full-catalog — itu akan memangkas skill katalog. Salin skill/role lokal ke host (lihat `README.md`).

## Routing dari prompt

| Intent | Skill |
|--------|--------|
| Alur pelayanan, modul, peran tenaga, journey pasien | `simrs-hospital-ops` |
| Review aplikasi SIMRS (modul, menu, RBAC, worklist, PR klinis) | `simrs-clinical-review` |
| Checklist kepatuhan UU/Permenkes/SPO (bukan opini hukum) | `simrs-regulatory-id` |
| Mapping elemen regulasi → tabel/kolom/API/UI | `simrs-data-mapping` |
| Data pasien, PHI, audit, seed, export | `simrs-patient-data` |

Role (`simrs-domain-specialist`, `simrs-clinical-reviewer`) hanya jika user minta peran atau alur multi-agen; default cukup skill.

## Domain

Pengetahuan operasional rumah sakit Indonesia untuk merancang, menguji, dan **mereview aplikasi SIMRS**:

- Perjalanan pasien (admisi → pelayanan → penunjang → obat → billing → pulang)
- Peran tenaga: dokter, dokter spesialis / DPJP / konsulen, perawat, bidan, farmasi, lab, radiologi, gizi, RM, kasir, pendaftaran
- Modul klinis & penunjang; ketergantungan antar modul (nomor RM, kunjungan, ruangan, order)
- Bridging pihak ketiga (BPJS dan sejenis) sebagai kontrak, bukan sebagai sumber requirement diam-diam
- Data pasien = PHI — rule `simrs-patient-health-data`
- Kepatuhan Indonesia (UU/Permenkes/SPO) — skill `simrs-regulatory-id` + rule `hospital-regulatory-id` (bukan opini hukum)
- Mapping data aturan → aplikasi — skill `simrs-data-mapping` + rule `data-mapping`

## Stack & constraint

- Review domain **sebelum** klaim “fitur klinis benar”
- Jangan mendiagnosis pasien atau memberi nasihat hukum/medis; fokus alur, RBAC, audit, kelengkapan data, dan **risiko kepatuhan** vs floor regulasi
- Keputusan klinis / klaim / tarif final tetap manusia + kebijakan RS
- Lengkapi (jangan ganti) `rules/security.md` dan skill `code-review`

## Skills (lokal)

- `simrs-hospital-ops` — peta modul, peran, journey, master data
- `simrs-clinical-review` — prosedur review aplikasi SIMRS vs alur rumah sakit
- `simrs-regulatory-id` — checklist UU/Permenkes/SPO RS (bukan legal counsel)
- `simrs-data-mapping` — elemen aturan/SPO → tabel/kolom/API/UI (RHS)
- `simrs-patient-data` — PII/PHI, log, seed, export

## Roles (opsional)

- `clinical/simrs-domain-specialist` — domain rumah sakit
- `clinical/simrs-clinical-reviewer` — review alur & RBAC aplikasi

## Do / Don't

- Do: sebut modul, peran, dan titik data (RM / kunjungan / ruangan) di setiap temuan
- Do: mapping field klinis ke tabel/API sebelum klaim “sudah sesuai Permenkes”
- Do: flag aksi yang dilakukan role yang salah (mis. kasir mengubah diagnosa)
- Don't: log NIK, diagnosa, atau isi rekam medis di artifact git
- Don't: anggap modul independen tanpa nomor RM / kunjungan / workspace ruangan
- Don't: menyatakan aplikasi “sah menurut UU” tanpa verifikasi teks resmi + counsel
