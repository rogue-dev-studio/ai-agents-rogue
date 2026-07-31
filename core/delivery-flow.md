# Delivery Flow

Version: 1.0.0

---

# 1. Tujuan

Delivery Flow mendefinisikan alur pengerjaan end-to-end dari permintaan pengguna hingga release, termasuk kapan setiap jenis artifact (SRS, Planning, Task, Code) dibuat.

---

# 2. Flow Utama

```
┌─────────────┐
│ User Request│
└──────┬──────┘
       ↓
┌─────────────┐     docs/srs/
│  Discovery  │ ──→ SRS Draft (partial)
└──────┬──────┘
       ↓
┌──────────────────┐
│ Requirement      │ ──→ SRS Complete (BA + SA)
│ Analysis         │
└──────┬───────────┘
       ↓
┌─────────────┐     docs/planning/
│  Planning   │ ──→ Roadmap, WBS, Milestone, Timeline
└──────┬──────┘
       ↓
┌─────────────┐     docs/architecture/
│ Architecture│ ──→ HLA, LLA, DB Design, API Design
└──────┬──────┘
       ↓
┌─────────────┐     docs/design/
│   Design    │ ──→ UI/UX, Design System
└──────┬──────┘
       ↓
┌──────────────────┐  docs/tasks/
│ Task Breakdown   │ ──→ Backlog, Sprint Board, Task Detail
└──────┬───────────┘
       ↓
┌─────────────┐     backend/, frontend/, database/
│ Development │ ──→ Code Implementation
└──────┬──────┘
       ↓
┌─────────────┐
│   Testing   │ ──→ QA Report
└──────┬──────┘
       ↓
┌─────────────┐
│   Review    │ ──→ Review Report
└──────┬──────┘
       ↓
┌───────────────┐
│ Documentation │ ──→ SRS Final, API Doc, User Guide
└──────┬────────┘
       ↓
┌─────────────┐
│   Release   │ ──→ Release Package
└──────┬──────┘
       ↓
      Done
```

---

# 3. Flow per Artifact

## 3.1 Flow SRS

```
Product Owner (User Story, AC)
        ↓
Business Analyst (Business Req, Business Rules, FR, NFR)
        ↓
System Analyst (Use Case, System Flow, API Req, Validation)
        ↓
Product Owner (Approve SRS)
        ↓
Technical Writer (Format final SRS)
        ↓
SRS Approved → masuk Planning
```

**Output:** `docs/srs/{project}/SRS-{module}-v{version}.md`

**Gate:** SRS status = Approved sebelum Planning dimulai.

---

## 3.2 Flow Planning

```
AI Orchestrator (inisiasi project, tentukan scope)
        ↓
Product Owner (roadmap, prioritas, MVP)
        ↓
Project Manager (WBS, milestone, timeline, dependency)
        ↓
AI Orchestrator (validasi kelengkapan planning)
        ↓
Planning Complete → masuk Task Breakdown
```

**Output:**

- `docs/planning/roadmap.md`
- `docs/planning/wbs.md`
- `docs/planning/milestone.md`
- `docs/planning/timeline.md`
- `docs/planning/dependency-map.md`

**Gate:** Setiap baris roadmap terhubung ke SRS ref.

---

## 3.3 Flow Task

```
Project Manager (epic & feature task dari WBS)
        ↓
Tech Lead (pecah task teknis: DB, API, UI)
        ↓
AI Orchestrator (assign agent, set dependency)
        ↓
Agent Executor (kerjakan task → update status)
        ↓
Code Reviewer (status: review)
        ↓
QA Engineer (status: qa)
        ↓
Task Done → artifact code/dokumen terlink
```

**Output:**

- `docs/tasks/backlog.md`
- `docs/tasks/board/sprint-{n}.md`
- `docs/tasks/tasks/TASK-{id}.md`

**Lifecycle:** `todo → ready → in_progress → review → qa → done`

**Gate:** Input artifact tersedia sebelum `in_progress`.

---

## 3.4 Flow Code

```
Solution Architect (architecture doc)
        ↓
Tech Lead (technical spec, API contract, folder structure)
        ↓
┌───────────────────────────────────────┐
│ Parallel (setelah contract final)     │
├───────────────┬───────────────────────┤
│ Database Eng  │ Backend Developer     │
│ (migration)   │ (API + service)       │
└───────┬───────┴───────────┬───────────┘
        ↓                   ↓
        └───────┬───────────┘
                ↓
        Frontend Developer (UI + API integration)
                ↓
        DevOps Engineer (docker, env — jika diperlukan)
                ↓
        Security Engineer (audit — jika diperlukan)
                ↓
        QA + Reviewer
                ↓
        Code Ready
```

**Output per layer:**

| Layer | Path | Agent |
|-------|------|-------|
| Migration | `backend/database/migrations/` | Database Engineer |
| Seeder | `backend/database/seeders/` | Database Engineer |
| API | `backend/app/Http/`, `Services/` | Backend Developer |
| UI | `frontend/src/` | Frontend Developer |
| Infra | `docker/` | DevOps Engineer |

