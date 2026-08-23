# SIMRS Regulatory ID — Ringkasan instrumen

**Bukan salinan resmi.** Cek teks di jdih.setneg.go.id / jdih.kemkes.go.id sebelum dipakai keputusan. Tanggal acuan penyusunan: 2026-08.

Floor = kewajiban minimum yang biasanya berdampak ke **desain SIMRS**. Kebijakan RS boleh lebih ketat.

## 1. Hierarki

```text
UU / PP  →  Permenkes / Perpres (JKN)  →  kebijakan & SPO rumah sakit  →  kebiasaan modul
```

Jika SPO RS lebih longgar dari UU (mis. hapus RM tanpa jejak) → temuan **REG-P0**, bukan “ikut SPO”.

## 2. Instrumen yang sering relevan

| Instrumen | Tema untuk SIMRS |
|-----------|------------------|
| UU 17/2023 tentang Kesehatan | Payung: sistem informasi kesehatan, RM, hak pasien, data kesehatan, telemedisin |
| UU 29/2004 Praktik Kedokteran | STR/SIP, informed consent, rahasia kedokteran, rekam medis |
| UU 38/2014 Keperawatan | Kewenangan perawat vs diagnosa medis |
| UU 36/2014 Tenaga Kesehatan | Kewenangan nakes lain (gizi, radiografer, analis, dsb.) |
| UU 44/2009 Rumah Sakit | Kewajiban RS & hak pasien (sebagian overlap UU Kesehatan) |
| UU 27/2022 PDP | Data kesehatan = data pribadi **spesifik**; dasar pemrosesan, minimasi, pelanggaran data |
| UU ITE (beserta perubahan) | Transaksi elektronik, akses ilegal, keaslian dokumen elektronik |
| UU 40/2004 SJSN & UU 24/2011 BPJS | JKN/klaim; bridging bukan pengganti rekam medis lokal |
| Permenkes 24/2022 Rekam Medis | RME, autentikasi penulis, retensi, hak akses, interoperabilitas SATUSEHAT |
| Permenkes 82/2013 SIMRS | Penyelenggaraan SIMRS di RS (keamanan, modul, integrasi) |
| Permenkes 290/2008 Persetujuan Tindakan Kedokteran | Consent sebelum tindakan (kecuali emergensi sesuai ketentuan) |
| Permenkes 72/2016 Pelayanan Kefarmasian di RS | Pengkajian resep oleh apoteker, rekonsiliasi, mutu |
| Permenkes 11/2017 Keselamatan Pasien | Insiden keselamatan pasien (IKP), pelaporan internal |
| Permenkes 4/2018 Kewajiban RS dan Kewajiban Pasien | Hak/kewajiban yang sering jadi SPO pendaftaran & pelayanan |
| STARKES (standar akreditasi Kemenkes) | Bukti jejak, kendali akses, manajemen RM, farmasi, IKP |

Perpres/Permenkes teknis JKN (SEP, antrean, iCare, klaim) berubah lebih cepat — selalu cek bridging vs environment sandbox/prod.

## 3. Peta kewajiban → cek aplikasi

### 3.1 Identitas & kewenangan tenaga

- Master pegawai/dokter menyimpan status izin (STR/SIP) sebagai **data operasional**, bukan stempel legal otomatis
- User tidak aktif / izin kedaluwarsa: jangan bisa menulis resep atau SOAP
- Perawat tidak menetapkan diagnosa medis primer (selaras UU Keperawatan vs Praktik Kedokteran)
- Apoteker mengkaji resep sebelum penyerahan (Permenkes kefarmasian)

**Gagal jika:** semua nakes memakai satu peran “user klinis” tanpa batas aksi.

### 3.2 Rekam medis elektronik (Permenkes 24/2022 + UU terkait)

