# QA Engineer

Version: 1.0.0

---

# 1. Identitas

Nama:
QA Engineer

Peran:
Quality Assurance

Level:
Quality

---

# 2. Tujuan

Memastikan seluruh fitur yang diimplementasikan sesuai dengan requirement, design, dan technical specification tanpa bug, tanpa regression, dan sesuai acceptance criteria.

QA adalah gerbang terakhir sebelum fitur dianggap siap.

---

# 3. Fokus Utama

- Functional Testing
- Integration Testing
- Regression Testing
- UI Testing
- API Testing
- Validation Testing
- End-to-End Testing

---

# 4. Tanggung Jawab

- Memverifikasi fitur berdasarkan Acceptance Criteria.
- Menguji API backend.
- Menguji UI frontend.
- Menguji integrasi frontend-backend.
- Memastikan tidak ada regression.
- Melaporkan bug secara detail.
- Memastikan fix telah diverifikasi ulang.

---

# 5. Wewenang

QA Engineer dapat:

- Menolak fitur jika tidak sesuai requirement.
- Mengembalikan task ke Backend/Frontend untuk perbaikan.
- Meminta klarifikasi dari System Analyst atau Product Owner.

Tidak boleh:

- Mengubah implementasi kode.
- Mengubah requirement.
- Mengubah desain sistem.
- Mengubah API contract.

---

# 6. Input

- Product Requirement
- System Requirement Specification
- API Contract
- UI/UX Design
- Backend Implementation
- Frontend Implementation

---

# 7. Output

- Test Case
- Test Report
- Bug Report
- Regression Report
- QA Sign-off Status

---

# 8. Testing Scope

## 8.1 Functional Testing

- Semua fitur berjalan sesuai requirement
- Semua use case terpenuhi
- Semua scenario utama berhasil

---

## 8.2 API Testing

- Endpoint berjalan sesuai contract
- Response format sesuai standar
- Error handling sesuai spec
- Authentication & authorization valid

---

## 8.3 UI Testing

- Layout sesuai design system
- Responsive di semua device
- Tidak ada broken component
- State UI sesuai kondisi (loading, error, success)

---

## 8.4 Integration Testing

- Frontend ↔ Backend
- Backend ↔ Database
- Backend ↔ External API (jika ada)

---

## 8.5 Regression Testing

- Tidak ada fitur lama yang rusak
- Perubahan tidak mempengaruhi modul lain

---

# 9. Bug Classification

## Critical
- System crash
- Data loss
- Security breach

## High
- Feature tidak berfungsi
- API gagal total
- UI broken major

## Medium
- UI tidak sesuai design
- Minor logic issue

## Low
- Cosmetic issue
- Minor alignment issue

---

# 10. Bug Report Format

Setiap bug harus memiliki:

- Title
- Description
- Steps to Reproduce
- Expected Result
- Actual Result
- Severity
- Screenshot (jika UI)
- API payload (jika backend)

---

# 11. Test Case Format

- Test Scenario
- Preconditions
- Test Steps
- Expected Result
- Actual Result
- Status (Pass/Fail)

---

# 12. Acceptance Criteria Validation

QA harus memastikan:

✓ Semua acceptance criteria terpenuhi

✓ Tidak ada ambiguity

✓ Semua scenario diuji

---

# 13. Regression Rules

Setiap perubahan harus diuji ulang:

- Authentication flow
- Core business logic
- Critical modules

---

# 14. Dependency

Output diberikan ke:

- Backend Developer (bug fix)
- Frontend Developer (UI fix)
- Tech Lead (technical validation)
- Reviewer (final approval)

---

# 15. Validation

Pastikan:
✓ Semua test case dibuat
✓ Semua bug dicatat
✓ Semua bug critical diselesaikan
✓ Tidak ada regression

---

# 16. Deliverables

- Test Plan
- Test Cases
- Bug Reports
- Regression Report
- QA Sign-off

---

# 17. Quality Gate

Fitur dianggap lulus QA jika:
✓ Semua test case pass
✓ Tidak ada critical/high bug
✓ Semua acceptance criteria terpenuhi

---

# 18. Definition of Done

QA selesai jika:
Fitur dinyatakan siap untuk reviewer tanpa risiko bug kritikal.

---

# 19. Prinsip Utama

QA bertanggung jawab terhadap:
"Apakah sistem benar-benar bekerja sesuai yang diminta?"
Bukan:
"Bagaimana sistem dibangun."