**Gate:** Setiap file code terhubung ke TASK-ID di commit message atau task detail.

---

# 4. Agent Routing per Tahap Workflow

| Tahap | Agent Utama | Artifact Output |
|-------|-------------|-----------------|
| Discovery | AI Orchestrator, Product Owner | Context, initial scope |
| Requirement Analysis | Business Analyst, System Analyst | SRS |
| Planning | Product Owner, Project Manager | Planning docs |
| Architecture | Solution Architect | Architecture docs |
| Design | UI/UX Designer, Design System Specialist | Design docs |
| Task Breakdown | Project Manager, Tech Lead | Task docs |
| Development | Database, Backend, Frontend, DevOps | Code |
| Testing | QA Engineer | QA report |
| Review | Code Reviewer | Review report |
| Documentation | Technical Writer | Final SRS, API doc |
| Release | Delivery Manager | Release package |

---

# 5. Workflow Variants

## 5.1 Fitur Baru (Full Flow)

Jalankan seluruh flow dari Discovery hingga Release.

## 5.2 Bug Fix (Short Flow)

```
User Report Bug
    ↓
AI Orchestrator (triage)
    ↓
Project Manager (TASK bug — link ke modul/SRS)
    ↓
Engineer (fix code)
    ↓
QA → Review → Done
```

Artifact: Task detail wajib, SRS update jika behavior berubah.

## 5.3 Refactor (Medium Flow)

```
Tech Lead (identifikasi & task breakdown)
    ↓
Engineer (refactor code)
    ↓
QA → Review → Done
```

Artifact: Task wajib, SRS tidak berubah kecuali behavior berubah.

## 5.4 Analisis Saja (Analysis Flow)

```
Business Analyst + System Analyst
    ↓
SRS output
    ↓
Stop (belum masuk Planning/Code)
```

---

# 6. Parallel Execution Rules

Task boleh paralel jika:

| Kondisi | Contoh |
|---------|--------|
| Tidak ada dependency | TASK-003 UI + TASK-004 docs |
| Resource berbeda | Backend API + Frontend mock |
| Contract sudah final | Backend + Frontend setelah API contract |

Task tidak boleh paralel jika:

| Kondisi | Contoh |
|---------|--------|
| Dependency belum done | Frontend sebelum API contract |
| Same resource conflict | Dua migration mengubah tabel sama |
| Requirement belum clear | Development sebelum SRS approved |

---

# 7. Status Project (AI Orchestrator)

| Status | Artifact Aktif | Agent Aktif |
|--------|----------------|-------------|
| Discovery | — | AI Orchestrator, Product Owner |
| Analysis | SRS draft | Business Analyst, System Analyst |
| Planning | Planning docs | Project Manager, Product Owner |
| Architecture | Architecture docs | Solution Architect |
| Design | Design docs | UI/UX, Design System |
| Development | Task board + Code | Engineering |
| Testing | QA report | QA Engineer |
| Review | Review report | Code Reviewer |
| Documentation | SRS final, API doc | Technical Writer |
| Release | Release package | Delivery Manager |
| Done | Semua artifact locked | — |

---

# 8. Checklist Sebelum Pindah Tahap

## Analysis → Planning

- [ ] SRS lengkap (FR, NFR, Use Case, Business Rules)
- [ ] Product Owner approve SRS
- [ ] Tidak ada requirement ambigu

## Planning → Architecture

- [ ] Roadmap & WBS tersedia
- [ ] Milestone & timeline realistis
- [ ] Dependency map tidak circular

## Architecture → Task Breakdown

- [ ] HLA & LLA selesai
- [ ] Database design tersedia
- [ ] API design tersedia

## Task Breakdown → Development

- [ ] Sprint board tersedia
- [ ] Task detail dengan acceptance criteria
- [ ] Agent assigned per task
- [ ] Input artifact tersedia

## Development → Testing

- [ ] Code sesuai task output artifact
- [ ] Migration berjalan
- [ ] API endpoint accessible
- [ ] UI terintegrasi

## Testing → Release

- [ ] QA pass
- [ ] Reviewer approve
- [ ] Dokumentasi diperbarui
- [ ] Delivery Manager sign-off

---

# 9. Struktur Dokumen Project Lengkap

```
{project-root}/
├── docs/
│   ├── srs/                 # Artifact: SRS (PDF-like MD)
│   ├── planning/            # Artifact: Planning (spreadsheet MD)
│   ├── tasks/               # Artifact: Task (Jira-like MD)
│   ├── architecture/        # HLA, LLA, DB design, API design
│   ├── design/              # UI/UX, design system
│   ├── qa/                  # Test report, test case
│   └── release/             # Release notes, changelog
├── backend/                 # Artifact: Code (backend)
├── frontend/                # Artifact: Code (frontend)
├── docker/                  # Artifact: Code (infra)
└── AGENTS.md                # Referensi agent (katalog AI Agents Rogue)
```

---

# 10. Prinsip Penutup

Delivery Flow memastikan:

- Setiap tahap punya artifact jelas
- Setiap artifact punya agent owner
- Tidak ada lompatan tahap tanpa gate
- Traceability dari requirement hingga code
