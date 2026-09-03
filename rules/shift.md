# Shift Rules (Continuous Dev Shift)

Version: 0.3.0

Hard constraints saat skill **`continuous-dev-shift`** atau command **`/dev-shift`** aktif.

## Must always

- Baca `docs/shift/current.md` sebelum tick; update setelah tick
- **Satu prompt user = shift aktif sampai `ends_at`** — lanjut otomatis tanpa prompt baru per tick
- **Multi-tick per turn:** jalankan banyak tick berturut-turut sebelum reply jika waktu masih ada
- **Shift berdurama (>45m):** arm skill host **`loop`** sebelum turn selesai jika `ends_at` belum tiba
- Auto-pick task hanya dari backlog terindeks, roadmap, audit findings, atau QA/review terbuka — catat `pick_reason`
- Tulis impact ke `docs/planning/impact-log.md` setiap tick
- **Setiap tick:** QA (`agentic-qe`) + code review (`code-review`)
- **UI tick atau shift maintenance:** UI/UX gate (`ui-ux-design`) + browser smoke P0 (`browser-automation`) bila web app
- **Shift maintenance:** baseline audit (`maintenance-audit-{date}.md`) + performance smoke (`observability-engineering`)
- Hormati scope modul di manifest; eskalasi jika butuh scope baru material
- Stop shift jika stop rule di skill terpenuhi; tulis shift summary
- **Backlog kosong + waktu sisa:** idle tick (sweep/regression/planning) — jangan `completed` lebih awal
- Backlog path: cek berurutan `docs/tasks/backlog.md` → `docs/planning/backlog*.md` → sprint board

## Maintenance prompt (wajib full stack review)

Jika user menyebut **maintenance aplikasi**, **perawatan**, **audit aplikasi**, **cek aplikasi**, atau setara:

- Set `shift_type`: `maintenance` atau `maintenance+improvement` di manifest
- Jalankan audit legacy: **kode lama**, **fungsi lama**, **tampilan/UX lama**, **konsistensi**, **relevansi produk**, **performa**
- Tick 0 = baseline audit sebelum fix massal
- Finding → `MAINT-xxx` di backlog; prioritaskan P0 sebelum fitur baru
- Tick tidak `done` tanpa sign-off gates (QA, UI/UX jika UI, perf smoke, code review)

## Must never

- Deploy production / commit / push tanpa permintaan user (default shift)
- **Mark manifest `completed` sebelum `ends_at`** (kecuali stop rule eksplisit)
- **Berhenti setelah 1–2 tick** lalu menunggu user mengetik “lanjut” / “eksekusi semua”
- **Shift berdurama tanpa arm `loop`** di turn pertama
- Tanya user “mau lanjut tick berikutnya?” di tengah shift aktif
- Skip dokumentasi tick “karena waktu habis”
- Skip UI/UX atau performance gate saat **maintenance** shift
- Maintenance prompt tapi hanya implement fitur baru tanpa audit modul existing
- Ambil task tanpa TASK-ID / MAINT-ID / issue ref di backlog
- Tiga tick berturut-turut scope creep tanpa SRS/AC ringkas
- Mengabaikan P0 QA/security/UI/perf blocker demi velocity shift
- Menghapus atau menimpa shift log/manifest tanpa summary penutup

## Escalate to user (pause shift)

- Keputusan bisnis mengubah prioritas roadmap material
- Secret/credential hilang
- Blocker sama 3 tick berturut-turut
- Perubahan breaking API/kontrak tanpa konsumen terdokumentasi
- Data loss / migrasi irreversible di environment shared
- Deprecate fitur besar tanpa PO sign-off

## Review triggers

- Auth, RBAC, upload, billing, export massal
- Perubahan schema DB production-facing
- Multi-tick refactor besar (>1 modul)
- Maintenance audit dengan P0 di production path

## Conflict resolution

1. Instruksi eksplisit user (termasuk “stop shift”)
2. `rules/shift.md` (ini)
3. `rules/security.md` > `rules/coding.md` > `rules/ui.md`
4. Skill `continuous-dev-shift`
5. Role Shift Coordinator + PO + PM + UI/UX + QA + Reviewer
