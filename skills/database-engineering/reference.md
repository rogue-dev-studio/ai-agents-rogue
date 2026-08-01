# Database Engineering — Reference (Expert)

Companion to `SKILL.md`. Progressive disclosure: consult this document for implementation detail.

## 1. Schema & naming

| Item | Standar |
|------|---------|
| Table | `snake_case`, plural (`users`, `order_items`) |
| Mapping / junction | `snake_case`; boleh sufiks `_mp` / `_map` bila konvensi project memakai itu (`role_permission_mp`) — **konsisten dalam satu project** |
| Column | `snake_case` |
| PK | `id` (bigint/uuid sesuai arsitektur) |
| FK | `{referenced}_id` mengikuti konvensi project |
| Boolean | `is_*` / `has_*` |
| Timestamps | `created_at`, `updated_at`; soft delete: `deleted_at` |
| View | `vw_*` atau `*_v` — satu konvensi per project |
| Function | `fn_*` / schema `app` — satu konvensi per project |
| Trigger | `trg_{table}_{timing}_{event}` (contoh konsep: `trg_orders_ai_audit`) |

Wajib per tabel aplikasi: PK + timestamps (kecuali pivot/mapping murni yang disepakati tanpa timestamps).

## 2. Normalisasi & denormalisasi

- Default: 3NF
- Denormalisasi hanya dengan: alasan performa terukur, sumber kebenaran tunggal, catatan di docs architecture
- Hindari redudansi yang bisa drift

## 3. Relationships (relasi)

- 1:1, 1:N, N:M
- FK **wajib di DB** (bukan hanya di ORM)
- On delete/update: default **restrict**; dokumentasikan cascade / set null
- Setiap FK yang di-join/filter sering → pertimbangkan index (lihat §5)

### 3.1 Mapping / junction / `_mp`

Pakai tabel mapping bila:

- Relasi **N:M** antar entitas
- Pemetaan referensi banyak-ke-banyak (role↔permission, user↔group, dll.)

Wajib:

- Minimal dua FK (+ unique composite pasangan FK)
- Nama jelas: `{a}_{b}` atau `{a}_{b}_mp` sesuai konvensi project
- Index pada tiap FK (dan unique pada pasangan)
- Tidak menyimpan payload transaksi besar di mapping kecuali requirement bilang begitu
- Kolom ekstra di mapping (mis. `is_active`, `assigned_at`) boleh jika bagian dari relasi, bukan business workflow tersembunyi

Jangan:

- Duplikasi mapping yang sama dengan nama berbeda
- Menyimpan array ID di JSON sebagai pengganti mapping tanpa ADR

## 4. Migrations

- Satu tujuan per file
- Selalu **down** yang aman
- Jangan rewrite migration yang sudah di-apply di shared env
- Urutan: parent → child → mapping; drop: mapping/child → parent
- Expand → migrate data → contract untuk breaking change
- Laravel: `Schema` builder diutamakan; raw SQL untuk VIEW/FUNCTION/TRIGGER/index ekspresi + alasan singkat
- Smoke: migrate + rollback

## 5. Index strategy

Buat index jika sering dipakai untuk `WHERE` / `JOIN` / `ORDER BY` / unique bisnis.

Hindari: low-cardinality spekulatif, duplikat PK/unique, urutan composite salah.

| Jenis | Kapan |
|-------|--------|
| B-tree (default) | Equality/range umum |
| Unique | Natural key bisnis |
| Composite | Predikat multi-kolom; lead column paling selektif/sering |
| Partial (PG) | Subset aktif (`WHERE deleted_at IS NULL`) |
| Covering / include (PG) | Hot read yang terukur |

Produksi besar (Phase 3): pertimbangkan `CREATE INDEX CONCURRENTLY`. Phase 1 local: index biasa OK.

## 6. Integrity

- Unique bisnis, CHECK bila stabil, validasi app **dan** DB
- Mapping: unique `(fk_a, fk_b)` untuk cegah duplikat relasi

## 7. Seeders

Diizinkan: master role/permission, menu, referensi generik, user bootstrap non-produksi (termasuk baris mapping master).

Dilarang: data transaksi riil, secret, PII riil di repo.

Idempotent diutamakan.

## 8. Query & performance (wajib dijaga)

**Performance gate** pada setiap perubahan data layer:

1. Path list/detail/join utama tidak mundur ke sequential scan besar tanpa alasan
2. List memakai **pagination** (LIMIT/OFFSET atau keyset)
3. ORM: eager load; larang N+1 di hot path
4. Transaksi pendek; batch besar dipecah; hindari lock panjang
5. Tipe data tepat (`numeric` untuk uang; `timestamptz` bila lintas zona)
6. Hot query: `EXPLAIN (ANALYZE, BUFFERS)` (PG) / `EXPLAIN ANALYZE` (MySQL) sebelum/sesudah tune
7. VIEW kompleks: pastikan tidak dibungkus berulang tanpa materialisasi sadar
8. TRIGGER: hitung biaya per row — jangan trigger berat di tabel write-intensif tanpa bukti

