# Pack `hr` (local) — prompt-first

Skill, rule, dan role **People Operations**. Tidak masuk skill katalog tersegel.

## Cara pakai (utama)

**Tidak perlu membuat atau mengaktifkan tim.** Setelah skill disalin ke host:

| Prompt user (contoh) | Skill |
|----------------------|--------|
| buat / review / perbaiki CV, screening vs JD, ATS, wawancara | `hr-cv-lifecycle` |
| psikotest, aptitude, gaya kerja, integritas kandidat | `hr-psychometric` |
| technical interview, live coding, take-home, tes teknis engineer | `hr-technical-interview` |
| onboarding, FAQ kebijakan, cuti, KPI / performance | `hr-employee-ops` |

Agent membaca skill dari deskripsi + trigger di atas, lalu ikut prosedurnya. Role opsional jika user minta peran eksplisit.

Folder `teams/hr` = **sumber paket** (bukan gerbang wajib).

## Isi

| Jenis | Path |
|-------|------|
| Skill | `skills/hr-cv-lifecycle/`, `skills/hr-employee-ops/`, `skills/hr-psychometric/`, `skills/hr-technical-interview/` |
| Contoh | `examples/engineer-recruitment-pack.md` |
| Rule | `rules/people-data.md` → host `.cursor/rules/hr-people-data.mdc` |
| Role | `roles/hr-specialist.md`, `roles/talent-recruiter.md`, `roles/technical-interviewer.md` |

## Pasang ke host (full catalog tetap utuh)

Instal default (full catalog) sekarang **otomatis** menyertakan pack HR via `-IncludeDomains hr` (default).

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
# HR + SIMRS lokal: -IncludeDomains hr,simrs
# Tanpa pack domain: -IncludeDomains none
```

Atau bootstrap manual (tanpa re-install):

```powershell
.\ai-agents-rogue\scripts\bootstrap-domain.ps1 -Domain hr
```

Salin manual ke `.cursor/skills/`, `.claude/skills/`, `.agents/skills/`, `.opencode/skills/` bila perlu.  
Jangan jalankan `install.ps1 -Team hr` di repo yang sudah full catalog.
