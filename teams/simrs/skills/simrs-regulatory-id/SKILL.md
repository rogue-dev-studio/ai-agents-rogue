---
name: simrs-regulatory-id
description: >-
  Indonesian hospital and SIMRS regulatory checklist: UU Kesehatan, praktik
  kedokteran, keperawatan, PDP, rekam medis elektronik, SIMRS Permenkes,
  informed consent, rahasia kedokteran, SATUSEHAT, BPJS/JKN, kefarmasian,
  keselamatan pasien, akreditasi. Use when reviewing SIMRS compliance,
  kebijakan rumah sakit, UU, Permenkes, or legal obligations in hospital software.
  Not a substitute for legal counsel.
---

# SIMRS Regulatory ID

**Level: expert.** Prompt-routed skill (sumber pack: `teams/simrs`). Tidak perlu aktifkan tim. Rule: `hospital-regulatory-id`.

Bukan nasihat hukum. Checklist agar aplikasi SIMRS **tidak jelas-jelas bertentangan** dengan kewajiban RS di Indonesia. Vonis sah/tidak sah tetap legal counsel + kebijakan internal RS.

## When to use

Langsung dari prompt user (tanpa setup tim):

- Review kepatuhan SIMRS vs UU / Permenkes / SPO RS
- Fitur rekam medis, consent, hak akses, SATUSEHAT, klaim BPJS, resep, IKP
- Menulis NFR keamanan & retensi data pasien
- Melengkapi `simrs-clinical-review` (alur) dengan **dasar regulasi**

## When not to use

- Mengganti pengacara / komite medik / komite etik
- Mengarang pasal atau mengutip UU panjang seolah salinan resmi
- Diagnosis klinis → bukan skill ini
- Review kode murni → `code-review`

## Procedure

### 1. Sumber berlapis

Urutan: **teks resmi terbaru** (UU/PP/Permenkes) → **kebijakan/SPO RS yang user beri** → floor di `reference.md` (ringkasan, bisa usang).

- Ada dokumen RS → kutip judul SPO; gap vs floor undang-undang = temuan
- Tidak ada dokumen RS → pakai floor + label `ASUMSI — cek kebijakan internal`
- Konflik pasal / amandemen → **jangan putuskan**; catat “perlu verifikasi teks resmi”

### 2. Peta kewajiban → fitur

Untuk setiap fitur di scope, isi (lihat `reference.md`):

| Kewajiban | Instrumen | Implikasi SIMRS | Cek review |
|-----------|-----------|-----------------|------------|
| … | UU/Permenkes/SPO | siapa, data, jejak | lulus / gap |

### 3. Tema wajib (jika modul terkait)

1. Identitas tenaga (STR/SIP) & kewenangan praktik  
2. Rekam medis elektronik + penulis + audit + retensi  
3. Informed consent tindakan  
4. Rahasia kedokteran & UU PDP (data kesehatan = data spesifik)  
5. Hak pasien (akses isi RM sesuai aturan, bukan bocor ke semua user)  
6. Pelayanan kefarmasian (verifikasi apoteker)  
7. Keselamatan pasien / IKP bila modul ada  
8. Interoperabilitas SATUSEHAT / bridging JKN — kontrak, bukan hapus data lokal  
9. Akreditasi: jejak, SPO, hak akses terdokumentasi  

### 4. Laporan

Temuan: `[REG-P0|P1|P2]` + instrumen (nama UU/Permenkes, **bukan** kutipan panjang) + dampak di app.  
Jangan tulis “sah menurut hukum”. Tulis “risiko kepatuhan: aplikasi memungkinkan X yang biasanya dilarang kewajiban Y”.

## DoD

- [ ] Disclaimer “bukan opini hukum” di laporan
- [ ] Instrumen disebut (UU/Permenkes/SPO) atau `ASUMSI`
- [ ] Tidak ada PHI di artifact
- [ ] Pasal yang ragu ditandai untuk verifikasi manusia

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
