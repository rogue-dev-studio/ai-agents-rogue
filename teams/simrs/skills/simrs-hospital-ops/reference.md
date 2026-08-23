# SIMRS Hospital Ops — Reference

Detail untuk skill `simrs-hospital-ops`. Jangan copy data pasien nyata ke sini.

## 1. Identitas data (wajib konsisten)

| Konsep | Fungsi | Catatan review |
|--------|--------|----------------|
| Nomor RM | Identitas pasien seumur hidup di RS | Jangan ganti diam-diam; merge duplikat = prosedur RM |
| Kunjungan / registrasi / no. pendaftaran | Satu episode pelayanan | Rajal, IGD, ranap, MCU bisa beda jenis kunjungan |
| Ruangan / poli / instalasi | Workspace operasional | Filter worklist & stok; hak `ruanganpemakai` |
| DPJP | Dokter penanggung jawab (terutama ranap) | Beda dengan dokter jaga / konsulen |
| Penjamin | Umum, BPJS, perusahaan | Mempengaruhi SEP, tarif, otorisasi |
| Order | Permintaan lab/rad/ok/gizi | Harus tertambat ke kunjungan |
| Resep | Permintaan obat | Verifikasi apoteker sebelum serah |
| Tagihan | Item jasa + obat + kamar | Jangan hilang saat batal klinis tanpa jejak |

## 2. Peta modul SIMRS (nama bisnis, bukan vendor)

| Kode | Modul | Pelaku utama | Keluaran khas |
|------|--------|----------------|---------------|
| REG | Pendaftaran / admisi | Petugas pendaftaran, call center | RM, kunjungan, SEP, rujukan |
| ANT | Antrian | Petugas loket, display | Nomor antrian poli/kasir |
| RJ | Rawat jalan | Dokter poli, perawat poli | Anamnesis, fisik, diagnosa, resep, surat kontrol |
| IGD | Rawat darurat | Dokter IGD, perawat IGD | Triase, TTV, observasi, rujuk ranap |
| RI | Rawat inap | DPJP, perawat ruangan, bidan | Kamar, askep, CPPT, diet, pulang |
| OK | Bedah | Dokter bedah, anestesi, perawat OK | Jadwal OK, intra-op, recovery |
| LAB | Laboratorium | Analis, dokter PK | Order, sample, hasil, critical value |
| RAD | Radiologi | Radiografer, dokter radiologi | Order, eksposur, expertise |
| FAR | Farmasi / apotek | Apoteker, asisten | Resep, TDM, stok, e-resep |
| GF | Gudang farmasi | Petugas gudang | Penerimaan, distribusi ruangan |
| GIZ | Gizi | Ahli gizi | Diet, permintaan makan, asesmen gizi |
| FIS | Fisioterapi / rehab | Fisioterapis | Program terapi, sesi |
| BD | Bank darah | Petugas BDRS | Permintaan, crossmatch, serah |
| CSSD | Sterilisasi | Petugas CSSD | Instrumen kotor → steril |
| AMB | Ambulan | Petugas ambulan | Permintaan, pemakaian |
| MCU | Medical check up | Dokter MCU, petugas | Paket, hasil, kesimpulan |
| BILL | Kasir / billing | Kasir, keuangan | Tarif, bayar, piutang |
| PJ | Penata jasa | Petugas tarif | Mapping tindakan–tarif |
| ASU | Penjamin / asuransi | Petugas klaim | SEP, verifikasi, grouping |
| RM | Rekam medik | Petugas RM | Assembling, koding, pelaporan |
| SYS | Sysadmin / master | Admin SIMRS | User, peran, ruangan, modul |
| CRM | Informasi / CRM | Humas / IT | Laporan non-klinis, aduan |

Modul master/DCMS adalah **konfigurasi**, bukan pelayanan pasien.

## 3. Peran tenaga dan wewenang sistem

### 3.1 Dokter (umum / poli)

- Boleh: anamnesis, pemeriksaan, diagnosa (ICD), resep, surat sakit/kontrol, order lab/rad, resume rajal
- Tidak boleh (default): mengubah tarif master, merilis stok gudang, menghapus RM, mengganti identitas pasien tanpa jejak
- Kredensial di master: SIP/STR sebagai data kepegawaian — sistem **tidak** menggantikan izin praktik

### 3.2 Dokter spesialis, DPJP, konsulen

| Peran | Inti |
|-------|------|
| Spesialis poli | Sama seperti dokter poli + tindakan sesuai kompetensi |
| DPJP ranap | Bertanggung jawab episode inap: advis, resep ranap, keputusan pulang |
| Konsulen | Menjawab konsul; tidak otomatis menggantikan DPJP |
| Dokter jaga IGD | Stabilisasi, triase bersama perawat; rujuk DPJP/ranap |

Review: UI jangan mencampur “semua dokter” jadi satu peran. Konsul ≠ pindah DPJP.

### 3.3 Perawat dan bidan

