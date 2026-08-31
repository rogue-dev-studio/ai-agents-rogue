# Paket Rekrut Engineer — Template Lengkap

Version: 1.0.0  
Paket: `teams/hr/examples/`  
Skills terkait: `hr-cv-lifecycle`, `hr-psychometric`, `hr-technical-interview`, `code-review`

> **Cara pakai:** salin section yang relevan, sesuaikan stack perusahaan, lalu jalankan screening → psikotest → HR interview → technical interview → offer. Keputusan hire selalu manusia.

---

## 1. Alur rekrutmen (recommended)

```text
1. JD publish → 2. CV screening (hr-cv-lifecycle)
→ 3. Psikotest 60 mnt (hr-psychometric: A+B+C)
→ 4. HR / culture interview (30–45 mnt)
→ 5. Technical interview (60–90 mnt)
→ 6. (Opsional) Take-home / live coding (90 mnt)
→ 7. Final panel + referensi
→ 8. Offer → onboarding (hr-employee-ops)
```

| Tahap | Durasi | Pass criteria (contoh) |
|-------|--------|------------------------|
| CV screening | async | Must-have ≥3/5, tidak ada red flag klaim |
| Psikotest | 60 mnt | Tidak ada red flag integritas; mayoritas dimensi ≥3 |
| HR interview | 45 mnt | Komunikasi ≥4; motivasi & ekspektasi selaras |
| Technical | 90 mnt | Technical ≥3.5/5 rata-rata dimensi wajib |
| Take-home | 2–4 jam | Kode jalan, test ada, README jelas |

---

## 2. Job Description — Backend Engineer (Mid)

### Ringkasan

Membangun dan memelihara REST API, integrasi database, dan layanan backend yang aman dan terukur.

### Must-have

- 2+ tahun pengalaman backend production
- Mahir satu framework: Laravel / Node (Nest/Express) / Go / .NET
- SQL + ORM (PostgreSQL/MySQL)
- Git, code review, unit test dasar
- Pemahaman auth (session/JWT), validasi input, error handling

### Nice-to-have

- Redis, queue, Docker
- CI/CD, observability (log/metric)
- Pengalaman API versioning & pagination

### Tanggung jawab

- Implementasi fitur dari spesifikasi + PR review
- Menulis migration & query efisien (via ORM)
- Kolaborasi dengan frontend & QA

### Yang kami nilai

- Kejujuran tentang scope yang dikerjakan
- Komunikasi blocker lebih awal
- Kode terbaca dan teruji

---

## 3. Job Description — Frontend Engineer (Mid)

### Ringkasan

Membangun UI web responsif, aksesibel, dan terintegrasi dengan API backend.

### Must-have

- 2+ tahun frontend production
- React / Vue / Nuxt / Next (sesuaikan stack)
- TypeScript atau JavaScript modern (ES6+)
- HTML/CSS responsif, state management dasar
- Konsumsi REST API, handling loading/error/empty

### Nice-to-have

- Tailwind / design system
- a11y (ARIA, keyboard nav)
- E2E test (Playwright/Cypress)

### Tanggung jawab

- Implementasi UI dari desain/Figma
- Komponen reusable & performa dasar (lazy load, memo)
- Pairing dengan backend untuk kontrak API

---

## 4. Job Description — Fullstack Engineer (Mid)

Gabungkan must-have backend + frontend di atas, dengan bobot:

- Backend 55% / Frontend 45% (sesuaikan)

Tambahan must-have:

- Satu proyek end-to-end (auth → CRUD → deploy) yang bisa dijelaskan dengan bukti

---

## 5. Matriks screening CV (1–5)

Gunakan skill `hr-cv-lifecycle` atau isi manual:

| Dimensi | Backend | Frontend | Fullstack |
|---------|---------|----------|-----------|
| Must-have stack | Laravel/Node + SQL | React/Vue + TS | Keduanya ada bukti |
| Bukti production | API, skala, error handling | UI live, komponen | E2E project |
| Senioritas | 2–5 thn sesuai level | idem | idem |
| Domain relevan | SaaS/fintech/health dll. | idem | idem |
| Komunikasi (CV) | Bullet terukur | idem | idem |
| Risiko | Klaim tanpa link/repo | idem | idem |

**Rekomendasi:** `advance` / `clarify` / `reject-for-this-role` + alasan per baris.

**Red flag CV (P0):**

- Stack must-have tidak ada sama sekali
- Klaim “lead 20 orang” tanpa konteks di <2 tahun
- Kontradiksi tanggal kerja
- Hanya tutorial/bootcamp tanpa proyek deploy (untuk mid)

---

## 6. Pertanyaan HR / culture interview

### Umum (semua role)

1. Ceritakan proyek paling bangga — peran **Anda** spesifik apa?
2. Konflik teknis dengan rekan — bagaimana diselesaikan?
3. Ekspektasi gaji & notice period?
4. Kenapa tertarik perusahaan/role ini?
5. Pola kerja: remote/hybrid/onsite?

### Engineer-specific

6. Bagaimana Anda belajar stack baru terakhir kali?
7. Bug produksi yang pernah Anda tangani — langkah dan hasil?
8. Code review terburuk/terbaik yang pernah Anda terima?

