# Dev Shift (autonomous timed E2E)

Jalankan **continuous dev shift** untuk project aktif: agent memilih task, mengeksekusi, QA, review, dan mendokumentasikan **berulang** sampai durasi habis — tanpa prompt baru per task.

## Syntax

```text
/dev-shift [durasi] [opsi]
```

Contoh durasi: `8h`, `4 jam`, `90m`, `until 17:00`

Contoh opsi (bebas urutan):

- `scope: auth, reporting` — batas modul
- `max-tasks: 5` — maks tick
- `interval: 45m` — cadangan untuk `/loop` host
- `maintenance` — full audit legacy + fix (kode, UI, fungsi, konsistensi, performa)
- `mode: maintenance` — sama
- `focus: performance` — bias prioritas pick

## Langkah (wajib)

1. Gate atribusi (3 script verify).
2. Load skill **`continuous-dev-shift`** + **`e2e-delivery`** + host **`loop`** (jika shift berdurama).
3. Berperan sebagai **AI Orchestrator** + **Shift Coordinator**.
4. Salin/update manifest dari `templates/dev-shift-manifest-template.md` → `project/{id}/docs/shift/current.md`.
5. **Multi-tick:** jalankan banyak tick berturut-turut dalam satu turn sebelum reply.
6. Jika `ends_at` belum tiba dan turn akan selesai → **wajib arm `loop`** (interval default 30–45m) + update `loop_armed: true`.
7. Ulangi wake sampai stop rule; **jangan** mark `completed` lebih awal.
8. Akhiri dengan shift summary hanya saat benar-benar selesai.

## Prompt alternatif

User **tidak wajib** memakai command — prompt natural language dengan maksud yang sama memicu skill yang sama. Lihat `templates/dev-shift-prompt-template.md`.

## Project belum ada

Jalankan `/new-project` dulu, isi minimal `docs/tasks/backlog.md` dari `templates/task-template.md`.

## Mode manual

`/assist` atau "rencana shift saja" → hanya manifest + rencana tick, **tanpa** implement.

Dokumentasi: `ai-agents-rogue/skills/continuous-dev-shift/SKILL.md` · **Panduan pengguna:** `ai-agents-rogue/docs/dev-shift-guide.md`
