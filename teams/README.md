# Teams

Folder opsional untuk dua hal berbeda:

1. **Pack domain lokal** — tempat menyimpan skill/role/rule di luar katalog tersegel (contoh: `teams/hr`, `teams/simrs`). Setelah disalin ke host, agent memakai skill **langsung dari prompt** — tidak perlu “buat/aktifkan tim”.
2. **Subset install** — `install.ps1 -Team <id>` membatasi skill/role ke `TEAM.yaml` (scope sempit).

Catalog publik default = **full install** (tanpa `-Team`).

## Prompt-first (disarankan)

| Domain | Prompt contoh | Skill (setelah salin ke host) |
|--------|---------------|-------------------------------|
| HR | review CV, screening JD, technical test engineer, onboarding | `hr-cv-lifecycle`, `hr-technical-interview`, `hr-employee-ops` |
| SIMRS | review modul SIMRS, technical assessment IT RS, mapping Permenkes | `simrs-hospital-ops`, `simrs-technical-assessment`, `simrs-clinical-review` |

`teams/<id>` = sumber file, bukan gerbang runtime.

## Cara kerja (subset install)

```text
teams/<team-id>/
  TEAM.yaml     # manifest: skills + roles yang diizinkan
  TEAM.md       # brief untuk AI (domain, batasan, stack)
  context.md    # catatan domain opsional
  skills/       # skill lokal pack (opsional)
```

Install dengan `-Team <id>` → hanya skills/roles di `TEAM.yaml` (+ `local_skills`).  
Jangan `install.ps1 -Team <id>` pada workspace full-catalog (akan memangkas skill).

Full catalog + pack domain (disarankan untuk HR/SIMRS):

```powershell
.\scripts\install.ps1 -Target . -Hosts all
# default -IncludeDomains hr; tambah simrs: -IncludeDomains hr,simrs; semua pack: all; tanpa pack: none
```

## Pack bawaan (lokal)

Tidak ada tim produk di **katalog tersegel**. Contoh lokal: `teams/hr`, `teams/simrs`. Mulai pack baru dari `_template/` bila perlu subset install; untuk skill baru cukup salin ke host dan andalkan deskripsi skill untuk routing prompt.

## Tambah pack / subset

1. Copy `_template/` → `teams/<id>/`
2. Edit `TEAM.yaml` + `TEAM.md`
3. Salin skill ke host **atau** (hanya jika sengaja scope sempit):

```powershell
.\scripts\install.ps1 -Target . -Hosts all -Team <id>
```

```bash
./scripts/install.sh . all <id>
```

## Local skills

Letakkan di `teams/<id>/skills/<name>/SKILL.md` dan daftar di `local_skills` pada `TEAM.yaml`. Routing runtime = deskripsi skill + prompt user.

## Bootstrap otomatis (disarankan)

Command `/bootstrap-domain` atau:

```powershell
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Domain simrs
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Prompt "buat aplikasi simrs igd dan rawat jalan"
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Domain hr -ProjectId hr-tools -ProjectName "HR Tools"
```

- Sync skill/role/rule pack → host **tanpa** `install -Team`
- Infer domain dari `-Prompt` bila `-Domain` kosong
- `-CreatePackIfMissing` untuk pack custom dari `_template`
- Manifest: `ai-agents-rogue/active-domain/{id}.json`
- Detail flow: `core/domain-bootstrap.md`

Setelah bootstrap → `/start-feature` (E2E). Gap skill: edit `teams/<id>/skills/`, bootstrap ulang `-Force`.
