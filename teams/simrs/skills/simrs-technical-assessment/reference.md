# SIMRS technical assessment — reference

## Rubrik (1–5)

| Dimensi | 1 | 3 | 5 |
|---------|---|---|---|
| Alur klinis | Memutus rantai kunjungan | Alur OK, gap edge | End-to-end + edge case |
| Data modeling | RM/kunjungan salah | Relasi OK | Index + audit trail |
| API design | Tidak konsisten | CRUD OK | Authz + error envelope |
| PHI & security | Data berlebih di log/API | Validasi dasar | RBAC per aksi, minimasi PHI |
| Regulatory awareness | Tidak tahu RM/consent | Floor dasar | Gap vs Permenkes dilabel jelas |
| Komunikasi teknis | Kabur | Cukup | Trade-off jelas |

**PHI/security wajib ≥3** untuk pass, terlepas dari rata-rata lain.

## Soal contoh — Alur & data

> Pasien datang IGD → triage → observasi → decision rawat inap atau pulang. Sebut modul SIMRS, entitas data (RM, kunjungan, ruangan), dan titik audit.

**Nilai:** kunjungan sebagai root, tidak order tanpa konteks kunjungan.

## Soal contoh — API

> Desain API create order lab: wajib kunjungan aktif, status order, cancel idempotent, error jika pasien tidak terdaftar di kunjungan.

## Soal contoh — RBAC

> Perawat boleh input vital sign; dokter boleh order obat; kasir tidak akses diagnosa. Bagaimana enforce di API (bukan hanya hide menu)?

## Soal contoh — PHI

> Log error menampilkan NIK pasien — apa risiko dan fix?

## Soal contoh — Integrasi (mid+)

> Bridging SEP BPJS gagal timeout — perilaku UI dan retry tanpa duplikasi SEP.

## Soal contoh — Live coding

Fungsi: validasi status transisi order farmasi (`pending` → `dispensed` → `cancelled`); throw jika transisi ilegal.

## Take-home brief

- Mini modul: registrasi kunjungan rawat jalan (mock data, tidak PHI nyata)
- RBAC: resepsionis create, dokter read clinical fields
- README + 2+ test
- Batas: 3–4 jam efektif

## Candidate prep — topik wajib

1. Beda RM vs kunjungan vs episode
2. Soft delete vs audit untuk data klinis
3. Pagination list pasien tanpa expose field tidak perlu
4. Idempotency pada integrasi eksternal
5. Contoh insiden produksi SIMRS yang Anda tangani (jika ada)
