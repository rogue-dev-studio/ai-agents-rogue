# Dev Shift — Command Template

Gunakan command Cursor **`/dev-shift`** (setelah install catalog). Setara dengan prompt template; lebih ringkas untuk repeat use.

---

## Install command (sekali)

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts cursor
```

Command terpasang di `.cursor/commands/dev-shift.md`.

---

## Variasi command

### Standar 8 jam

```text
/dev-shift 8h
```

### Maintenance aplikasi (full audit)

```text
/dev-shift 8h maintenance
/dev-shift 6 jam mode: maintenance scope: all
```

### Durasi + scope

```text
/dev-shift 4 jam scope: auth, reporting
```

### Sampai jam tertentu

```text
/dev-shift until 17:00
```

### Batas jumlah task

```text
/dev-shift 6h max-tasks: 8
```

### Fokus + interval loop

```text
/dev-shift 8h focus: performance interval: 45m
```

### Plan only (pair dengan /assist)

```text
/assist
Rencana dev shift 8h: manifest + backlog pick saja, jangan implement.
```

Atau tetap `/dev-shift` lalu tambahkan di chat: "rencana saja, manual mode".

---

## Setara prompt (tanpa slash command)

| Command | Prompt setara |
|---------|----------------|
| `/dev-shift 8h` | "Jalankan continuous dev shift 8 jam, auto-pick backlog" |
| `/dev-shift 4h scope: api` | "Shift dev 4 jam, scope modul api saja" |
| `/dev-shift until 17:00` | "Dev shift sampai jam 17:00 WIB" |
| `/dev-shift 8h maintenance` | "Maintenance aplikasi 8 jam — audit kode, UI, fungsi, konsistensi, performa" |

---

## Output yang diharapkan

| Artifact | Path |
|----------|------|
| Manifest aktif | `project/{id}/docs/shift/current.md` |
| Log shift | `project/{id}/docs/shift/shift-YYYY-MM-DD.md` |
| Impact | `project/{id}/docs/planning/impact-log.md` |
| Task updates | `project/{id}/docs/tasks/` |
| QA / Review | `project/{id}/docs/qa/`, `docs/review/` |

---

## Stop shift

Di chat:

```text
Stop dev shift — tulis summary dan tutup manifest.
```

---

## Referensi

- Skill: `skills/continuous-dev-shift/SKILL.md`
- Prompt templates: `templates/dev-shift-prompt-template.md`
- Manifest: `templates/dev-shift-manifest-template.md`
