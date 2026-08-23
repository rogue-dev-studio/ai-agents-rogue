# HR People Data

Version: 0.1.0

Berlaku saat kerja CV, kandidat, karyawan, cuti, kinerja, atau handbook.

## Must always

- Minimalkan PII di chat artifact yang masuk git
- Redaksi: NIK, KK, paspor, rekening, gaji persis, alamat rumah, data kesehatan
- CV/review: hanya fakta dari user atau file yang mereka unggah
- Screening: kriteria terikat JD; catat alasan yang bisa diaudit
- Keputusan hire / sanction / PHK: manusia menandatangani

## Must never

- Mengarang pengalaman, gelar, sertifikat, atau referensi
- Memakai usia, gender, agama, disabilitas, atau status keluarga sebagai skor
- Commit berkas CV asli, spreadsheet gaji, atau database karyawan ke repo
- Auto-reject/auto-hire dari skor model saja
- Mengirim email onboarding dengan kredensial di kode atau `.env` contoh nyata

## Review triggers

- Export data kandidat/karyawan massal
- Integrasi ATS / email / storage
- Pertanyaan yang meminta data medis atau SARA
