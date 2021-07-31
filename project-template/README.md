# __PROJECT_NAME__

ID: `__PROJECT_ID__`  
Team: `__TEAM_ID__`  
Status: discovery

## Ringkasan

Deskripsi singkat produk/project.

## Tim

Lihat `ai-agents-rogue/teams/__TEAM_ID__/TEAM.md` (jika team di-set).  
Skills/roles mengikuti `TEAM.yaml` tim tersebut.

## Dokumentasi pengembangan

Semua artifact E2E ada di `docs/`:

| Folder | Isi |
|--------|-----|
| `docs/srs/` | Requirement / SRS |
| `docs/planning/` | Roadmap, WBS, timeline |
| `docs/architecture/` | HLA, LLA, API, DB design |
| `docs/design/` | UI/UX, design notes |
| `docs/tasks/` | Board & task detail |
| `docs/qa/` | Test plan & laporan |
| `docs/review/` | Code review notes |
| `docs/release/` | Checklist release |

## Cara kerja AI

1. Baca `PROJECT.yaml` + file ini
2. Baca team aktif bila ada
3. Jalankan `e2e-delivery` — tulis artifact ke **folder docs di project ini**
