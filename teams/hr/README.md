# Pack `hr` (local) — prompt-first

Skill, rule, dan role **People Operations**. Tidak masuk skill katalog tersegel.

## Cara pakai (utama)

**Tidak perlu membuat atau mengaktifkan tim.** Setelah skill disalin ke host:

| Prompt user (contoh) | Skill |
|----------------------|--------|
| buat / review / perbaiki CV, screening vs JD, ATS, wawancara | `hr-cv-lifecycle` |
| onboarding, FAQ kebijakan, cuti, KPI / performance | `hr-employee-ops` |

Agent membaca skill dari deskripsi + trigger di atas, lalu ikut prosedurnya. Role opsional jika user minta peran eksplisit.

Folder `teams/hr` = **sumber paket** (bukan gerbang wajib).

## Isi

| Jenis | Path |
|-------|------|
| Skill | `skills/hr-cv-lifecycle/`, `skills/hr-employee-ops/` |
| Rule | `rules/people-data.md` → host `.cursor/rules/hr-people-data.mdc` |
| Role | `roles/hr-specialist.md`, `roles/talent-recruiter.md` |

## Pasang ke host (full catalog tetap utuh)

Salin skill ke `.cursor/skills/`, `.claude/skills/`, `.agents/skills/`, `.opencode/skills/`.  
Salin role ke `*/agents/roles/people-ops/` (opsional).  
Salin rule ke host rules.  
Jangan jalankan `install.ps1 -Team hr` di repo yang sudah full catalog.
