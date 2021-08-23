# Pack `simrs` (local) — prompt-first

Skill, rule, dan role **SIMRS / operasi rumah sakit**. Tidak masuk skill katalog tersegel.

## Cara pakai (utama)

**Tidak perlu membuat atau mengaktifkan tim.** Setelah skill disalin ke host:

| Prompt user (contoh) | Skill |
|----------------------|--------|
| alur RS, modul SIMRS, peran dokter/perawat/kasir, journey pasien | `simrs-hospital-ops` |
| review aplikasi SIMRS, RBAC, menu, UAT alur klinis | `simrs-clinical-review` |
| kepatuhan UU/Permenkes/SPO, consent, SATUSEHAT, BPJS | `simrs-regulatory-id` |
| mapping data regulasi → tabel/API/UI | `simrs-data-mapping` |
| PII/PHI, RM, NIK, resep, log, seed, export | `simrs-patient-data` |

Agent membaca skill dari deskripsi + trigger di atas. Role opsional jika user minta peran eksplisit.

Folder `teams/simrs` = **sumber paket** (bukan gerbang wajib). Alias `simrs-clinical-modules` → arahkan ke `simrs-hospital-ops`.

## Isi

| Jenis | Path |
|-------|------|
| Skill | `simrs-hospital-ops`, `simrs-clinical-review`, `simrs-regulatory-id`, `simrs-data-mapping`, `simrs-patient-data`, alias `simrs-clinical-modules` |
| Rule | `patient-health-data.md`, `hospital-regulatory-id.md`, `data-mapping.md` → `.cursor/rules/simrs-*.mdc` |
| Role | `roles/simrs-domain-specialist.md`, `roles/simrs-clinical-reviewer.md` → `*/agents/roles/clinical/` |

## Pasang ke host (full catalog tetap utuh)

Salin skill ke `.cursor/skills/`, `.claude/skills/`, `.agents/skills/`, `.opencode/skills/`.  
Salin role ke `*/agents/roles/clinical/` (opsional).  
Salin rule ke host rules.  
Jangan jalankan `install.ps1 -Team simrs` di repo yang sudah full catalog.
