---
name: simrs-clinical-review
description: >-
  Review a SIMRS / hospital information system against real hospital workflows:
  role-based access (dokter, spesialis, perawat, farmasi, kasir, RM), patient
  journey continuity (RM, kunjungan, ruangan), orders-results-meds-billing,
  audit, and BPJS bridging. Use when reviewing SIMRS modules, menus, RBAC,
  worklists, rekam medis, or clinical feature PRs.
---

# SIMRS Clinical Review

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Tidak perlu aktifkan tim. Role opsional: `simrs-clinical-reviewer`.

## When to use

Langsung dari prompt user (tanpa setup tim):

- User minta **review aplikasi SIMRS** (modul, menu, ruangan, hak akses, alur klinis)
- PR / diff yang menyentuh pelayanan pasien
- UAT walkthrough: “dokter vs perawat vs kasir”
- Gate Review E2E untuk project rumah sakit

## When not to use

- Review kode murni (layering, SQL, naming) tanpa alur → `code-review`
- Menulis fitur baru dari nol → `e2e-delivery` + `simrs-hospital-ops`
- Nasihat medis

## Procedure

1. **Scope** — Modul, peran yang diuji, environment (lokal/staging). Baca `simrs-hospital-ops` + `reference.md`.
2. **Identitas chain** — Setiap layar: RM, kunjungan, ruangan/workspace ada dan konsisten.
3. **RBAC walk** — Minimal 3 peran berbeda. Catat aksi yang terbuka salah (lihat matriks di `reference.md` skill ini).
4. **Journey walk** — Pilih 1 skenario: rajal **atau** IGD **atau** ranap. Ikuti rantai sampai billing/RM. Jangan klaim “semua modul OK” dari satu happy path.
5. **Side effects** — Batal, retur, ganti DPJP, pindah kamar, gagal bridging: stok/tagihan/status tidak boleh inkonsisten.
6. **PHI & audit** — Log tanpa isi klinis; aksi klinis/finansial berjejak. Rule `patient-health-data`.
7. **Regulasi ID** — Skill `simrs-regulatory-id`: consent, RME, PDP, kewenangan nakes, JKN/SATUSEHAT. Bukan opini hukum.
8. **Data mapping** — Skill `simrs-data-mapping`: elemen aturan → tabel/API/UI; status MAPPED/PARTIAL/GAP/VERIFY.
9. **Report** — P0 blocker operasional, P1 salah wewenang/data, P2 UX/salinan, plus REG-* / MAP-GAP bila relevan. Verdict Approve / Request changes / Reject.
10. **Handoff** — Temuan teknis kode → Code Reviewer; temuan alur → BA/Domain Specialist; temuan pasal ragu → legal counsel. Jangan implement kecuali user minta.

Simpan laporan E2E di `project/{id}/docs/review/` (redaksi PHI).

## DoD

- [ ] Minimal satu journey end-to-end + satu peran non-dokter
- [ ] Tema regulasi terkait modul (consent/RME/PDP/nakes) dicek atau dilabel di luar scope
- [ ] Setiap P0: dampak “siapa tidak bisa kerja / data apa rusak”
- [ ] Verdict jelas
- [ ] Tidak ada NIK/diagnosa/RM nyata di laporan

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
