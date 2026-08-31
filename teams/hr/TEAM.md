# Pack: People Operations / HR

ID: `hr`  
Mode: **prompt → skill** (bukan “aktifkan tim dulu”). Pack lokal = tempat file skill/role/rule. **Jangan** `install.ps1 -Team hr` pada workspace full-catalog — itu akan memangkas skill katalog. Salin skill/role lokal ke host (lihat `README.md`).

## Routing dari prompt

| Intent | Skill |
|--------|--------|
| CV / résumé / screening / ATS / wawancara kandidat | `hr-cv-lifecycle` |
| Psikotest / aptitude / gaya kerja / integritas kandidat | `hr-psychometric` |
| Technical interview / live coding / take-home engineer | `hr-technical-interview` |
| Onboarding / FAQ kebijakan / cuti / kerangka kinerja | `hr-employee-ops` |

Role (`hr-specialist`, `talent-recruiter`) hanya jika user minta peran atau alur multi-agen; default cukup skill.

## Domain

Bantuan HR untuk:

- Menulis dan mereview CV / résumé
- Screening kandidat terhadap job description
- Onboarding karyawan baru
- FAQ kebijakan (hanya dari dokumen yang diberi user)
- Cuti / coverage (cek kebijakan, bukan approval final)
- Ringkasan catatan wawancara dan kerangka kinerja
- Psikotest workplace (kognitif, gaya kerja, integritas) — bukan diagnosis klinis
- Paket rekrut engineer: `examples/engineer-recruitment-pack.md`

Inspirasi kapabilitas (bukan salinan kode): [EmpowerHR](https://github.com/aneeshbukya/EmpowerHR--AI-Powered-HR-Agents), [InfraX HR Agents](https://github.com/InfraXAI/InfraX.AI.Agents.HumanResources).

## Stack & constraint

- Output teks / markdown dulu; export Word/PDF via skill `office-document-tools` jika user minta file
- Data kandidat/karyawan = PII — rule `hr-people-data`
- Keputusan hiring/firing/gaji final tetap manusia

## Skills (lokal)

- `hr-cv-lifecycle` — tulis, review, cocokkan JD, ringkas catatan kandidat
- `hr-psychometric` — soal & rubrik psikotest rekrutmen, interpretasi hasil
- `hr-technical-interview` — technical test, live coding, take-home, rubrik engineer
- `hr-employee-ops` — onboarding, FAQ kebijakan, cuti, kerangka kinerja

## Roles (opsional)

- `people-ops/hr-specialist`
- `people-ops/talent-recruiter`
- `people-ops/technical-interviewer`

## Do / Don't

- Do: sebut gap bukti vs klaim di CV
- Do: flag bias (usia, gender, foto, agama) dan jangan pakai sebagai skor
- Don't: mengarang pengalaman kerja, gelar, atau sertifikat
- Don't: menyimpan CV/PII di git atau log