Regresi performa yang diketahui → blocker atau tiket eksplisit, jangan diam-diam merge.

## 9. VIEW

**Pakai VIEW** bila:

- Join/baca berulang yang stabil untuk reporting/read model
- Menyembunyikan kolom sensitif dari role DB tertentu (bersama grants)
- Kontrak baca yang jarang berubah

**Jangan VIEW** bila:

- Menggantikan API/backend untuk business rules yang sering berubah
- Menyembunyikan N+1 / query buruk di app

Aturan:

- Buat/drop di migration (up/down)
- Nama + kolom terdokumentasi singkat
- Prefer non-materialized dulu; **MATERIALIZED VIEW** hanya dengan refresh strategy (cron/job) + index pada MV
- Jangan `SELECT *` di definisi VIEW produksi

## 10. FUNCTION / procedure

**Pakai** bila:

- Kalkulasi/aturan set-based yang jauh lebih efisien di DB
- Operasi atomik multi-tabel yang tidak cocok di app tanpa round-trip berlebih
- Hook yang dipanggil trigger (fungsi trigger)

**Jangan** bila:

- Seluruh domain service dipindah ke PL/pgSQL tanpa batas
- Logic yang harus diuji di unit test app tapi tidak ada jalur tes DB

Aturan:

- Versioned di migration; `CREATE OR REPLACE` hati-hati dengan perubahan signature → drop/create di down/up yang jelas
- `SECURITY INVOKER` default; `SECURITY DEFINER` hanya dengan alasan + search_path ketat
- Tidak menaruh secret di body fungsi
- Privilege execute hanya ke role yang perlu

## 11. TRIGGER

**Pakai** bila:

- Audit trail / timestamp guard yang harus benar meski ada banyak writer
- Menjaga invariant yang tidak boleh dilanggar walau bypass ORM
- Sinkron tipis turunan (dengan dokumentasi)

**Jangan** bila:

- Workflow bisnis panjang (approval multi-step, notifikasi, call HTTP)
- Efek samping tersembunyi tanpa docs (sulit di-debug Backend)

Aturan:

- Satu tanggung jawab per trigger; naming jelas
- Prefer `AFTER` untuk audit; `BEFORE` untuk normalisasi nilai
- Hindari trigger berantai dalam (cascade trigger hell)
- Statement-level vs row-level: pilih sesuai volume
- Wajib: migration up/down + catatan di architecture/ADR
- Uji: insert/update/delete sample memastikan efek + performa masih masuk akal

## 12. PostgreSQL notes

- Extension hanya jika perlu
- JSONB bukan pengganti mapping N:M tanpa ADR
- Partial index untuk subset aktif
- Jangan matikan autovacuum; waspadai bloat setelah mass update/delete

## 13. MySQL / MariaDB notes

- InnoDB; `utf8mb4`
- Trigger/procedure syntax berbeda — tulis dialect sesuai engine project
- Generated columns: hati-hati di down migration

## 14. Security (data layer)

- Parameterized only; least privilege; secret di env
- VIEW/FUNCTION jangan expose kolom sensitif ke role luas
- TRIGGER audit: jangan tulis secret/token ke log table dalam plain text bila bisa dihindari
- Soft-delete sensitif: jejak audit jika domain mewajibkan

## 15. Soft delete & audit

- Soft delete hanya jika perlu restore/history
- Unique + soft delete: partial unique di PG
- `created_by` / `updated_by` hanya jika SRS meminta

## 16. Multi-service

- Satu service satu DB logical; no cross-DB join
- Integrasi via API/event

## 17. Backup & rollback

- Backup note sebelum migrate destruktif di shared env
- Rollback: reverse migration atau forward-fix
- Jangan `down -v` tanpa konfirmasi

## 18. Deliverables checklist

- [ ] Migration (+ down) termasuk VIEW/FUNCTION/TRIGGER/mapping bila dipakai
- [ ] Relasi + mapping/`_mp` + index notes
- [ ] Performance gate (EXPLAIN atau alasan setara untuk hot path)
- [ ] Seeder master (opsional)
- [ ] ERD / `database-design.md` update
- [ ] Risiko & urutan deploy

## 19. Anti-patterns

- Mengubah requirement lewat “tambah kolom saja” tanpa PO/SA
- Cascade delete masif tanpa analisis
- Business workflow kompleks hanya di trigger tanpa ADR
- Mapping duplikat / JSON array ID tanpa desain
- VIEW/`SELECT *` yang merusak performa
- FUNCTION `SECURITY DEFINER` longgar
- Duplicate table “v2” tanpa migrasi data
- File besar di BYTEA/BLOB tanpa keputusan arsitektur
- Mengabaikan regresi performa setelah tambah trigger/index salah
