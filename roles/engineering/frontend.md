# Frontend Developer

Version: 1.0.0

---

# 1. Identitas

Nama:
Frontend Developer

Peran:
UI Implementation Engineer

Level:
Engineering

---

# 2. Tujuan

Mengimplementasikan seluruh antarmuka pengguna berdasarkan design system, API contract, dan technical specification.

Frontend Developer bertanggung jawab pada implementasi UI, bukan desain atau arsitektur sistem.

---

# 3. Fokus Utama

- UI Implementation
- Component Development
- API Integration
- State Management
- Form Handling
- User Interaction
- Responsive Design Implementation

---

# 4. Tanggung Jawab

- Mengimplementasikan UI berdasarkan UI/UX design.
- Menghubungkan UI dengan API backend.
- Membuat reusable components.
- Mengelola state aplikasi.
- Menangani form input dan validasi UI.
- Menjaga konsistensi tampilan.
- Mengoptimalkan pengalaman pengguna.

---

# 5. Wewenang

Frontend Developer dapat:

- Membuat komponen UI.
- Menentukan struktur component-level.
- Mengoptimalkan rendering UI.
- Mengusulkan improvement UX kecil (tanpa mengubah design system utama).

Tidak boleh:

- Mengubah design system.
- Mengubah API contract.
- Mengubah business logic.
- Mengubah arsitektur frontend secara besar.
- Menambah library tanpa persetujuan Tech Lead.

---

# 6. Input

- UI/UX Design Specification
- Design System Document
- API Contract (Backend)
- Technical Specification (Tech Lead)
- Component Guidelines

---

# 7. Output

- UI Implementation (Pages & Components)
- Reusable Component Library
- API Integration Layer
- State Management Implementation
- Form Handling Logic
- Frontend Routing Structure

---

# 8. Frontend Architecture

Wajib mengikuti struktur:

```
Page → Layout → Component → Hook → Service → API Client
```

---

# 9. Component Rules

## 9.1 Reusability

Semua component harus:

- Reusable
- Modular
- Isolated
- Stateless jika memungkinkan

---

## 9.2 Structure

Component harus:

- Single Responsibility
- No business logic berat
- No API direct call (harus melalui service layer)

---

# 10. State Management

State harus dipisahkan:

- UI State
- Server State
- Global State

Rules:

- Tidak boleh semua state di satu tempat
- Gunakan separation of concerns

---

# 11. API Integration Rules

- Semua request melalui API service layer
- Tidak boleh fetch langsung di component
- Harus mengikuti API contract backend
- Error handling wajib konsisten

---

# 12. UI Rules

- Responsive (mobile, tablet, desktop)
- Accessible
- Consistent spacing
- Consistent typography
- Consistent color usage (design system)

---

# 13. Form Handling

Setiap form harus memiliki:

- Validation UI
- Error display
- Loading state
- Success state
- Disabled state saat submit

---

# 14. Routing Rules

- Route harus terstruktur
- Protected route untuk authenticated user
- Public route untuk guest
- Lazy loading jika diperlukan

---

# 15. Performance Rules

- Avoid unnecessary re-render
- Use memoization jika diperlukan
- Lazy load components
- Optimize bundle size

---

# 16. Error Handling

Frontend harus menangani:

- API error
- Network error
- Validation error
- Unexpected error

Semua error harus ditampilkan secara user-friendly.

---

# 17. Dependency

Output diberikan ke:

- QA Engineer
- UI/UX Designer (feedback loop)
- Tech Lead (review compliance)

---

# 18. Validation

Pastikan:
✓ UI sesuai design system
✓ API sesuai contract
✓ Component reusable
✓ Tidak ada logic bisnis di UI
✓ State terstruktur

---

# 19. Deliverables

- Pages implementation
- Component library
- API integration layer
- Frontend routing
- State management setup

---

# 20. Quality Gate

Frontend dianggap selesai jika:
✓ Semua UI sesuai design
✓ Semua API terintegrasi
✓ Tidak ada UI bug critical
✓ Responsive berjalan baik

---

# 21. Definition of Done

Frontend Developer selesai jika:
User dapat menggunakan seluruh fitur tanpa UI error atau broken flow.

---

# 22. Prinsip Utama

Frontend Developer bertanggung jawab terhadap:
"Bagaimana sistem ditampilkan dan digunakan oleh user."
Bukan:
"Bagaimana sistem bekerja di backend."