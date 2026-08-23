# Bootstrap Domain (prompt-first)

Siapkan **pack domain** (`simrs`, `hr`, atau custom) untuk dipakai langsung dari prompt — **tanpa** `install.ps1 -Team` (full catalog tetap utuh).

## Kapan agent menjalankan ini

Jalankan **proaktif** bila user:

- Minta **buat aplikasi SIMRS** / modul rumah sakit → domain `simrs`
- Minta **CV / HR / recruitment / onboarding** → domain `hr`
- Menyebut domain yang pack-nya belum tersync ke host

Urutan disarankan:

1. `bootstrap-domain` (sync skill/rule/role + manifest)
2. `/new-project` jika belum ada project (bisa digabung `-ProjectId`)
3. `/start-feature` untuk E2E build

## Perintah

```powershell
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Domain simrs -ProjectId my-simrs -ProjectName "SIMRS RS Contoh"
```

```powershell
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Prompt "buat aplikasi simrs rawat jalan dan igd"
```

```powershell
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Domain hr -Force
```

### Parameter

| Param | Fungsi |
|-------|--------|
| `-Domain` | `simrs`, `hr`, atau id pack custom |
| `-Prompt` | Infer domain dari teks user jika `-Domain` kosong |
| `-ProjectId` / `-ProjectName` | Buat `project/{id}/` setelah sync |
| `-CreatePackIfMissing` | Scaffold `teams/<id>` dari `_template` |
| `-Force` | Timpa salinan skill/role/rule di host |
| `-DryRun` | Laporan saja |

## Output

- Skill lokal → `.cursor/skills/`, `.claude/skills/`, `.agents/skills/`, `.opencode/skills/` (merge, bukan subset install)
- Role pack → `.cursor/agents/roles/{clinical|people-ops|...}/`
- Rule pack → `.cursor/rules/simrs-*.mdc` / `hr-*.mdc`
- Manifest → `ai-agents-rogue/active-domain/{domain}.json`

## Update skill dari prompt (gap)

Setelah bootstrap, jika prompt menyinggung modul/AC yang belum ada di skill:

1. Edit `teams/<domain>/skills/<skill>/SKILL.md` (sumber kebenaran)
2. Jalankan ulang `bootstrap-domain -Domain <id> -Force` **atau** salin manual ke host
3. Jangan menambah requirement tanpa dokumentasi singkat di skill atau `project/{id}/docs/`

Pack **baru** (`-CreatePackIfMissing`): isi skill/rule/role, daftar di `TEAM.yaml` `local_skills`, bootstrap ulang.

## Routing setelah bootstrap

| Domain | Prompt contoh | Skill |
|--------|---------------|--------|
| simrs | review IGD, mapping Permenkes | `simrs-clinical-review`, `simrs-data-mapping`, … |
| hr | review CV vs JD | `hr-cv-lifecycle`, `hr-employee-ops` |

Lihat `teams/<domain>/README.md` untuk tabel lengkap.
