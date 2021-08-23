# SIMRS Data Mapping — Peta awal (RHS)

Acuan project `project/rhs`. **Verifikasi di model Yii** sebelum mengunci schema. Bukan kamus resmi Kemenkes.

Klasifikasi PDP: **S** = data spesifik, **I** = identifikasi, **O** = operasional.

## 1. Identitas & episode

| Elemen | Instrumen (floor) | Entitas | RHS (awal) | PDP | Baca / tulis (default) | Status |
|--------|-------------------|---------|------------|-----|------------------------|--------|
| Nomor RM | Permenkes 24/2022, UU Kesehatan | Pasien | `pasien_m.no_rekam_medik` | I | Pendaftaran tulis; klinisi baca | MAPPED |
| NIK / identitas | UU PDP, pendaftaran | Pasien | `pasien_m.jenisidentitas`, `no_identitas_pasien` | I | Pendaftaran; bukan log | MAPPED |
| Nama, tgl lahir, alamat, telp | UU PDP | Pasien | `pasien_m.nama_pasien`, `tanggal_lahir`, `alamat_pasien`, `no_telepon_pasien` | I | Pendaftaran tulis | MAPPED |
| Foto pasien | UU PDP, rahasia kedokteran | Pasien | `pasien_m.photopasien` | S/I | Minimasi; bukan kasir | MAPPED |
| Jejak identitas | Permenkes RM, PDP | Pasien | `pasien_m.created_*`, `last_modified_*`, `is_deleted` | O | Soft-delete + audit | PARTIAL — cek apakah isi lama tersimpan |
| Kunjungan / no. pendaftaran | RM episode | Kunjungan | `pendaftaran_t.pendaftaran_id`, `no_pendaftaran`, `tgl_pendaftaran` | O | Pendaftaran tulis | MAPPED |
| Ruangan pelayanan | kendali akses, worklist | Ruangan | `pendaftaran_t.ruangan_id` → `ruangan_m` | O | Filter `ruanganpemakai_k` | MAPPED |
| Instalasi | workspace | Instalasi | `pendaftaran_t.instalasi_id`, `modulinstalasi_mp` | O | Sysadmin | MAPPED |
| Dokter kunjungan / DPJP | UU Praktik Kedokteran | Pegawai | `pendaftaran_t.pegawai_id` → `pegawai_m` | O | Jangan semua dokter = satu user | MAPPED |
| Admisi ranap | alur inap | Admisi | `pasienadmisi_t` | O | Pendaftaran/ranap | MAPPED |
| Pulang | resume & billing | Pulang | `pasienpulang_t`, `pendaftaran_t.pasienpulang_id` | O | DPJP + kasir dampak | MAPPED |

## 2. Tenaga & akses

| Elemen | Instrumen | RHS (awal) | Catatan review |
|--------|-----------|------------|----------------|
| Identitas nakes | UU nakes | `pegawai_m.nama_pegawai`, `nomorindukpegawai` | |
| SIP | UU 29/2004 | `pegawai_m.suratizinpraktek` | PARTIAL: tidak ada expiry + gerbang SOAP; seed E2E `SIP-E2E-LOKAL` |
| STR | UU 29/2004 / 36/2014 | — | **GAP** — tidak ada kolom STR terpisah |
| Login | authz | `loginpemakai_k` | default deny |
| Hak modul | RBAC | `aksespengguna_k`, `peranpengguna_k` | |
| Hak ruangan | worklist | `ruanganpemakai_k` | |

## 3. Rekam medis & klinis

| Elemen | Instrumen | RHS (awal) | PDP | Catatan |
|--------|-----------|------------|-----|---------|
| CPPT | Permenkes RM | `cppt_t` (`cppt_v`) | S | Penulis + waktu wajib |
| Anamnesis | praktik kedokteran | `anamnesa_t` (relasi `pasien_m`) | S | Terikat kunjungan |
| Asuhan keperawatan | UU Keperawatan | `asuhankeperawatan_t` | S | Perawat tulis; bukan diagnosa medis primer |
| Diagnosa | koding RM / klaim | `pasienmorbiditas_t.pendaftaran_id` + `diagnosa_m` | S | MAPPED. `pasiendiagnosa_t` tanpa `pendaftaran_id` = PARTIAL |
| Resume ranap | pulang / klaim | `resumemedisri_t.pendaftaran_id` | S | MAPPED |
| Resume RJ | pulang | `resumemedis_t.pendaftaran_id` | S | MAPPED |
| Hasil radiologi | RM | `hasilpemeriksaanrad_t.pendaftaran_id` | S | MAPPED |
| Hasil lab | RM | `hasilpemeriksaanlab_t.pendaftaran_id` | S | MAPPED |
| Resep | Permenkes kefarmasian | `reseptur_t`, `resepturdetail_t` | S | Apoteker kaji sebelum serah |
| Informed consent | Permenkes 290/2008 | `generalconsent_t.pendaftaran_id`; `instruksitindakan_t.is_concern` | S | **PARTIAL**: nomor consent ada; tanda tangan/wali belum |
| Asuhan keperawatan | UU Keperawatan | `asuhankeperawatan_t` | S | **GAP** tabel stub (2 kolom). TTV: `anamnesa_t` |

Audit RME: utamakan `created_by`, `last_modified_*`, `is_deleted`. **GAP** jika hard-delete klinis tanpa arsip.

## 4. Penjamin, billing, bridging

| Elemen | Instrumen | RHS (awal) | PDP | Catatan |
|--------|-----------|------------|-----|---------|
| Penjamin / cara bayar | JKN / RS | `pendaftaran_t.penjamin_id`, `carabayar_id` | I/O | |
| No. SEP | JKN | model `bpjs` field `nosep`; `rencanakontrol_t.no_sep` | I | Gagal bridging ≠ hapus `pendaftaran_t` |
| No. kartu JKN | JKN | `rencanakontrol_t.no_kartu` / asuransi pasien | I | |
| Tagihan / bayar | kasir | `pembayaranpelayanan_t` | I/O | Kasir jangan tulis SOAP |
| SATUSEHAT | Permenkes 24/2022 | `satusehat_integrasi_t` | S | Schema MAPPED. Kirim API = VERIFY/off di localhost |

## 5. Aturan rantai (wajib di mapping)

```text
pasien_m.pasien_id
  └── pendaftaran_t.pendaftaran_id
        ├── ruangan_m.ruangan_id
        ├── pegawai_m.pegawai_id (klinisi episode)
        ├── cppt_t / anamnesa / resep / order / hasil
        ├── pasienadmisi_t (ranap)
        └── pembayaranpelayanan_t
```

Data klinis tanpa `pendaftaran_id` (atau setara) = **PARTIAL/GAP** rantai RM.

## 6. Template baris laporan

```text
Elemen: …
Instrumen: … | ASUMSI
App: table.column (file model: …)
API/UI: …
PDP: I/S/O
RBAC: baca=… tulis=…
Jejak: ya/tidak
Status: MAPPED | PARTIAL | GAP | VERIFY
Dampak: …
```
