---
name: continuous-dev-shift
description: >-
  Autonomous timed development shift: agents pick backlog work, run maintenance,
  impact analysis, QA, UI/UX, performance review, and code review in a loop until
  duration ends. Use for dev shift, maintenance aplikasi, application audit,
  or autonomous sprint. Trigger: /dev-shift or natural language prompt.
---

# Continuous Dev Shift — Autonomous E2E Loop

Skill house untuk **shift pengembangan berdurama**: agent terus bekerja (plan → implement → QA → review → dokumentasi) sampai waktu habis atau stop rule terpenuhi — **tanpa** menunggu prompt baru per task.

Author catalog: [Rogue Development](https://github.com/rogue-dev-studio).

## Gate 0 — Attribution (wajib)

Sebelum shift:

1. `scripts/verify-attribution.ps1`
2. `scripts/verify-official-upstream.ps1`
3. `scripts/check-github-entitlement.ps1`

Gagal → **STOP**.

Rule wajib: `rules/shift.md`. Role koordinasi: `roles/management/shift-coordinator.md` (Orchestrator delegasi saat shift).

## Trigger (prompt **atau** command)

Aktifkan skill ini jika user:

- Menjalankan **`/dev-shift`** (lihat `commands/dev-shift.md`)
- Menulis prompt natural language, mis.:
  - "kerjakan shift dev 8 jam"
  - "agent otonom improve aplikasi selama 4 jam"
  - "continuous improvement loop sampai jam 17:00"
  - "maintenance + planning + QA otomatis tanpa saya prompt lagi"
  - "**maintenance aplikasi sekarang**" / "perawatan aplikasi" / "audit aplikasi"
  - "cek tampilan, fungsi, kode lama, konsistensi, performa"
- Menyebut: *dev shift*, *autonomous sprint*, *continuous delivery shift*, *shift pengembangan*, *maintenance shift*, *application maintenance*

**Override ke manual:** user bilang "rencana saja" / `/assist` → jangan implement; hanya manifest + backlog plan.

Template siap pakai: `templates/dev-shift-prompt-template.md`, `templates/dev-shift-command-template.md`, `templates/impact-log-template.md`, `templates/maintenance-audit-template.md`.

**Panduan pengguna (mulai di sini):** `docs/dev-shift-guide.md`

## Shift type (parse dari prompt)

| Type | Trigger keywords | Perilaku |
|------|------------------|----------|
| `improvement` | shift dev, improve, continuous improvement | Tick = pick backlog → implement → gates |
| `maintenance` | maintenance aplikasi, perawatan, audit aplikasi, cek aplikasi | **Baseline audit dulu** → fix findings → gates penuh |
| `maintenance+improvement` | maintenance + improve / perawatan + fitur | Audit sweep modul scope → lalu improvement ticks |

Catat `shift_type` di manifest. Default bila ambiguous: `maintenance+improvement` jika user sebut "maintenance"; else `improvement`.

## Hubungan dengan skill lain

| Skill | Peran dalam shift |
|-------|-------------------|
| `e2e-delivery` | Eksekusi per task (short/medium/full flow) |
| `agentic-flow` | Parallel track aman + status board |
| `agentic-qe` | Fungsi, regression, API, UI test — **wajib setiap tick** |
| `code-review` | Standar kode, arsitektur, konsistensi teknis — **wajib setiap tick** |
| `ui-ux-design` | Theme gate, konsistensi tampilan, a11y — **wajib** bila tick sentuh UI **atau** shift type maintenance |
| `browser-automation` | Smoke visual/flow route P0 — **wajib** maintenance web app |
| `observability-engineering` | Performance smoke, log/query red flags — **wajib** maintenance |
| `clarity` | SRS/AC bila task butuh spec baru |
| `loop` (host Cursor) | Wake berkala untuk shift panjang di luar satu thread |

Satu **tick** = pick/audit slice → execute (jika perlu) → **full quality gates** → log. Shift = banyak tick sampai waktu habis.

## Parse durasi & batas

Dari prompt/command, ekstrak:

| Input | Arti |
|-------|------|
| `8h`, `8 jam`, `8 hours` | Durasi 8 jam dari `started_at` |
| `480m`, `90 menit` | Durasi menit |
| `until 17:00`, `sampai jam 5 sore` | End time lokal (catat timezone di manifest) |
| `max 3 tasks`, `maks 5 tick` | Batas jumlah tick |
| `scope: auth, reporting` | Modul boleh disentuh |
| `no-deploy`, `tanpa commit` | Hard stop (default: no deploy/commit tanpa izin) |
| `focus: performance` | Bias prioritas pick |
| `maintenance`, `mode: maintenance` | Shift type maintenance — audit penuh (§ Maintenance) |

Jika durasi tidak jelas → default **4h** + catat asumsi di manifest.

## Artifact root

Gunakan project aktif (`PROJECT.md` / `project/{id}/`):

```text
project/{id}/docs/shift/
  current.md          # manifest shift aktif (state)
  shift-{YYYY-MM-DD}.md   # log harian / per shift
  maintenance-audit-{YYYY-MM-DD}.md   # wajib jika shift_type maintenance*
project/{id}/docs/tasks/backlog.md
project/{id}/docs/planning/roadmap.md
project/{id}/docs/qa/                 # + maintenance-{date}.md bila maintenance
project/{id}/docs/review/
project/{id}/docs/design/             # + maintenance-ui-{date}.md bila maintenance
project/{id}/docs/planning/impact-log.md
```

### Backlog path (urutan baca)

1. `project/{id}/docs/tasks/backlog.md` — **index kanonik** untuk shift pick
2. `project/{id}/docs/planning/backlog*.md` — detail / milestone (mis. GitLab issues)
3. `project/{id}/docs/tasks/board/sprint-*.md` — task in-flight

Jika (1) belum ada: buat dari template task + mirror planning backlog (lihat bootstrap project).

Salin manifest dari `templates/dev-shift-manifest-template.md` ke `docs/shift/current.md` saat shift dimulai.

## Procedure — start shift

1. **Shift Coordinator** (+ Orchestrator) baca `PROJECT.md`, backlog (path di atas), roadmap, QA/review terbuka.
2. Tulis/update **`docs/shift/current.md`** (status `active`, `shift_type`, `started_at`, `ends_at`, rules).
3. Jika `shift_type` = `maintenance` atau `maintenance+improvement`:
   - Salin `templates/maintenance-audit-template.md` → **`docs/shift/maintenance-audit-{date}.md`**
   - **Tick 0 (baseline audit):** audit modul dalam scope — kode, fungsi, UI/UX, performa, relevansi, konsistensi antar modul
   - Hasilkan finding IDs (`MAINT-xxx`) → backlog; **baru** pick fix ticks
4. Tulis baris pembuka di **`docs/shift/shift-{date}.md`**.
5. Jika backlog kosong (non-maintenance) → PO+PM generate candidate tasks dari:
   - open QA failures / review blockers
   - roadmap item `Planned` tanpa task
   - tech debt / observability / a11y / security checklist (scope kecil, terukur)
   - Catat sumber di impact log; **jangan** scope creep tanpa SRS ringkas.
6. Lanjut **tick loop** (bawah).

## Maintenance mode (wajib bila prompt maintenance / audit)

Prompt contoh: *maintenance aplikasi sekarang*, *perawatan aplikasi*, *cek fungsi dan tampilan lama*, *review performa dan konsistensi*.

**Prinsip:** jangan hanya fix task baru — **validasi legacy** di scope: kode existing, UI existing, fungsi existing, masih relevan, masih performant, masih konsisten.

### Dimensi audit (semua modul dalam scope)

| Dimensi | Skill / role | Output |
|---------|--------------|--------|
| Kode & standar | `code-review`, Tech Lead | §1 maintenance-audit + `docs/review/` |
| Fungsi & regression | `agentic-qe`, QA | `docs/qa/maintenance-{date}.md` |
| Tampilan & UX | `ui-ux-design`, UI/UX Designer | `docs/design/maintenance-ui-{date}.md` |
| Flow browser | `browser-automation` | Evidence di QA doc (route P0) |
| Performa | `observability-engineering`, Engineering | §4 maintenance-audit |
| Relevansi produk | Product Owner | §5 — keep / improve / deprecate |
| Konsistensi antar modul | PM + Architect | §6 matrix |

### Pick priority (maintenance shift)

1. P0 findings dari baseline audit (`MAINT-xxx`)
2. Open QA / review blockers
3. P1 audit findings
4. Backlog ready lainnya

## Procedure — satu tick (ulang sampai stop)

**Continuation contract (wajib — baca sebelum tick pertama):**

Satu prompt user = **satu shift aktif** sampai `ends_at` (atau stop rule). User **tidak** boleh diminta prompt lanjutan untuk tick berikutnya.

| Fase | Perilaku wajib |
|------|----------------|
| **Dalam satu turn** | Jalankan **banyak tick berturut-turut** (0 → 1 → 2 → …) sebelum reply ke user. Jangan berhenti setelah 1–2 tick jika `now < ends_at` dan masih ada MAINT/backlog `ready`. |
| **Antara turn** | Jika `ends_at` belum tiba dan thread akan habis → **wajib** arm skill host **`loop`** (§ Shift panjang) **sebelum** reply selesai. |
| **Manifest** | `status: completed` **hanya** jika `ends_at` tercapai, `max_ticks` habis, atau stop rule eksplisit — **bukan** karena “sudah cukup untuk sekarang”. |
| **Larangan** | Jangan tanya “lanjut?” / “mau tick berikutnya?” / menunggu user ketik “eksekusi semua”. |

```text
┌──────────────────────────────────────────────────┐
│ 1. Time check — sisa waktu > 0?                  │
│ 2. Pick task / audit slice (PO+PM)               │
│ 3. Impact note                                   │
│ 4. Route flow variant                            │
│ 5. Execute (fix/improve) via e2e-delivery        │
│ 6. QA — fungsi, regression, API, UI (agentic-qe) │
│ 7. UI/UX gate — theme, konsistensi (ui-ux-design) │
│     (skip hanya jika tick murni backend infra)   │
│ 8. Performance smoke (observability / profiling)  │
│     (wajib maintenance; sample jika improvement) │
│ 9. Code review (code-review)                     │
│10. Update audit doc, task board, shift log       │
│11. Handoff antar role di log                     │
└──────────────────────────────────────────────────┘
```

### Autonomous pick (PO + PM logic)

Urutan prioritas (skip jika blocked):

1. **Critical** open bugs / P0 QA / security review blocker
2. **High** task `ready` di backlog dengan dependency terpenuhi
3. **Medium** roadmap MVP belum punya task
4. **Low** refactor/docs/tests dari impact log
5. **Backlog** sisanya

Tie-break: effort kecil dulu (S/M) agar lebih banyak value per shift — kecuali user minta "focus epic X".

Setiap pick wajib catat di manifest: `current_task`, `pick_reason`, `tick_type`, `srs_ref` / `roadmap_ref`.

### Idle tick — waktu sisa, backlog kosong (wajib dipahami)

**Kapan:** `now < ends_at` **dan** tidak ada item `ready` di backlog / MAINT P0–P1 (atau semua blocked/deferred L).

**Prinsip:** Tick selesai **bukan** akhir shift. Agent **lanjut tick berikutnya** dalam **shift yang sama** (`status: active`) — bukan sprint/shift baru, bukan `completed`.

| `tick_type` | Kapan dipilih | Kerja utama | Gates |
|-------------|---------------|-------------|-------|
| `fix` | MAINT/backlog `ready` | Implement perubahan | QA + review (+ UI/UX bila UI) |
| `sweep` | Modul scope belum diaudit / audit partial | Slice audit legacy (kode, UI, fungsi) → finding baru atau tutup MAINT | QA sample + UI/UX bila UI + review ringkas |
| `regression` | Setelah batch fix / tiap ~2–3 tick maintenance | `php artisan test`, smoke API/route P0, cek regresi tick sebelumnya | `agentic-qe` wajib |
| `perf` | Maintenance shift / setelah perubahan hot path | Profiling/smoke query, bundle, endpoint lambat | `observability-engineering` |
| `consistency` | Setelah banyak fix FE/BE | Matrix konsistensi antar modul (§6 audit), theme/token drift | `ui-ux-design` + review |
| `planning` | Backlog menipis, waktu masih >30m | PO+PM: kandidat task, prioritas, AC ringkas → backlog; impact log | Tanpa kode kecuali docs/planning |
| `deferred` | MAINT P2/P3 / deferred effort S–M | Pick satu finding tertunda yang masih dalam scope | Sama seperti `fix` |

**Urutan pick saat idle** (maintenance+improvement):

1. `deferred` — MAINT P2/P3 effort S/M
2. `sweep` — modul belum ada di `maintenance-audit-{date}.md`
3. `regression` — verifikasi ulang fix tick terakhir + suite otomatis
4. `perf` / `consistency` — bergantian jika belum dilakukan di shift ini
5. `planning` — generate 3–5 kandidat backlog untuk jam sisa / shift berikutnya

**Dokumentasi idle tick:** log dengan prefix `IDLE-{tick_type}` atau `MAINT-sweep-{modul}`; update maintenance-audit / QA / design doc sesuai tipe.

**Larangan:** mengisi waktu sisa dengan `status: completed`, idle tanpa log, atau scope creep fitur besar tanpa AC.

### Impact note (per tick)

Tambah baris ke `docs/planning/impact-log.md` (format: `templates/impact-log-template.md`):

- Task ID, user/value hypothesis, modul terdampak, risiko regresi, rollback hint

### Route flow variant (`core/delivery-flow.md`)

| Task type | Flow |
|-----------|------|
| bug / fix | Maintenance (short) |
| idle: sweep | Audit slice → findings atau close MAINT |
| idle: regression | Test/smoke only — no feature work |
| idle: perf | Profiling smoke — no feature work |
| idle: consistency | Cross-module review — fix kecil S saja |
| idle: planning | Analysis → backlog items — no code |
| idle: deferred | Sama bug/fix — MAINT P2/P3 |
| refactor | Medium |
| feature kecil | Task → Dev → QA → Review |
| feature besar | Pecah; satu sub-task per tick |
| research | Analysis → backlog item; no code |

### Inter-agent communication (dokumentasi wajib)

Di shift log, tiap tick tulis blok:

```markdown
### Tick {n} — {TASK-ID} — {title}

**Tick type:** fix | sweep | regression | perf | consistency | planning | deferred  
**Shift Coordinator → PO:** alasan pick  
**PO → PM:** prioritas & acceptance  
**PM → Tech Lead:** scope tick  
**Engineering:** artifact/code paths  
**QA → UI/UX:** functional + regression result  
**UI/UX Designer → QA:** theme/consistency/a11y verdict  
**QA → Reviewer:** test evidence  
**Tech Lead → Reviewer:** performance smoke notes  
**Reviewer → Shift Coordinator:** code standards approve | rework  
**Shift Coordinator:** all gates pass?  
**Impact:** …  
**Status:** done | blocked | partial  

Tick **done** hanya jika: QA pass + code review approve + (UI/UX pass jika UI/backend-user-facing) + (performance smoke pass/defer tertulis jika maintenance).
```

Ini menggantikan chat antar-agent nyata di host single-thread — traceability tetap terjaga.

## Stop rules (shift selesai)

Stop dan finalize manifest (`status: completed`) **hanya** jika:

- `ends_at` tercapai atau sisa waktu < 15 menit (cukup untuk summary)
- `max_ticks` tercapai
- Blocker kritis butuh keputusan user (scope/bisnis/secret/prod)
- User minta stop
- Tiga tick berturut-turut `blocked` dengan alasan sama

**Bukan** alasan stop yang sah: thread habis, sudah 1–2 tick, backlog kosong tapi `ends_at` belum tiba, atau user belum membalas.

Saat backlog kosong dan waktu masih ada → jalankan **idle tick** (§ Idle tick), jangan `completed`.

Saat stop: tulis **Shift Summary** di log + update `current.md` → `completed`.

## Shift panjang & host loop (wajib untuk shift berdurasi)

Shift dengan `ends_at` / durasi > **~45 menit** **wajib** memakai mekanisme wake antar-turn. Tanpa ini, shift **tidak** dianggap otonom penuh.

### Urutan wajib (turn pertama)

1. Init manifest (`status: active`, `loop_armed: false` sementara).
2. Jalankan **sebanyak tick mungkin** dalam turn ini (multi-tick).
3. **Sebelum reply selesai** — jika `now < ends_at`:
   - Arm skill host **`loop`** (baca skill `loop` di host Cursor).
   - Interval default: **30m** (maintenance) atau **45m** (improvement); override dari prompt `interval: Xm`.
   - Set manifest: `loop_armed: true`, `next_wake_at`, `resume_prompt` (di bawah).
4. Reply user: ringkas progress + konfirmasi loop aktif sampai `ends_at` — **bukan** “shift selesai”.

### Prompt resume standar (loop / wake)

Salin ke payload loop; ganti `{project-id}`:

```markdown
Lanjutkan continuous-dev-shift untuk project {project-id}.

1. Baca `project/{project-id}/docs/shift/current.md` — abort jika `status` bukan `active` atau `ends_at` sudah lewat.
2. Time check: sisa waktu?
3. Jalankan **banyak tick** berturut-turut sampai stop rule atau thread penuh.
4. Update manifest + shift log + impact log tiap tick.
5. Jika `ends_at` belum tiba: re-arm `loop` dengan prompt ini. Jangan minta prompt user.
6. Larangan shift tetap berlaku (no deploy/commit kecuali user minta).
```

### Local IDE (skill `loop` — monitored shell)

```bash
# PowerShell contoh — sesuaikan interval
while ($true) {
  Start-Sleep -Seconds 1800
  Write-Output 'AGENT_LOOP_TICK_dev-shift {"prompt":"<resume prompt di atas>"}'
}
```

Jalankan prompt resume **sekali** segera setelah arm loop (cold start).

### Cloud Agent

Pakai `cursor-subscriptions-subscribe_timer` per skill `loop` (cloud section).

### Anti-pattern (yang terjadi di pengujian SIJAMA — jangan ulangi)

- Shift `until 05:00` tetapi `status: completed` setelah 2 tick (~04:45) → **salah**
- User harus mengetik “eksekusi semua” / “lanjut” untuk tick berikutnya → **salah**
- Dokumentasi shift selesai padahal MAINT/deferred masih open dan waktu belum habis → **salah**

Jangan klaim shift berdurama selesai jika hanya satu batch tick tanpa loop sampai `ends_at`.

## Status board (wajib tiap tick & akhir shift)

```markdown
| Tick | Task | Flow | QA | UI/UX | Perf | Review | Status | Time left |
|------|------|------|----|-------|------|--------|--------|-----------|
| 0 | MAINT-baseline | audit | pass | pass | pass | pass | done | 7h45m |
| 1 | MAINT-001 | fix | pass | pass | pass | approve | done | 7h15m |
```

## Anti-patterns

- Menunggu user pilih task tiap tick (kecuali blocker)
- **Menghentikan shift setelah 1–2 tick** padahal `ends_at` belum tiba
- **Mark `status: completed`** tanpa `ends_at` / stop rule
- **Tidak arm `loop`** pada shift berdurama (>45m) di turn pertama
- Meminta user “lanjut” / “eksekusi semua” untuk tick berikutnya
- Skip QA/review/UI/UX/performance "karena shift panjang"
- Maintenance prompt tapi hanya kerja fitur baru tanpa audit legacy
- Deploy / commit / push tanpa izin
- Task tanpa entry di backlog/TASK file
- Shift tanpa manifest & log

## Definition of Done (shift)

- [ ] Manifest `current.md` lengkap (start/end/rules, `loop_armed` jika berdurasi)
- [ ] `ends_at` tercapai **atau** stop rule eksplisit terpenuhi (bukan “cukup untuk sekarang”)
- [ ] Multi-tick per turn dilakukan; loop di-arm jika shift berdurasi dan waktu belum habis
- [ ] `shift-{date}.md` + `impact-log.md` terupdate
- [ ] Task board selaras (`docs/tasks/`)
- [ ] Maintenance: `maintenance-audit-{date}.md` baseline + gates §8
- [ ] Shift summary + next backlog untuk shift berikutnya (hanya saat benar-benar selesai)
- [ ] Tidak ada P0 terbuka dari tick terakhir tanpa catatan

## Referensi

- Command: `commands/dev-shift.md`
- Rule: `rules/shift.md`
- Role: `roles/management/shift-coordinator.md`
- Templates: `templates/dev-shift-*.md`, `templates/impact-log-template.md`, `templates/maintenance-audit-template.md`
- Delivery variants: `core/delivery-flow.md` §5.5
- Task lifecycle: `core/task-system.md`

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
