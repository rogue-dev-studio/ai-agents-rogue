# Artifact System

Version: 1.0.0

---

# 1. Tujuan

Artifact System mendefinisikan jenis output yang dihasilkan AI Agents Rogue, format dokumen, lokasi penyimpanan, dan agent yang bertanggung jawab.

Semua pekerjaan agent harus menghasilkan artifact yang dapat ditelusuri.

---

# 2. Jenis Artifact

Semua dokumentasi pengembangan per project hidup di:

```text
project/{id-namaproject}/docs/
```

Deliverable non-dokumentasi (program generate, gambar, 3D, desain, media, data) hidup di:

```text
project/{id-namaproject}/artifacts/{kategori}/
```

| Jenis | Analogi | Format | Lokasi |
|-------|---------|--------|--------|
| SRS | PDF formal | Markdown terstruktur | `project/{id}/docs/srs/` |
| Planning | Spreadsheet | Markdown tabel | `project/{id}/docs/planning/` |
| Architecture | Design docs | Markdown | `project/{id}/docs/architecture/` |
| Design | UI/UX | Markdown | `project/{id}/docs/design/` |
| Task | Jira board | Markdown board + metadata | `project/{id}/docs/tasks/` |
| QA | Test report | Markdown | `project/{id}/docs/qa/` |
| Review | Review notes | Markdown | `project/{id}/docs/review/` |
| Release | Checklist | Markdown | `project/{id}/docs/release/` |
| Code (app besar) | Aplikasi | Source code | `backend/`, `frontend/`, `database/` di root repo **jika** struktur itu sudah ada; prototype/generate → `project/{id}/artifacts/code/` |
| Images | Aset raster | PNG/JPG/… | `project/{id}/artifacts/images/` |
| 3D | Model/render | `.blend`, GLB, render | `project/{id}/artifacts/3d/` |
| Design exports | Vektor/UI export | AI/SVG/PDF | `project/{id}/artifacts/design/` |
| Media | AV | video/audio | `project/{id}/artifacts/media/` |
| Data | Dataset/out | CSV, notebook out | `project/{id}/artifacts/data/` |
| Other | Catch-all | — | `project/{id}/artifacts/other/` |

Project baru: `scripts/new-project.ps1` / `/new-project` (template sudah berisi `artifacts/`).

**Aturan:** roles/skills yang menghasilkan file **harus** memakai path di atas berdasarkan **nama project (`{id}`)** dan **kategori**. Baca `PROJECT.md` aktif. Jangan simpan output generate di root catalog atau folder acak.

---

# 3. SRS — Software Requirement Specification

## 3.1 Karakteristik

- Dokumen formal, lengkap, dan dapat dibaca seperti PDF
- Satu SRS per modul atau fitur besar
- Menjadi single source of truth requirement sebelum development

## 3.2 Agent Bertanggung Jawab

| Tahap | Agent | Output Partial |
|-------|-------|----------------|
| Business layer | Business Analyst | Business Requirement, Business Rules, Functional Requirement |
| System layer | System Analyst | Use Case, System Flow, API Requirement, Validation Rule |
| Finalisasi | Technical Writer | SRS final terformat |

## 3.3 Struktur Folder

```
docs/srs/
├── README.md
├── {project-name}/
│   ├── SRS-{module}-v{version}.md
│   └── changelog.md
```

## 3.4 Template SRS

```markdown
# SRS — {Nama Modul}

Version: {x.y.z}
Status: Draft | Review | Approved
Author: {Agent}
Last Updated: {YYYY-MM-DD}

---

## 1. Pendahuluan
### 1.1 Tujuan
### 1.2 Ruang Lingkup
### 1.3 Definisi & Singkatan
### 1.4 Referensi

## 2. Gambaran Umum
### 2.1 Perspektif Produk
### 2.2 Fungsi Produk
### 2.3 Karakteristik Pengguna
### 2.4 Batasan
### 2.5 Asumsi & Ketergantungan

## 3. Kebutuhan Fungsional
| ID | Requirement | Prioritas | Acceptance Criteria |
|----|-------------|-----------|---------------------|
| FR-001 | ... | Critical | ... |

## 4. Kebutuhan Non-Fungsional
| ID | Kategori | Requirement |
|----|----------|-------------|
| NFR-001 | Security | ... |

## 5. Business Rules
| ID | Rule | Sumber |
|----|------|--------|

## 6. Use Case
### UC-001 — {Nama Use Case}
- Actor:
- Preconditions:
- Main Flow:
- Alternative Flow:
- Exception Flow:
- Postconditions:

## 7. System Flow
## 8. Data Requirement
## 9. API Requirement
## 10. Integration Requirement
## 11. Validation Rule
## 12. Exception Handling
## 13. Traceability Matrix

| Requirement ID | Use Case | Module | Task ID |
|----------------|----------|--------|---------|

## 14. Approval

| Role | Agent | Status | Date |
|------|-------|--------|------|
| Product Owner | | Pending | |
| System Analyst | | Pending | |
```

