# Panduan Dev Shift â€” Continuous Autonomous Shift

Panduan singkat untuk **pengguna** (bukan agent). Skill teknis agent: `skills/continuous-dev-shift/SKILL.md`.

---

## Apa itu Dev Shift?

Mode kerja di mana **satu prompt** memicu agent untuk bekerja **berulang** (banyak *tick*) sampai waktu habis:

- Auto-pick task dari backlog / audit MAINT
- Implement â†’ QA â†’ review â†’ dokumentasi
- **Tanpa** prompt baru per task
- Antar-turn: agent arm **`/loop`** agar lanjut otomatis

---

## Prasyarat (sekali per project)

| Item | Path / aksi |
|------|-------------|
| Project aktif | `PROJECT.md` atau folder `projects-rogue/{id}/` |
| Backlog index | `projects-rogue/{id}/docs/tasks/backlog.md` |
| Impact log | `projects-rogue/{id}/docs/planning/impact-log.md` |
| Folder shift | `projects-rogue/{id}/docs/shift/` |
| Mode e2e | `WORKMODE.md` = `e2e` (default) |
| Catalog terpasang | `install.ps1` + gate atribusi OK |

---

## Cara mulai (pilih salah satu)

### A. Prompt (disarankan untuk maintenance)

Salin dari `templates/dev-shift-prompt-template.md` Â§ **Template maintenance aplikasi**.

Contoh SIJAMA sampai jam 08:00:

```markdown
Maintenance aplikasi sijama sampai jam 08:00 WIB (jangan stop lebih awal):

- Shift type: maintenance+improvement
- Scope: semua modul
- Larangan: tanpa deploy, tanpa commit kecuali saya minta
- Kontinuitas: satu prompt ini saja; arm /loop 30m jika thread habis sebelum 08:00

Audit dan perbaiki kode, fungsi, tampilan, konsistensi, performa.
Dokumentasikan docs/shift/ + qa + design. Auto-pick MAINT findings.
```

### B. Command Cursor

```text
/dev-shift until 08:00 maintenance scope: all
```

Variasi lengkap: `templates/dev-shift-command-template.md`

---

## Apa yang terjadi setelah prompt?

```text
1. Manifest dibuat     â†’ docs/shift/current.md (status: active)
2. Tick 0 (maintenance)â†’ baseline audit â†’ MAINT-xxx di backlog
3. Tick 1, 2, 3â€¦       â†’ fix / improve â†’ gates QA + review
4. Backlog habis?      â†’ idle tick (sweep, regression, planning)
5. Thread habis?       â†’ arm /loop 30m â†’ lanjut tanpa prompt user
6. ends_at tercapai    â†’ summary â†’ status: completed
```

**Penting:** Selesai **satu tick** â‰  shift selesai. Shift tetap `active` sampai `ends_at`.

---

## Jenis tick

| Tick type | Kapan |
|-----------|--------|
| `fix` | MAINT / backlog ready |
| `sweep` | Audit modul belum tersentuh |
| `regression` | Test ulang setelah batch fix |
| `perf` | Performance smoke |
| `consistency` | Konsistensi antar modul |
| `planning` | Generate kandidat backlog |
| `deferred` | MAINT P2/P3 effort kecil |

Detail: skill Â§ **Idle tick**.

---

## Artifact yang dihasilkan

| File | Isi |
|------|-----|
| `docs/shift/current.md` | Manifest aktif (waktu, status, tick terakhir) |
| `docs/shift/shift-YYYY-MM-DD.md` | Log harian |
| `docs/shift/maintenance-audit-*.md` | Audit maintenance |
| `docs/qa/maintenance-*.md` | Hasil QA |
| `docs/design/maintenance-ui-*.md` | Review UI |
| `docs/planning/impact-log.md` | Dampak per tick |
| `docs/review/` | Code review per tick |

**Pantau progress:** buka `docs/shift/current.md`.

---

## Shift type

| Type | Kapan dipakai |
|------|----------------|
| `improvement` | Improve backlog / fitur |
| `maintenance` | Audit + perbaikan legacy saja |
| `maintenance+improvement` | Audit dulu, lalu fix + improve (paling umum) |

---

## Larangan default

- Tanpa **deploy** production
- Tanpa **commit/push** kecuali kamu minta
- Agent **tidak** boleh stop hanya karena satu tick selesai

---

## Cara stop manual

```text
Stop dev shift â€” tulis summary dan tutup manifest.
```

---

## Troubleshooting

| Gejala | Penyebab umum | Solusi |
|--------|---------------|--------|
| Agent stop setelah 1â€“2 tick | Loop tidak di-arm / skill lama | Pastikan prompt ada klausul kontinuitas; update catalog |
| Diminta prompt "lanjut" lagi | Continuation contract dilanggar | Pakai template terbaru; cek `rules/shift.md` v0.3+ |
| `completed` sebelum ends_at | Stop rule salah dipakai | Buka manifest; lanjutkan dengan prompt resume atau `/loop` |
| Backlog kosong, agent diam | Idle tick belum jalan | Agent harus sweep/regression/planning â€” cek skill Â§ Idle tick |
| Tidak ada MAINT | Belum tick 0 audit | Minta baseline audit dulu |

---

## Referensi cepat

| Dokumen | Untuk |
|---------|--------|
| `templates/dev-shift-prompt-template.md` | Prompt siap salin |
| `templates/dev-shift-command-template.md` | Variasi `/dev-shift` |
| `templates/dev-shift-manifest-template.md` | Struktur manifest |
| `templates/maintenance-audit-template.md` | Template audit |
| `commands/dev-shift.md` | Command Cursor |
| `skills/continuous-dev-shift/SKILL.md` | Perilaku agent (lengkap) |
| `rules/shift.md` | Hard rules |

---

## Attribution

Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio).