**Rubrik HR (1–5):** komunikasi, ownership, kolaborasi, growth mindset, culture fit (tanpa SARA).

---

## 7. Technical interview — Backend (90 mnt)

### Struktur

| Blok | Waktu | Isi |
|------|-------|-----|
| Warm-up | 10 mnt | Pengalaman & stack |
| API design | 25 mnt | Desain endpoint CRUD + auth |
| Database | 20 mnt | Schema, index, N+1 |
| Coding | 25 mnt | Fungsi/service kecil (live atau shared editor) |
| Q&A | 10 mnt | Kandidat tanya balik |

### Soal contoh — API design

> Desain API untuk modul "pesanan": create, list (pagination), detail, cancel. Sertakan status HTTP, validasi, dan error envelope.

**Nilai:** REST semantics, idempotency cancel, pagination meta, authz.

### Soal contoh — Database

> Tabel `orders`, `order_items`, `products`. Query order terbaru per user tanpa N+1. Kapan index `(user_id, created_at)`?

### Soal contoh — Live coding

Implementasi service: hitung total order dengan diskon persen, throw jika item kosong. Boleh pseudo-code jika stack tidak familiar.

### Rubrik teknis backend (1–5)

| Dimensi | 1 | 3 | 5 |
|---------|---|---|---|
| API design | Tidak RESTful | Cukup, gap auth | Lengkap + edge cases |
| Data modeling | Salah relasi | Normalisasi OK | Index + trade-off jelas |
| Code quality | Tidak jalan | Jalan, kurang test | Bersih + error handling |
| Security awareness | Tidak tahu | Validasi dasar | Authz, injection aware |
| Komunikasi teknis | Kabur | Cukup jelas | Struktur + trade-off |

**Pass contoh (mid):** rata-rata ≥3.5, tidak ada dimensi wajib di bawah 2.

---

## 8. Technical interview — Frontend (90 mnt)

### Struktur

| Blok | Waktu | Isi |
|------|-------|-----|
| Warm-up | 10 mnt | Portfolio / proyek |
| UI & state | 25 mnt | Komponen + data fetching |
| CSS/responsive | 15 mnt | Layout challenge singkat |
| Debugging | 20 mnt | Bug snippet (useEffect, stale state) |
| a11y/perf | 10 mnt | Diskusi singkat |
| Q&A | 10 mnt | |

### Soal contoh — Komponen

> Buat list produk dari API: loading, error, empty, pagination "load more". Sebutkan state yang dibutuhkan.

### Soal contoh — Debugging

> Komponen re-fetch infinite loop — jelaskan penyebab dan fix.

### Rubrik teknis frontend (1–5)

| Dimensi | Wajib mid |
|---------|-----------|
| JavaScript/TS fundamentals | ✓ |
| Framework idioms | ✓ |
| UI states (loading/error/empty) | ✓ |
| CSS layout responsif | ✓ |
| a11y dasar | nice |
| Performance awareness | nice |

---

## 9. Take-home assignment (opsional)

### Backend

- Mini API: register/login, CRUD satu resource, pagination, 3+ unit test
- README: cara jalan, asumsi, trade-off
- Batas waktu: 3 jam kerja efektif (beri 4–5 hari kalender)

### Frontend

- Halaman list + detail + form dari mock API
- Responsif mobile
- README + cara test manual

**Rubrik take-home:** `code-review` skill — struktur, test, security dasar, README, tidak over-engineer.

---

## 10. Lembar keputusan akhir (panel)

```markdown
| Kandidat | ID internal | Role | Tanggal |
|----------|-------------|------|---------|

| Tahap | Skor / Hasil | Pewawancara | Catatan |
|-------|--------------|-------------|---------|
| CV screening | advance/clarify/reject | | |
| Psikotest | advance/clarify/reject | | |
| HR interview | /5 | | |
| Technical | /5 | | |
| Take-home | /5 | | |

| Keputusan | hire / no-hire / hold |
| Alasan (audit) | |
| Penandatangan | HR | Hiring Manager | Tech Lead |
```

---

## 11. Prompt cepat untuk agent

### Screening

```
Pakai skill hr-cv-lifecycle: review CV ini vs JD Backend Mid (Laravel).
Output screening matrix 1-5 + rekomendasi advance/clarify/reject + alasan.
```

### Psikotest

```
Pakai skill hr-psychometric: buat paket psikotest 60 menit untuk Backend Engineer Mid.
Modul A+B+C, lembar skor pewawancara, disclaimer etis.
```

### Technical

```
Sebagai Tech Lead: jalankan technical interview backend dari engineer-recruitment-pack.md section 7.
Buat rubrik terisi contoh untuk kandidat fiktif "Budi" (skor 4 API, 3 DB, 4 code).
```

---

## 12. Checklist compliance

- [ ] JD tidak diskriminatif (usia/gender/SARA)
- [ ] PII kandidat tidak di-commit ke git
- [ ] Psikotest bukan pengganti psikolog berlisensi
- [ ] Semua tahap punya rubrik & catatan bukti
- [ ] Offer hanya setelah panel setuju
