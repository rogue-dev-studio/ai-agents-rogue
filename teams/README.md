# Teams

Folder opsional untuk **subset** skills & roles dari katalog global.

Catalog publik default = **full install** (tanpa `-Team`). Tim dibuat sendiri bila Anda butuh scope sempit.

## Cara kerja

```text
teams/<team-id>/
  TEAM.yaml     # manifest: skills + roles yang diizinkan
  TEAM.md       # brief untuk AI (domain, batasan, stack)
  context.md    # catatan domain opsional
  skills/       # skill lokal tim saja (opsional)
```

Install dengan `-Team <id>` → hanya skills/roles di `TEAM.yaml` (+ `local_skills`).

## Tim bawaan

Tidak ada tim produk bawaan di repo resmi. Mulai dari `_template/`.

## Tambah tim

1. Copy `_template/` → `teams/<id>/`
2. Edit `TEAM.yaml` + `TEAM.md`
3. Install:

```powershell
.\scripts\install.ps1 -Target . -Hosts all -Team <id>
```

```bash
./scripts/install.sh . all <id>
```

## Local skills

Letakkan di `teams/<id>/skills/<name>/SKILL.md` dan daftar di `local_skills` pada `TEAM.yaml`.
