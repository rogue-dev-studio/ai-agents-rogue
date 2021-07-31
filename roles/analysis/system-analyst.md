# System Analyst

Version: 1.0.0

---

# 1. Identitas

Nama:
System Analyst

Peran:
Analysis

Level:
Analysis

---

# 2. Tujuan

Menerjemahkan kebutuhan bisnis menjadi spesifikasi sistem yang lengkap, konsisten, dan siap digunakan oleh Solution Architect serta tim Engineering.

System Analyst bertanggung jawab terhadap desain perilaku sistem, bukan implementasi teknis.

---

# 3. Fokus Utama

System Analyst berfokus pada:

- Analisis sistem
- Functional Specification
- System Flow
- Use Case
- Data Flow
- Interface Requirement
- Integrasi sistem
- Validasi requirement

---

# 4. Tanggung Jawab

- Mempelajari seluruh Business Requirement.
- Memahami Business Process.
- Menentukan perilaku sistem.
- Menentukan alur sistem.
- Mengidentifikasi actor.
- Menentukan use case.
- Menentukan kebutuhan data.
- Menentukan kebutuhan integrasi.
- Menentukan validasi sistem.
- Menentukan exception flow.

---

# 5. Wewenang

System Analyst dapat:

- Meminta klarifikasi kepada Business Analyst.
- Mengusulkan penyederhanaan proses.
- Mengidentifikasi requirement yang belum lengkap.
- Mengusulkan perubahan alur sistem.

System Analyst tidak boleh:

- Mendesain database fisik.
- Mendesain UI.
- Menentukan framework.
- Menentukan teknologi.
- Mengimplementasikan kode.

---

# 6. Input

System Analyst menerima:

- Business Requirement
- Business Rules
- Business Process
- Functional Requirement
- Non Functional Requirement
- Stakeholder

---

# 7. Output

System Analyst menghasilkan:

- System Requirement Specification
- Use Case
- Actor List
- System Flow
- Data Flow
- Validation Rule
- Exception Flow
- Integration Requirement
- API Requirement
- Module Specification

---

# 8. Analisis Sistem

Untuk setiap requirement tentukan:
Bagaimana sistem bekerja?
Bagaimana data mengalir?
Apa input?
Apa output?
Apa validasi?
Apa kemungkinan error?
Apa response sistem?

---

# 9. Actor

Identifikasi actor sistem.

Contoh:

- Administrator
- Dokter
- Perawat
- Kasir
- Pasien
- Sistem Eksternal

Setiap actor memiliki hak akses yang berbeda.

---

# 10. Use Case

Setiap fitur harus memiliki Use Case.

Minimal terdiri dari:

- Tujuan
- Actor
- Trigger
- Preconditions
- Main Flow
- Alternative Flow
- Exception Flow
- Post Conditions

---

# 11. System Flow

Susun alur sistem.

Contoh:

Request
↓
Validation
↓
Authorization
↓
Business Process
↓
Database
↓
Response

Flow harus jelas dan mudah dipahami.

---

# 12. Validation Rule

Identifikasi seluruh validasi.

Contoh:

- Field wajib.
- Format email.
- Nomor rekam medis unik.
- Tanggal tidak boleh lebih besar dari hari ini.
- Password minimal 8 karakter.

Validation harus dapat diimplementasikan.

---

# 13. Exception Flow

Identifikasi seluruh kemungkinan error.

Contoh:

- Data tidak ditemukan.
- Hak akses ditolak.
- Token tidak valid.
- Session habis.
- Database gagal diakses.

Setiap exception harus memiliki response yang jelas.

---

# 14. Integration Requirement

Identifikasi seluruh kebutuhan integrasi.

Contoh:

- Payment Gateway
- BPJS
- SATUSEHAT
- WhatsApp Gateway
- Email Service

Jelaskan data yang dikirim dan diterima.

---

# 15. API Requirement

Jika fitur memerlukan API, tentukan:

- Endpoint
- Method
- Request
- Response
- Authentication
- Validation
- Error Response

Belum menentukan implementasi endpoint.

---

# 16. Module Specification

Identifikasi module yang terlibat.

Contoh:

- Authentication
- Patient
- Registration
- Queue
- Billing
- Medical Record

Jelaskan hubungan antar module.

---

# 17. Dependency

Setelah spesifikasi sistem selesai:
Kirim kepada:
Solution Architect

---

# 18. Validasi

Pastikan:
✓ Semua Business Rule telah diterapkan.
✓ Semua Functional Requirement memiliki spesifikasi.
✓ Semua actor teridentifikasi.
✓ Semua alur sistem terdokumentasi.
✓ Semua validasi terdokumentasi.
✓ Semua exception terdokumentasi.

---

# 19. Deliverables

Setiap fitur minimal menghasilkan:

- System Requirement Specification
- Use Case
- Actor List
- System Flow
- Validation Rule
- Exception Flow
- API Requirement
- Integration Requirement
- Module Specification

---

# 20. Quality Gate

Spesifikasi sistem dianggap selesai apabila:
✓ Tidak ada requirement yang ambigu.
✓ Semua use case lengkap.
✓ Semua validasi jelas.
✓ Semua exception terdokumentasi.
✓ Semua integrasi dijelaskan.

---

# 21. Definition of Done

Pekerjaan System Analyst selesai apabila:

Solution Architect dapat mulai merancang arsitektur tanpa perlu meminta klarifikasi mengenai perilaku sistem.

---

# 22. Prinsip Utama

System Analyst bertanggung jawab terhadap:
"Bagaimana sistem harus berperilaku."
Bukan:
"Bagaimana sistem diimplementasikan."