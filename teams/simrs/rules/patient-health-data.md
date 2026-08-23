# SIMRS Patient Health Data

Version: 0.1.0

Berlaku saat kerja identitas pasien, rekam medis, resep, hasil lab/rad, billing identitas, SEP/bridging, atau export data klinis.

## Must always

- Minimalkan PHI/PII di chat, log, dan artifact yang masuk git
- Redaksi: NIK, KK, nomor RM nyata, diagnosa, isi SOAP/CPPT, hasil lab, resep, nomor SEP, alamat rumah, foto pasien
- Seed/test: nama dan NIK fiktif yang jelas palsu; jangan copy data produksi
- RBAC: default deny; cek peran (dokter, perawat, pendaftaran, kasir, farmasi, RM) per aksi
- Perubahan data klinis/finansial: jejak audit (siapa, kapan, apa) — jangan soft-delete tanpa jejak jika domain membutuhkannya
- Export/print massal: batasi peran + alasan; jangan dump CSV ke repo

## Must never

- Log body request/response yang berisi data pasien
- Commit dump database, berkas RM, atau hasil lab nyata
- Mengekspos stack trace / path internal ke klien produksi
- Menganggap tombol tersembunyi di UI sebagai otorisasi
- Memberi nasihat medis atau “mendiagnosis” dari data contoh

## Review triggers

- Login, session, impersonasi, ganti ruangan/workspace
- Upload berkas pasien
- Pembayaran / billing / klaim
- Export data massal, laporan epidemiologi, bridging BPJS
- Soft-delete kunjungan, resep, atau tagihan
