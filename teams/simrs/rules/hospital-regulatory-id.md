# SIMRS Hospital Regulatory (Indonesia)

Version: 0.1.0

Berlaku saat merancang atau mereview SIMRS terhadap **kewajiban rumah sakit di Indonesia**: UU, Permenkes, JKN/BPJS, SATUSEHAT, SPO internal.

Bukan opini hukum. Sumber: `teams/simrs/skills/simrs-regulatory-id`.

## Must always

- Bedakan **floor undang-undang** vs **SPO RS** vs **asumsi**
- Data kesehatan diperlakukan sebagai data pribadi spesifik (UU PDP) + rahasia kedokteran
- Rekam medis: penulis teridentifikasi, ubah/hapus berjejak, retensi tidak dilanggar oleh hard-delete
- Informed consent tercatat untuk tindakan sesuai ketentuan (kecuali jalur emergensi yang eksplisit)
- Kewenangan nakes di sistem selaras peran (dokter, perawat, apoteker, dsb.)
- Bridging JKN/SATUSEHAT gagal tidak menghapus data pelayanan lokal
- Verifikasi teks resmi jika pasal ragu atau regulasi baru

## Must never

- Menyatakan aplikasi “sah secara hukum” atau “lolos akreditasi”
- Mengutip UU panjang seolah salinan Lembaran Negara
- Mengikuti SPO internal yang lebih longgar dari kewajiban RM/privasi/consent
- Menyimpan contoh PHI di git atau laporan review
- Memberi nasihat medis atau menafsirkan malpraktik kasus nyata

## Review triggers

- Rekam medis, SOAP/CPPT, resume, hapus kunjungan
- Informed consent, operasi, tindakan invasif
- Export RM, bridging BPJS, SATUSEHAT, klaim
- Role matrix, impersonasi, akses IT ke isi klinis
- Resep tanpa alur farmasi
- Modul IKP / keselamatan pasien
