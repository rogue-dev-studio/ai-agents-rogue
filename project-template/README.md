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

Semua artifact **dokumen** E2E ada di `docs/`:

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

## Deliverable (kode / gambar / 3D / media)

Simpan di `artifacts/{kategori}/` — lihat `artifacts/README.md`.

| Folder | Isi |
|--------|-----|
| `artifacts/code/` | Program / prototype / generated source |
| `artifacts/images/` | Gambar / raster |
| `artifacts/3d/` | Model & render 3D |
| `artifacts/design/` | Vektor / export desain |
| `artifacts/media/` | Video / audio |
| `artifacts/data/` | Data / output notebook |
| `artifacts/other/` | Lainnya |

Kode aplikasi produksi besar boleh di root repo (`backend/`, `frontend/`, …) **jika** struktur itu sudah ada; tetap catat path di docs project. File generate sekali-pakai / aset kreatif → **wajib** di `artifacts/`.

## Cara kerja AI

1. Baca `PROJECT.yaml` + file ini
2. Baca team aktif bila ada
3. Jalankan `e2e-delivery` — tulis docs ke **`docs/`**, aset generate ke **`artifacts/{kategori}/`**
