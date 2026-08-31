# Psychometric reference — workplace hiring

## Disclaimer (wajib di setiap paket)

> Assessment ini adalah **alat bantu rekrutmen** untuk memahami pola kerja dan reasoning kandidat. Bukan pengganti psikolog klinis atau tes berlisensi resmi (PAPI, IST, MBTI® resmi, dll.). Keputusan hiring ditandatangani manusia. Hasil tidak boleh dipakai untuk diskriminasi atribut dilindungi.

## Skala penilaian (1–5)

| Skor | Arti |
|------|------|
| 1 | Tidak memenuhi; jawaban kosong/evasif/kontradiktif |
| 2 | Lemah; butuh banyak bimbingan untuk role target |
| 3 | Cukup; bisa diterima dengan coaching |
| 4 | Kuat; selaras dengan kebutuhan role |
| 5 | Sangat kuat; bukti konsisten dan spesifik |

**Jangan** rata-rata jadi satu skor. Beri rekomendasi per dimensi + sintesis naratif.

---

## Modul A — Kognitif (engineer-friendly)

### A1. Pola & logika (5 soal, ~10 mnt)

Contoh:

1. Urutan: `2, 6, 12, 20, 30, ?` → **42** (selisih +4, +6, +8, +10, +12)
2. Jika semua `A` yang mengikuti `B` adalah `C`, dan `X` mengikuti `B`, apakah `X` pasti `C`? → **Tidak** (fallacy; jelaskan)
3. Debug singkat: output loop salah — kandidat jelaskan kemungkinan off-by-one

**Rubrik:** akurasi, cara berpikir (langkah vs tebak), komunikasi penjelasan.

### A2. Numerik dasar (4 soal, ~8 mnt)

Contoh:

- Server 3 instance, masing-masing 40 req/s, 15% overhead → kapasitas efektif?
- Estimasi: 1.200 baris kode, review 8 baris/menit, berapa menit?

**Rubrik:** metode, toleransi estimasi ±20%, unit jelas.

### A3. Bahasa & instruksi (3 soal, ~7 mnt)

- Parafrase requirement ambigu → acceptance criteria 3 bullet
- Identifikasi asumsi tersembunyi dalam brief singkat

---

## Modul B — Gaya kerja (bukan tes berlisensi DISC)

Gunakan skenario pilihan ganda **atau** ranking (A–D). Nilai **preferensi kerja**, bukan “benar/salah”.

### Dimensi (contoh)

| Dimensi | Indikator tinggi | Risiko jika ekstrem |
|---------|------------------|---------------------|
| Detail vs big-picture | Cek edge case sebelum coding | Lambat di prototyping |
| Kolaborasi vs independen | Pairing, dokumentasi | Kurang inisiatif solo |
| Stabilitas vs perubahan | Menikmati refactor/eksperimen | Bosan maintenance |
| Komunikasi proaktif | Update blocker early | Over-communicate |

**5 skenario** (contoh):

1. Deadline besok, test belum ada — apa yang Anda lakukan dulu?
2. PR review menemukan masalah arsitektur besar — respons Anda?
3. Spesifikasi berubah saat sprint berjalan — langkah Anda?
4. Anda tidak setuju dengan keputusan tech lead — bagaimana?
5. Bug produksi malam hari — prioritas Anda?

**Rubrik:** konsistensi jawaban, kesadaran trade-off, selaras dengan kultur tim (user definisikan).

---

## Modul C — Integritas & etika

Format: situasi terbuka (2–3 paragraf respons).

### Skenario

1. Teman tim meminta Anda menutupi bug kecil agar release lancar.
2. Anda menemukan kode yang di-copy tanpa atribusi dari Stack Overflow/repo OSS.
3. Kandidat diminta estimasi; Anda tahu scope belum jelas.

**Rubrik (1–5):**

- Kejujuran & transparansi
- Eskalasi yang tepat
- Balance bisnis vs kualitas
- Tidak menyalahkan orang lain

**Red flag:** menyalahkan, menghindar total, solusi tidak etis tanpa awareness.

---

## Modul D — Kolaborasi & komunikasi (mid+)

### Format wawancara tertulis atau role-play notes

1. Jelaskan fitur teknis ke product manager non-teknis (max 150 kata).
2. Bagaimana Anda memberi feedback pada junior yang PR-nya sering ditolak?
3. Konflik prioritas antara 2 stakeholder — langkah Anda?

**Rubrik:** clarity, empathy, struktur, evidence dari pengalaman nyata.

---

## Modul E — Tekanan & adaptasi (senior/lead)

1. Tiga insiden produksi bersamaan — bagaimana triage?
2. Tim kehilangan 2 engineer — rencana 2 minggu pertama sebagai lead?
3. Tech debt vs fitur revenue — framework keputusan Anda?

**Rubrik:** prioritisasi, komunikasi risiko, delegasi, tidak heroics berlebihan.

---

## Lembar skor pewawancara (template)

```markdown
| Dimensi | Skor 1–5 | Bukti (kutipan jawaban) | Risiko | Pertanyaan lanjutan |
|---------|----------|-------------------------|--------|---------------------|
| Kognitif / reasoning | | | | |
| Gaya kerja | | | | |
| Integritas | | | | |
| Kolaborasi | | | | |
| Adaptasi (jika senior) | | | | |
```

## Rekomendasi akhir

| Hasil | Kriteria contoh |
|-------|-----------------|
| **advance** | Mayoritas dimensi ≥4; tidak ada red flag integritas |
| **clarify** | Campuran 3–4; gap di 1–2 dimensi kritis untuk role |
| **reject-for-this-role** | Red flag integritas; reasoning sangat lemah untuk level; tidak selaras kultur |

Selalu sertakan: **bukan keputusan final** — wawancara teknis & referensi masih wajib.

---

## Mapping role engineer

| Role | Modul default | Bobot teknis di tahap lain |
|------|---------------|----------------------------|
| Frontend | A, B, C, D | UI/JS/CSS, a11y, state |
| Backend | A, B, C, D | API, DB, auth, performance |
| Fullstack | A, B, C, D, E (mid+) | End-to-end, trade-off |
| DevOps/SRE | A, C, D, E | incident, IaC, observability |

Psikotest **tidak mengganti** technical interview — hanya melengkapi.
