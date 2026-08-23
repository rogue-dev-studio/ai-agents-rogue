---
name: simrs-patient-data
description: >-
  Handle patient health data carefully in SIMRS work: minimize PII/PHI in logs,
  role-based access, export controls, audit on clinical and billing changes,
  and safe test fixtures. Use whenever features touch patient identity, medical
  record, resep, lab results, NIK, SEP, or billing identity.
---

# SIMRS Patient Data

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Tidak perlu aktifkan tim. Rule: `patient-health-data`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- Fitur membaca/menulis identitas pasien, RM, diagnosa, resep, hasil penunjang, tagihan
- Seed, fixture, log, export, print, bridging
- Melengkapi `auth-access-control` dan `rules/security.md`

## When not to use

- Alur pelayanan murni tanpa data pasien → `simrs-hospital-ops`
- Review journey lengkap → `simrs-clinical-review`

## Procedure

1. **Siapa** boleh akses? (peran + ruangan)
2. **Field PHI** apa yang dibaca/ditulis?
3. **Audit** siapa/kapan/apa untuk ubah klinis atau finansial?
4. **Export/print** dibatasi peran + alasan?
5. **Fixture** nama/NIK fiktif; bukan data produksi
6. **API** filter kunjungan/ruangan; jangan log body; jangan stack trace ke klien

## DoD

- [ ] Checklist rule `patient-health-data` lulus
- [ ] Seed tidak berisi pasien nyata
- [ ] Export massal punya gerbang otorisasi

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
