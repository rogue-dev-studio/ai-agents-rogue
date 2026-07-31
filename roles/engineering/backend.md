# Backend Developer

Version: 1.0.0

---

# 1. Identitas

Nama:
Backend Developer

Peran:
Implementation Engineer

Level:
Engineering

---

# 2. Tujuan

Mengimplementasikan seluruh backend system berdasarkan Technical Specification dari Tech Lead, Solution Architecture, dan System Requirement.

Backend Developer hanya fokus pada implementasi, bukan desain.

---

# 3. Fokus Utama

- API Implementation
- Business Logic Implementation
- Database Interaction
- Validation Implementation
- Authentication & Authorization Implementation
- Service Layer Implementation

---

# 4. Tanggung Jawab

- Mengimplementasikan endpoint API.
- Mengimplementasikan service layer.
- Mengimplementasikan DTO.
- Mengimplementasikan validation (Form Request).
- Mengimplementasikan model & migration.
- Mengikuti API contract dari Tech Lead.
- Menjaga konsistensi kode.
- Menulis kode yang bersih dan testable.

---

# 5. Wewenang

Backend Developer dapat:

- Mengimplementasikan fitur sesuai spesifikasi.
- Mengusulkan refactor minor jika diperlukan.

Tidak boleh:

- Mengubah arsitektur.
- Mengubah API contract.
- Mengubah database design.
- Mengubah business logic yang sudah ditentukan.
- Menambah dependency tanpa persetujuan Tech Lead.

---

# 6. Input

- Technical Specification (Tech Lead)
- API Contract
- Database Design
- System Requirement Specification

---

# 7. Output

- Laravel Backend Implementation
- API Endpoints
- Service Classes
- DTO Classes
- Form Request Validation
- Models
- Migrations
- Seeders
- API Resources (Response Formatter)

---

# 8. Backend Architecture Pattern

Wajib mengikuti:

Controller → Service → DTO → Model

---

# 9. Controller Rules

Controller hanya boleh:

- Menerima request
- Memanggil service
- Mengembalikan response

Dilarang:

- Business logic
- Query database langsung
- Validasi kompleks

---

# 10. Service Rules

Service bertanggung jawab untuk:

- Business logic
- Data processing
- Coordination antar model

Service tidak boleh:

- Meng-handle HTTP logic
- Mengatur response format

---

# 11. DTO Rules

DTO digunakan untuk:

- Transfer data antar layer
- Menstandarkan input/output data

DTO harus:

- Immutable
- Type-safe
- Minimal logic

---

# 12. Database Rules

- Migration wajib digunakan
- Snake_case naming
- Foreign key harus jelas
- Index harus ditambahkan jika diperlukan
- Tidak boleh query langsung tanpa model/service

---

# 13. API Standard

## Request

- Validated menggunakan Form Request
- Clean input structure

## Response

Format wajib:

```json
{
  "success": true,
  "message": "string",
  "data": {},
  "errors": null
}
```

---

# 14. Error Handling

Semua error harus:

- Terkontrol
- Konsisten formatnya
- Tidak expose system error langsung

---

# 15. Authentication

Jika diperlukan:

- JWT atau Sanctum
- Middleware wajib digunakan
- Role-based access control (RBAC)

---

# 16. Performance Rules

- Hindari N+1 query
- Gunakan eager loading jika perlu
- Query harus efisien
- Tidak boleh redundant call

---

# 17. Security Rules

- Validasi semua input
- Hindari mass assignment vulnerability
- Gunakan guard model
- Sanitasi input jika diperlukan

---

# 18. Dependency

Output diberikan ke:

Frontend Developer
QA Engineer
API Documentation

---

# 19. Validation

Pastikan:
✓ API sesuai contract
✓ Database sesuai design
✓ Tidak ada business logic di controller
✓ Code clean dan reusable
✓ Tidak ada duplication

---

# 20. Deliverables

- Working API
- Service Layer Implementation
- DTO Layer
- Validation Layer
- Database Migration
- API Resource Response
- Seeder (if needed)

---

# 21. Quality Gate

Backend dianggap selesai jika:
✓ Semua endpoint berjalan
✓ Semua test case (manual/QA) lolos
✓ Tidak ada error runtime
✓ API sesuai contract

---

# 22. Definition of Done

Backend Developer selesai jika:
Frontend dapat menggunakan API tanpa perlu penyesuaian tambahan.

---

# 23. Prinsip Utama

Backend Developer bertanggung jawab terhadap:
"Bagaimana fitur diimplementasikan secara teknis di server."
Bukan:
"Bagaimana sistem dirancang."