# Task System Core

Version: 1.0.0

---

# 1. Tujuan

Task System adalah inti eksekusi dari seluruh AI Agents Rogue.

Semua agent tidak bekerja langsung pada fitur, tetapi bekerja melalui TASK yang terstruktur, terukur, dan memiliki lifecycle.

Task System bertindak sebagai "CPU scheduler" untuk seluruh agent.

---

# 2. Konsep Utama

Semua pekerjaan harus berbentuk TASK.

Tidak ada pekerjaan tanpa task.

---

# 3. Struktur Task

Setiap task wajib memiliki struktur berikut:

```json
{
  "id": "TASK-001",
  "title": "string",
  "description": "string",
  "type": "feature | bug | refactor | research | documentation",
  "priority": "critical | high | medium | low",
  "status": "todo | ready | in_progress | blocked | review | qa | done",
  "dependencies": [],
  "assigned_agent": "agent-name",
  "input_artifacts": [],
  "output_artifacts": [],
  "acceptance_criteria": [],
  "estimated_effort": "S | M | L | XL"
}
```

---

# 4. Task Lifecycle

```
TODO
 ↓
READY
 ↓
IN_PROGRESS
 ↓
BLOCKED (optional)
 ↓
REVIEW
 ↓
QA
 ↓
DONE
```

---

# 5. Rule Execution

## 5.1 Wajib Task-Based Execution

- Tidak ada agent boleh bekerja tanpa task
- Semua output harus berasal dari task
- Tidak boleh ada “jawaban langsung tanpa task”

---

## 5.2 Single Responsibility Task

Setiap task hanya boleh memiliki:

- 1 tujuan utama
- 1 output utama
- 1 acceptance criteria set

---

## 5.3 No Ambiguity Rule

Task tidak boleh:

- ambigu
- terlalu besar
- tidak jelas outputnya

Jika ambiguous → harus dipecah

---

# 6. Task Breakdown System

Setiap task besar harus dipecah menjadi:

Epic
 ↓
Feature Task
 ↓
Sub Task
 ↓
Execution Task

---

# 7. Dependency Engine

Task tidak boleh dieksekusi jika:

- dependency belum DONE
- input artifact belum tersedia

---

# 8. Artifact System

Setiap task menghasilkan artifact.

Jenis artifact utama (detail: `core/artifact-system.md`):

| Jenis | Contoh Output |
|-------|---------------|
| SRS | `docs/srs/{project}/SRS-auth-v1.md` |
| Planning | `docs/planning/wbs.md` |
| Task | `docs/tasks/tasks/TASK-001.md` |
| Code | `backend/database/migrations/`, `frontend/src/` |

Artifact adalah output final dari task dan wajib terlink di field `output_artifacts` task detail.

---

# 9. Agent Assignment Rules

| Agent | Tipe Task |
|------|----------|
| Product Owner | requirement |
| Business Analyst | analysis |
| System Analyst | specification |
| Solution Architect | architecture |
| UI/UX Designer | design |
| Design System Specialist | design-system |
| Tech Lead | technical design |
| Backend Developer | implementation |
| Frontend Developer | implementation |
| Database Engineer | data layer |
| DevOps Engineer | infrastructure |
| Security Engineer | security |
| QA Engineer | testing |
| Code Reviewer | review |
| Technical Writer | documentation |
| Delivery Manager | release |

---

# 10. Task Routing Engine

System harus otomatis:

- assign task ke agent yang benar
- validasi input artifact
- memastikan dependency terpenuhi

---

# 11. Priority Rules

Urutan eksekusi:

1. Critical
2. High
3. Medium
4. Low
5. Backlog

---

# 12. Parallel Execution Rule

Task boleh paralel jika:

- tidak memiliki dependency
- tidak mengubah resource yang sama
- tidak saling conflict

---

# 13. Blocking Rules

Task masuk BLOCKED jika:

- dependency gagal
- requirement belum jelas
- artifact hilang
- approval belum ada

---

# 14. Quality Gate Integration

Setiap status transisi harus melewati:

- QA Gate (functional)
- Review Gate (technical)
- Delivery Gate (final)

---

# 15. Traceability Rule

Setiap task harus bisa ditelusuri ke:

- requirement origin
- system design
- architecture decision
- implementation output

---

# 16. Observability

System harus dapat menjawab:

- siapa mengerjakan task
- kenapa task dibuat
- kenapa task blocked
- apa output task

---

# 17. Definition of Done (Task Level)

Task dianggap DONE jika:

- acceptance criteria terpenuhi
- QA pass
- reviewer approve
- artifact lengkap

---

# 18. System Principle

Task System adalah:

"Single source of execution truth untuk seluruh AI Agents Rogue"

---

# 19. Final Rule

Tidak ada agent boleh:

- lompat tanpa task
- bypass lifecycle
- generate output tanpa tracking

---

# 20. Output Format

Semua agent harus output:

- task_id
- status
- artifact
- next_task

---

# 21. Closing Principle

Tanpa Task System:
AI Agents Rogue = dokumentasi
Dengan Task System:
AI Agents Rogue = mesin produksi software