- Boleh: TTV, asesmen keperawatan, implementasi askep, catat pemberian obat, intake-output, triase (IGD, sesuai SOP), partograf (kebidanan)
- Tidak boleh (default): menetapkan diagnosa medis primer, meresepkan obat (kecuali protokol yang diizinkan RS), mengubah penjamin, menutup tagihan
- PJ shift / perawat primer: filter pasien ruangan, bukan seluruh RS

### 3.4 Administrasi & penunjang

| Peran | Boleh | Jangan |
|-------|--------|--------|
| Pendaftaran | Identitas, kunjungan, SEP, pilih poli/dokter | Isi SOAP, lihat hasil lab lengkap tanpa kebutuhan |
| Antrian | Panggil, skip, display | Ubah diagnosa |
| Kasir | Bayar, diskon sesuai wewenang, cetak kwitansi | Ubah rekam medis |
| Farmasi | Verifikasi resep, serah obat, stok | Menerbitkan diagnosa |
| Lab / rad | Proses order, input hasil, expertise (dokter) | Membuka seluruh RM tanpa order |
| Gizi | Diet & permintaan makan | Order bedah |
| RM | Berkasan, koding, pelaporan, pelacakan berkas | Mengarang isi klinis |
| Sysadmin | User, menu, ruangan, modul | Impersonasi klinisi tanpa audit |

## 4. Journey kanonik

### 4.1 Rawat jalan

1. Pendaftaran (pasien baru → RM baru; lama → cari RM) + penjamin  
2. Antrian poli  
3. Perawat poli: TTV / screening  
4. Dokter: SOAP, diagnosa, prosedur, order, resep, kontrol  
5. Penunjang (jika order)  
6. Farmasi  
7. Kasir (umum) atau klaim (BPJS)  
8. RM assembling

Putus rantai jika: resep terbit tanpa kunjungan; hasil lab tanpa order; kasir menagih tindakan yang belum dicatat.

### 4.2 IGD

1. Datang → triase (P1/P2/P3 atau setara)  
2. Registrasi IGD (boleh paralel dengan resusitasi)  
3. TTV + asesmen  
4. Dokter IGD: tindakan, obat, observasi  
5. Keputusan: pulang / rujuk / inap  
6. Jika inap: bed + DPJP + serah terima

Jangan blokir triase hanya karena data administrasi belum lengkap — catat identifikasi sementara lalu lengkapi.

### 4.3 Rawat inap

1. Admisi kamar/kelas dari IGD, rajal, atau rujukan  
2. Serah terima perawat  
3. DPJP visit, CPPT, advis  
4. Order berulang (lab, rad, gizi, fisio, OK)  
5. Pemberian obat (e-MAR / catatan pemberian)  
6. Pulang: resume, edukasi, resep pulang, surat kontrol  
7. Billing akomodasi + jasa + obat  
8. Bed kosong kembali ke manajemen tempat tidur

### 4.4 Order → hasil

Dokter/klinisi order → penunjang terima (ruangan tujuan) → sampel/tindakan → hasil (nilai kritis ke dokter) → dilampirkan di kunjungan asal.

### 4.5 Farmasi

Resep dari kunjungan → antrian farmasi → screening apoteker (interaksi, dosis, stok) → dispensing → stok berkurang → (ranap) serah ke ruangan / UDD.

### 4.6 Bedah

Jadwal OK + persetujuan tindakan → pre-op → intra-op (tim, implant, darah) → recovery → instruksi post-op → instrumen ke CSSD.

### 4.7 Pulang & klaim

Resume + diagnosa koding → tagging jasa → verifikasi penjamin → bayar/piutang → berkas klaim. Batal pelayanan harus menelusuri stok dan tagihan.

## 5. Master data yang sering salah

- Dokter tanpa mapping poli / jadwal → antrian kosong
- Ruangan tanpa instalasi → workspace picker kosong
- Peran tanpa menu (`peranpengguna_akses` kosong) → kartu modul ada, sidebar kosong
- Tarif tidak ter-mapping tindakan → kasir 0 atau item hilang
- ICD / tindakan tidak aktif → dokter tidak bisa closing

## 6. Bridging (BPJS dan sejenis)

- SEP, rujukan, kontrol, antrean, klaim = kontrak eksternal
- Sandbox ≠ produksi; kredensial hanya env
- Gagal bridging tidak boleh menghapus kunjungan lokal diam-diam; tampilkan status + retry
- Mapping field didokumentasikan; jangan hardcode kode faskes di banyak tempat

## 7. Risiko khas untuk reviewer

| Gejala di app | Dampak operasional |
|---------------|-------------------|
| Worklist lintas ruangan tanpa hak | Bocor data + salah obat |
| Perawat bisa edit diagnosa primer | Jejak klinis rusak |
| Batal resep tidak mengembalikan stok | Selisih gudang |
| Pulang ranap tanpa resume | RM & klaim macet |
| Dua RM untuk satu orang | Pelayanan pecah |
| Order lab tanpa kunjungan | Hasil tidak ke dokter |
| Superadmin = satu ruangan | Modul terbuka, pelayanan tidak bisa dipilih |
