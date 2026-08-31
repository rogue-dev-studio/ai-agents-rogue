# HR technical interview — reference

## Backend rubrik (1–5)

| Dimensi | 1 | 3 | 5 |
|---------|---|---|---|
| API design | Tidak RESTful | Cukup, gap auth | Lengkap + edge cases |
| Data modeling | Salah relasi | Normalisasi OK | Index + trade-off jelas |
| Code quality | Tidak jalan | Jalan, kurang test | Bersih + error handling |
| Security awareness | Tidak tahu | Validasi dasar | Authz, injection aware |
| Komunikasi teknis | Kabur | Cukup jelas | Struktur + trade-off |

## Frontend rubrik (1–5)

| Dimensi | Wajib mid |
|---------|-----------|
| JavaScript/TS fundamentals | ✓ |
| Framework idioms | ✓ |
| UI states (loading/error/empty) | ✓ |
| CSS layout responsif | ✓ |
| a11y dasar | nice |
| Performance awareness | nice |

## Soal contoh — Backend

**API design:** Desain API modul pesanan: create, list (pagination), detail, cancel. Status HTTP, validasi, error envelope.

**Database:** Tabel `orders`, `order_items`, `products`. Query order terbaru per user tanpa N+1. Kapan index `(user_id, created_at)`?

**Live coding:** Service hitung total order + diskon persen; throw jika item kosong. Pseudo-code boleh jika stack tidak familiar.

## Soal contoh — Frontend

**Komponen:** List produk dari API — loading, error, empty, load more. Sebutkan state yang dibutuhkan.

**Debugging:** Komponen re-fetch infinite loop — penyebab dan fix.

## Take-home brief (backend)

- Mini API: auth + CRUD satu resource, pagination, 3+ unit test
- README: cara jalan, asumsi, trade-off
- Batas: 3 jam efektif (beri 4–5 hari kalender)

**Rubrik take-home:** struktur, test, security dasar, README, tidak over-engineer → detail `code-review`.

## Lembar skor (template)

```markdown
| Kandidat | ID internal | Role | Tanggal |
|----------|-------------|------|---------|

| Dimensi | Skor 1–5 | Catatan bukti |
|---------|----------|---------------|
| ... | | |

| Rekomendasi | advance / clarify / reject-for-this-role |
| Pewawancara | |
```

## PHP / Laravel track (mid)

Tambahan soal jika JD PHP:

- Middleware auth vs policy/gate — kapan mana?
- Eloquent N+1 — cara deteksi dan fix
- Migration vs seeder — rollback aman
- Validasi Form Request vs controller
- Queue/job untuk task berat (email, export)

Jujur gap stack: produksi Yii vs belajar Laravel — nilai adaptasi, bukan hanya label framework.
