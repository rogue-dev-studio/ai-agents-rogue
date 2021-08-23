# SIMRS Data Mapping

Version: 0.1.0

Berlaku saat merancang atau mengubah field klinis/administrasi pasien, schema, API, form, atau bridging. Sumber: skill `simrs-data-mapping`.

## Must always

- Petakan elemen aturan/SPO ke entitas + tempat di app (tabel/kolom atau path model) sebelum menambah field
- Data klinis tertambat RM + kunjungan (+ ruangan bila pelayanan)
- Klasifikasi PDP (identifikasi vs spesifik) dan peran baca/tulis
- Konfirmasi nama tabel/kolom di codebase project aktif; jika tidak ketemu → `VERIFY` atau `GAP`, jangan mengarang
- Jejak ubah/hapus untuk data RM

## Must never

- Menambah kolom “agar sesuai UU” tanpa rantai kunjungan
- Menyalin nilai PHI nyata ke dokumen mapping
- Menyatakan mapping = sertifikasi Kemenkes/SATUSEHAT
- Melewatkan RBAC (kasir/IT melihat SOAP) hanya karena field sudah ada

## Review triggers

- Migration / model pasien, pendaftaran, CPPT, resep, diagnosa, consent
- Endpoint export, bridging BPJS/SATUSEHAT
- Form identitas, SOAP, informed consent
