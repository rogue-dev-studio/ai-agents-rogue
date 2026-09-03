# Dev Shift — Prompt Template

Salin blok di bawah ke chat. Sesuaikan `{...}`. Skill **`continuous-dev-shift`** aktif otomatis dari maksud prompt (tidak perlu `/dev-shift`).

---

---

## Template maintenance aplikasi (full audit + fix)

```markdown
**Maintenance aplikasi** — project {sijama | aktif} **sampai jam {05:00 WIB}** (jangan stop lebih awal).

- Durasi / ends_at: {sampai jam 05:00 WIB}
- Shift type: maintenance+improvement
- Scope: semua modul / {list modul}
- Larangan: tanpa deploy, tanpa commit kecuali saya minta
- **Kontinuitas:** satu prompt ini saja — jangan minta prompt lanjutan; arm `/loop 30m` jika thread habis sebelum ends_at

Wajib:
1. Baseline audit (tick 0): kode lama, fungsi lama, tampilan/UX lama, konsistensi antar modul, relevansi roadmap, performa smoke
2. Dokumentasi: `docs/shift/maintenance-audit-{tanggal}.md`, `docs/qa/maintenance-{tanggal}.md`, `docs/design/maintenance-ui-{tanggal}.md`
3. Setiap tick fix: QA + UI/UX gate + performance smoke + code review — semua pass sebelum done
4. Finding → MAINT-xxx di backlog, prioritaskan P0 dulu
5. **Banyak tick per turn**; `status: completed` hanya setelah ends_at atau stop rule skill
6. **Backlog habis tapi waktu belum habis:** idle tick (sweep audit modul → regression test → planning backlog) — shift tetap `active`

Mulai tick 0 (audit) sekarang. Jangan hentikan shift sampai waktu habis kecuali blocker kritis.
```

---

## Template singkat maintenance

```markdown
Maintenance aplikasi {sampai jam 05:00 WIB}: audit dan perbaiki kode, fungsi, tampilan lama, konsistensi, dan performa. Satu prompt — jangan stop hingga waktu habis; arm loop jika perlu. Dokumentasikan di docs/shift/ + qa + design. Auto-pick MAINT findings.
```

---

## Template dasar (Bahasa Indonesia)

```markdown
Jalankan **continuous dev shift** untuk project aktif.

- Durasi: {8 jam | 4h | sampai jam 17:00 WIB}
- Mode: e2e — agent pilih task sendiri dari backlog/roadmap/QA terbuka
- Scope modul: {semua | auth, laporan, master data}
- Maks tick: {tanpa batas | 5 task}
- Larangan: tanpa deploy, tanpa commit kecuali saya minta

Alur per tick: pick task → impact note → implement → QA → review → update dokumentasi.

Tulis manifest ke `project/{id}/docs/shift/current.md` dan log ke `docs/shift/shift-{tanggal}.md`.
Mulai tick pertama sekarang.
```

---

## Template singkat

```markdown
Shift dev otonom {6 jam}: improve aplikasi terus (maintenance, fitur backlog, QA, review) tanpa prompt saya lagi. Dokumentasikan semua di docs/shift/.
```

---

## Template fokus area

```markdown
Continuous improvement shift {4 jam}, fokus **{performance | security | UX | deuda técnica}**.

Prioritas pick:
1. P0 QA / review blocker
2. Backlog ready di area fokus
3. Roadmap MVP belum punya task

Catat impact di `docs/planning/impact-log.md`. Stop jika blocker bisnis.
```

---

## Template shift panjang + loop (host Cursor)

```markdown
Mulai dev shift {8 jam}. Setelah tick pertama, lanjutkan dengan interval {45m} (loop) sampai waktu habis.

Setiap wake: baca `docs/shift/current.md` → satu tick → update log. Hormati stop rules di skill continuous-dev-shift.
```

---

## Template manual (plan only)

```markdown
Rencanakan dev shift {8 jam} saja — jangan coding. Output: manifest, daftar 5–10 task kandidat dengan prioritas, estimasi tick, dan risiko impact.
```

---

## English (optional)

```markdown
Run an autonomous **continuous dev shift** for the active project.

Duration: {8h}. Auto-pick from backlog, open QA, and roadmap. Each tick: impact note → implement → QA → review → docs. No deploy/commit unless I ask. Start manifest under `docs/shift/` and run tick 1 now.
```

---

## Checklist sebelum prompt

- [ ] `PROJECT.md` / project id jelas
- [ ] `docs/tasks/backlog.md` ada (atau `docs/planning/backlog*.md` + buat index)
- [ ] `docs/planning/impact-log.md` ada (salin `templates/impact-log-template.md`)
- [ ] `docs/shift/` siap untuk manifest
- [ ] `WORKMODE.md` = `e2e` (atau eksplisit minta implement)
- [ ] Gate atribusi catalog OK
- [ ] Rule `shift.md` aktif (via install rules)

Referensi skill: `ai-agents-rogue/skills/continuous-dev-shift/SKILL.md`  
**Panduan pengguna:** `ai-agents-rogue/docs/dev-shift-guide.md`