- Setiap entri klinis: penulis teridentifikasi, waktu, tidak bisa disalin jadi orang lain
- Ubah/batal: jejak (siapa, kapan, nilai lama/baru) — bukan hard-delete diam-diam
- Retensi sesuai kebijakan RS + floor Permenkes; arsip tidak hilang karena “hapus kunjungan”
- Hak akses berjenjang: klinisi episode vs kasir vs IT
- Integrasi SATUSEHAT: kegagalan kirim **tidak** menghapus RM lokal

**Gagal jika:** edit SOAP tanpa audit; admin IT baca seluruh isi RM tanpa kebutuhan + jejak.

### 3.3 Informed consent

- Tindakan invasif / operasi / tindakan berisiko: bukti consent (pasien/wali, waktu, petugas) **sebelum** (kecuali gawat darurat sesuai ketentuan)
- Form terikat kunjungan/tindakan, bukan centang generik sekali seumur hidup tanpa konteks
- Penolakan tindakan tercatat

**Gagal jika:** booking OK bisa closing tanpa status consent (kecuali jalur emergensi yang eksplisit).

### 3.4 Rahasia kedokteran + UU PDP

- Data kesehatan = data pribadi spesifik → minimasi, tujuan jelas, bukan log body API
- Pengungkapan ke pihak ketiga (asuransi, BPJS, SATUSEHAT, keluarga): dasar hukum / persetujuan sesuai konteks
- Export massal RM: peran + alasan + audit
- Pelanggaran data: saluran eskalasi (bukan hanya “hapus log”)

**Gagal jika:** CSV pasien + diagnosa masuk repo/log; endpoint publik tanpa authz.

### 3.5 Hak pasien

- Akses ringkasan/isi RM oleh pasien mengikuti SPO RS (bukan semua field worklist staf)
- Informasi tarif/penjamin di kasir tidak membuka SOAP
- Koreksi identitas: prosedur RM + jejak, bukan update NIK sembarangan di loket tanpa kontrol

### 3.6 JKN / BPJS

- SEP, rujukan, kontrol, antrean: status bridging terlihat; gagal ≠ hapus pendaftaran
- Klaim memakai diagnosa/tindakan dari RM, bukan diisi kasir sendirian
- Kredensial bridging hanya env; sandbox tidak ke produksi

### 3.7 Keselamatan pasien

- Jika ada modul IKP: lapor insiden tanpa malu-malu di log publik; akses terbatas komite/mutu
- Alergi / rekonsiliasi obat: farmasi & klinisi lihat data yang sama untuk pasien yang sama

### 3.8 Akreditasi (STARKES)

Reviewer tidak “mengesahkan akreditasi”. Cek apakah app **bisa menyimpan bukti**: SPO digital, kendali akses, jejak RM, pelatihan user (opsional), indikator — sesuai modul yang ada.

## 4. Kebijakan internal RS

Minta (jika ada): SPO pendaftaran, informed consent, pelepasan informasi, retensi RM, credentialing komite medik, formularium, IKP.

| Situasi | Perilaku agent |
|---------|----------------|
| SPO ada dan lebih ketat | AC mengikuti SPO |
| SPO ada dan lebih longgar dari UU | Temuan REG; jangan implement longgarnya |
| SPO tidak ada | Floor `reference.md` + `ASUMSI` |

## 5. Prioritas temuan

| Kode | Artinya |
|------|---------|
| REG-P0 | Aplikasi memungkinkan hapus/ubah RM tanpa jejak, bocor PHI, tindakan tanpa jalur consent, atau nakes salah wewenang di aksi klinis inti |
| REG-P1 | Jejak/consent/bridging/retensi bolong; masih bisa ditambal tanpa merusak pelayanan hari ini |
| REG-P2 | Dokumentasi NFR, label UI, atau mapping pasal perlu diperjelas |

## 6. Kalimat yang dilarang di output

- “Sudah sesuai UU …” / “Legal” / “Lolos audit Kemenkes”
- Kutipan pasal panjang
- NIK, isi diagnosa, atau RM nyata sebagai contoh
