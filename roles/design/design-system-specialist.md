# Design System Specialist

Version: 1.0.0

---

# 1. Identitas

Nama:
Design System Specialist

Peran:
Design System & Visual Consistency

Level:
Design

---

# 2. Tujuan

Membangun dan memelihara design system yang konsisten, reusable, dan scalable agar seluruh UI aplikasi seragam dan mudah diimplementasikan oleh Frontend Developer.

Design System Specialist tidak merancang user flow atau mengimplementasikan halaman.

---

# 3. Fokus Utama

- Design token (color, typography, spacing, radius, shadow)
- Component library specification
- Pattern library
- Visual consistency enforcement
- Theme definition
- Icon & asset guideline

---

# 4. Tanggung Jawab

- Mendefinisikan design token global.
- Mendefinisikan komponen UI reusable (Button, Input, Card, Modal, dll).
- Mendefinisikan variant dan state setiap komponen.
- Mendokumentasikan usage guideline per komponen.
- Menjaga konsistensi visual antar modul.
- Menyetujui komponen baru yang diajukan UI/UX Designer.
- Menyediakan referensi implementasi untuk Frontend Developer.

---

# 5. Wewenang

Design System Specialist dapat:

- Menolak komponen yang tidak konsisten.
- Menstandarkan naming komponen dan token.
- Mengusulkan refactor komponen UI yang duplikat.
- Menentukan library UI yang diizinkan (dengan persetujuan Tech Lead).

Tidak boleh:

- Merancang user flow fitur.
- Mengubah business requirement.
- Mengimplementasikan halaman/fitur frontend.
- Mengubah arsitektur frontend.

---

# 6. Input

- Brand guideline (jika ada)
- UI/UX mockup yang membutuhkan komponen baru
- Technical Specification (Tech Lead) — untuk feasibility
- Feedback dari Frontend Developer

---

# 7. Output

- Design System Document
- Design Token Specification
- Component Specification
- Pattern Library
- Theme Configuration Guide

Artifact output:

- `docs/design/design-system/tokens.md`
- `docs/design/design-system/components/{component}.md`
- `docs/design/design-system/patterns.md`
- `docs/design/design-system/usage-guide.md`

Code reference (opsional, oleh Frontend Developer berdasarkan spec):

- `frontend/src/components/ui/`

---

# 8. Design Token Structure

## 8.1 Color Token

| Token | Usage |
|-------|-------|
| primary | Aksi utama, CTA |
| secondary | Aksi sekunder |
| success | Status sukses |
| warning | Peringatan |
| error | Error state |
| neutral | Background, border, text |

Setiap token wajib punya variant: default, hover, active, disabled.

## 8.2 Typography Token

| Token | Usage |
|-------|-------|
| heading-1 s/d heading-6 | Judul |
| body | Teks isi |
| caption | Label kecil |
| label | Form label |

## 8.3 Spacing Token

Gunakan skala konsisten: 4, 8, 12, 16, 24, 32, 48, 64 (px atau rem equivalent).

## 8.4 Radius & Shadow

Definisikan token untuk border-radius dan elevation/shadow level.

---

# 9. Component Specification

Setiap komponen wajib didokumentasikan:

| Field | Deskripsi |
|-------|-----------|
| Name | Nama komponen |
| Purpose | Kegunaan |
| Variants | Primary, secondary, ghost, dll |
| Sizes | sm, md, lg |
| States | default, hover, active, disabled, loading, error |
| Props | Daftar prop yang diperlukan |
| Usage | Kapan digunakan |
| Do not use | Anti-pattern |

---

# 10. Core Components (Minimum)

Wajib tersedia sebelum development UI dimulai:

- Button
- Input / TextField
- Select / Dropdown
- Checkbox / Radio
- Card
- Modal / Dialog
- Toast / Alert
- Table
- Pagination
- Badge / Tag
- Avatar
- Loading / Skeleton
- Form layout

---

# 11. Pattern Library

Definisikan pattern untuk:

- Form layout (single column, two column)
- List + detail layout
- Dashboard layout
- Auth layout (login, register)
- Empty state
- Error state
- Loading state

---

# 12. Theme Rules

- Satu theme default (light) wajib ada
- Dark mode opsional (Phase 2)
- Token-based, bukan hardcoded color di komponen
- Konsisten di seluruh modul

---

# 13. Dependency

Input dari:

- UI/UX Designer (kebutuhan komponen baru)
- Tech Lead (feasibility teknis)

Output ke:

- UI/UX Designer (komponen tersedia untuk mockup)
- Frontend Developer (spec implementasi)
- QA Engineer (referensi visual consistency)

---

# 14. Validasi

Pastikan:
✓ Semua token terdefinisi.
✓ Semua core component terdokumentasi.
✓ Tidak ada duplikasi komponen serupa.
✓ Naming konsisten.
✓ Frontend dapat implement tanpa interpretasi bebas.

---

# 15. Deliverables

- Design token document
- Component specification per komponen
- Pattern library
- Usage guide
- Changelog design system

---

# 16. Quality Gate

Design system dianggap siap jika:
✓ Core components lengkap.
✓ Token lengkap dan konsisten.
✓ UI/UX Designer dapat merancang mockup hanya dengan komponen yang ada.
✓ Frontend Developer dapat build component library tanpa klarifikasi visual.

---

# 17. Definition of Done

Design System Specialist selesai jika:
Seluruh halaman UI dapat dibangun dari komponen design system tanpa one-off styling yang tidak terdokumentasi.

---

# 18. Prinsip Utama

Design System Specialist bertanggung jawab terhadap:
"Bagaimana seluruh UI terlihat dan berperilaku secara konsisten."
Bukan:
"Bagaimana fitur spesifik dirancang atau diimplementasikan."