## 3.5 Quality Gate SRS

- Semua functional requirement memiliki ID dan acceptance criteria
- Semua use case lengkap (main, alternative, exception flow)
- Traceability matrix terisi minimal ke modul
- Product Owner approve sebelum masuk Planning

---

# 4. Planning — Spreadsheet Markdown

## 4.1 Karakteristik

- Format tabel markdown (mirip spreadsheet)
- Menampilkan roadmap, milestone, timeline, dan dependency
- Dapat di-scan cepat oleh seluruh tim

## 4.2 Agent Bertanggung Jawab

| Output | Agent |
|--------|-------|
| Product roadmap & prioritas | Product Owner |
| WBS, milestone, timeline | Project Manager |
| Koordinasi & status project | AI Orchestrator |

## 4.3 Struktur Folder

```
docs/planning/
├── README.md
├── roadmap.md
├── milestone.md
├── wbs.md
├── timeline.md
├── dependency-map.md
└── risk-register.md
```

## 4.4 Template Roadmap

```markdown
# Product Roadmap — {Project Name}

Version: {x.y.z}
Last Updated: {YYYY-MM-DD}

| ID | Feature | Priority | MVP | Phase | Status | Owner Agent | SRS Ref | Target |
|----|---------|----------|-----|-------|--------|-------------|---------|--------|
| F-001 | Authentication | Critical | Yes | 1 | Planned | Product Owner | SRS-auth-v1.md | Sprint 1 |
| F-002 | Master Data | High | Yes | 1 | Planned | Product Owner | SRS-master-v1.md | Sprint 2 |
```

## 4.5 Template WBS

```markdown
# Work Breakdown Structure — {Project Name}

| WBS ID | Epic | Feature | Sub Feature | Agent | Effort | Dependency |
|--------|------|---------|-------------|-------|--------|------------|
| 1.0 | Auth | Login | API Login | Backend Developer | M | 1.1 |
| 1.1 | Auth | Login | DB Users | Database Engineer | S | — |
| 1.2 | Auth | Login | UI Login | Frontend Developer | M | 1.0 |
```

## 4.6 Template Milestone

```markdown
# Milestone Tracker

| Milestone | Target Date | Status | Deliverables | Blocker |
|-----------|-------------|--------|--------------|---------|
| M1 — Project Setup | 2026-07-10 | Done | Docker, DB, skeleton | — |
| M2 — Authentication | 2026-07-20 | In Progress | SRS, API, UI Login | — |
```

## 4.7 Template Timeline

```markdown
# Timeline — {Sprint/Phase}

| Week | Agent | Focus | Output Artifact |
|------|-------|-------|-----------------|
| W1 | Business Analyst + System Analyst | Requirement | SRS draft |
| W2 | Solution Architect + Tech Lead | Design | Architecture + Tech Spec |
| W3 | Engineering | Implementation | Code |
| W4 | QA + Reviewer | Quality | Test report |
```

## 4.8 Quality Gate Planning

- Setiap feature di roadmap terhubung ke SRS
- WBS setiap feature memiliki agent dan effort
- Dependency map tidak circular
- Milestone realistis dan measurable

---

# 5. Task — Jira-like Markdown

## 5.1 Karakteristik

- Format board markdown (mirip Jira)
- Setiap task punya lifecycle (lihat `core/task-system.md`)
- Satu file board per sprint/epic, detail task per file

## 5.2 Agent Bertanggung Jawab

| Tindakan | Agent |
|----------|-------|
| Membuat epic & feature task | Project Manager |
| Memecah task teknis | Tech Lead |
| Mengerjakan task | Agent sesuai assignment |
| Update status | Agent yang mengerjakan |
| Validasi selesai | QA Engineer, Code Reviewer |

## 5.3 Struktur Folder

```
docs/tasks/
├── README.md
├── backlog.md
├── board/
│   ├── sprint-01.md
│   └── sprint-02.md
└── tasks/
    ├── TASK-001.md
    ├── TASK-002.md
    └── ...
```

## 5.4 Template Board (Sprint)

```markdown
# Sprint 01 Board

Period: {start} — {end}
Goal: {sprint goal}

## Todo
| ID | Title | Agent | Priority | Effort |
|----|-------|-------|----------|--------|
| TASK-001 | Setup migration users | Database Engineer | High | S |

## In Progress
| ID | Title | Agent | Blocker |
|----|-------|-------|---------|

## Review
| ID | Title | Agent | Reviewer |
|----|-------|-------|----------|

## QA
| ID | Title | Agent | QA |
|----|-------|-------|-----|

## Done
| ID | Title | Agent | Completed |
|----|-------|-------|-----------|
```

## 5.5 Template Task Detail

