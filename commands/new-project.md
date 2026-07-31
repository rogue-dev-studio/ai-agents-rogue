# New Project

Buat folder project baru di `project/{id}/` beserta dokumentasi pengembangan.

Minta user (atau ambil dari argumen chat):

- `id` (lowercase-hyphen), contoh: `my-app`
- `name` (opsional)
- `team` (opsional; hanya jika `teams/<id>/` sudah ada)

Lalu jalankan:

```powershell
.\ai-agents-rogue\scripts\new-project.ps1 -Id <id> -Name "<name>"
```

Setelah dibuat:

1. Baca `PROJECT.md` (active) + `project/<id>/README.md`
2. Install catalog: `install.ps1 -Target . -Hosts all` (atau `-Team <id>` bila memakai tim)
3. Jalankan E2E (`e2e-delivery` / `/start-feature`) — artifact ke `project/<id>/docs/`