```markdown
# TASK-001 — Setup migration users

| Field | Value |
|-------|-------|
| Type | feature |
| Priority | high |
| Status | in_progress |
| Assigned Agent | database-engineer |
| Effort | S |
| Sprint | sprint-01 |
| Epic | EPIC-001 Authentication |

## Description
Membuat migration tabel users sesuai database design.

## Input Artifacts
- docs/srs/{project}/SRS-auth-v1.md
- docs/architecture/database-design.md

## Output Artifacts
- backend/database/migrations/xxxx_create_users_table.php

## Acceptance Criteria
- [ ] Migration up/down berjalan tanpa error
- [ ] Kolom sesuai database design
- [ ] Index pada email unik

## Dependencies
- TASK-000 (project setup) — done

## Notes
```

## 5.6 Quality Gate Task

- Task tidak ambiguous (1 tujuan, 1 output utama)
- Input artifact tersedia sebelum status `in_progress`
- Acceptance criteria dapat diuji
- Traceability ke SRS requirement ID

---

# 6. Code — Aplikasi

## 6.1 Karakteristik

- Source code aktual yang dijalankan
- Mengikuti Technical Specification dari Tech Lead
- Terhubung ke task via output artifact

## 6.2 Agent Bertanggung Jawab

| Layer | Agent | Output |
|-------|-------|--------|
| Database | Database Engineer | Migration, seeder, schema |
| Backend | Backend Developer | Controller, Service, DTO, Model, API |
| Frontend | Frontend Developer | Pages, components, services |
| Infrastructure | DevOps Engineer | Docker, compose, env template |
| Security | Security Engineer | Security config, audit |

## 6.3 Struktur Folder Code

```
{project-root}/
├── backend/
│   ├── app/
│   │   ├── Http/
│   │   │   ├── Controllers/
│   │   │   ├── Requests/
│   │   │   └── Resources/
│   │   ├── Services/
│   │   ├── DTO/
│   │   └── Models/
│   ├── database/
│   │   ├── migrations/
│   │   └── seeders/
│   ├── routes/
│   └── tests/
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   ├── services/
│   │   ├── hooks/
│   │   └── utils/
│   └── tests/
├── database/
│   └── schema/          (optional: ERD export, reference SQL)
├── docker/
│   ├── docker-compose.yml
│   └── Dockerfile
└── docs/                (SRS, Planning, Task — bukan code)
```

## 6.4 Mapping Task → Code

| Task Type | Code Output |
|-----------|-------------|
| Database task | `backend/database/migrations/*.php` |
| Backend API task | `backend/app/Http/Controllers/*`, `Services/*` |
| Frontend UI task | `frontend/src/pages/*`, `components/*` |
| DevOps task | `docker/*`, env config |
| Full feature | Kombinasi semua layer di atas |

## 6.5 Urutan Implementasi Code

```
Database Engineer (migration)
        ↓
Backend Developer (API + service)
        ↓
Frontend Developer (UI + integration)
        ↓
QA Engineer (testing)
        ↓
Code Reviewer (review)
```

Backend dan Frontend boleh paralel setelah API contract final, dengan mock API jika diperlukan.

## 6.6 Quality Gate Code

- Sesuai coding standard AGENTS.md
- Sesuai Technical Specification Tech Lead
- Tidak ada error runtime
- Migration reversible
- API sesuai contract
- Lolos QA dan Review

---

# 7. Traceability Chain

Setiap artifact harus dapat ditelusuri:

```
User Request
    ↓
SRS (requirement ID)
    ↓
Planning (feature ID → SRS ref)
    ↓
Task (task ID → requirement ID)
    ↓
Code (file path → task ID)
    ↓
QA Report (task ID)
    ↓
Release (Delivery Manager)
```

---

# 8. Agent × Artifact Matrix

| Agent | SRS | Planning | Task | Code |
|-------|-----|----------|------|------|
| AI Orchestrator | Review | Koordinasi | Routing | — |
| Product Owner | Input/Approve | Roadmap, prioritas | Epic definition | — |
| Project Manager | — | WBS, milestone, timeline | Board, breakdown | — |
| Business Analyst | Business layer | — | — | — |
| System Analyst | System layer | — | — | — |
| Solution Architect | Referensi arsitektur | — | — | — |
| Tech Lead | — | — | Technical breakdown | Standard & review |
| UI/UX Designer | UI requirement | — | Design task | — |
| Design System Specialist | — | — | Design task | Design tokens |
| Database Engineer | Data requirement | WBS row | DB task | Migration, seeder |
| Backend Developer | API requirement | WBS row | Backend task | Laravel backend |
| Frontend Developer | — | WBS row | Frontend task | React/Vue frontend |
| DevOps Engineer | — | Infrastructure row | DevOps task | Docker, compose |
| Security Engineer | NFR security | — | Security task | Security config |
| QA Engineer | Test dari AC | — | QA status | Test execution |
| Code Reviewer | — | — | Review status | Code review |
| Technical Writer | Finalisasi SRS | — | — | — |
| Delivery Manager | — | Release plan | Release task | Release package |

---

# 9. Prinsip Utama

- SRS sebelum Planning
- Planning sebelum Task Breakdown
- Task sebelum Code
- Code sebelum Release
- Tidak ada artifact tanpa agent owner
- Tidak ada pekerjaan tanpa task
