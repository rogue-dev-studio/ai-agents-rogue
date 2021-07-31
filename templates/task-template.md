# Template Task

Salin ke folder: `docs/tasks/`

---

# Backlog — {Project Name}

Version: 1.0.0
Owner: project-manager

| ID | Title | Type | Priority | Epic | Agent | Effort | Status |
|----|-------|------|----------|------|-------|--------|--------|
| TASK-001 | Setup docker compose | feature | Critical | EPIC-000 Setup | devops-engineer | S | todo |
| TASK-002 | Migration users table | feature | Critical | EPIC-001 Auth | database-engineer | S | todo |
| TASK-003 | API POST /login | feature | Critical | EPIC-001 Auth | backend-developer | M | todo |
| TASK-004 | UI Login page | feature | Critical | EPIC-001 Auth | frontend-developer | M | todo |
| TASK-005 | QA Auth module | feature | High | EPIC-001 Auth | qa-engineer | S | todo |

---

# Sprint 01 Board

Period: {YYYY-MM-DD} — {YYYY-MM-DD}
Goal: {Sprint goal — contoh: Selesaikan modul Authentication}
Owner: project-manager

## Todo

| ID | Title | Agent | Priority | Effort | Dependency |
|----|-------|-------|----------|--------|------------|
| TASK-001 | Setup docker compose | devops-engineer | Critical | S | — |

## In Progress

| ID | Title | Agent | Started | Blocker |
|----|-------|-------|---------|---------|

## Review

| ID | Title | Agent | Reviewer |
|----|-------|-------|----------|

## QA

| ID | Title | Agent | QA |
|----|-------|-------|-----|

## Done

| ID | Title | Agent | Completed |
|----|-------|-------|-----------|

---

# TASK-001 — Setup docker compose

Salin format ini per task ke: `docs/tasks/tasks/TASK-001.md`

| Field | Value |
|-------|-------|
| ID | TASK-001 |
| Title | Setup docker compose |
| Type | feature |
| Priority | critical |
| Status | todo |
| Assigned Agent | devops-engineer |
| Effort | S |
| Sprint | sprint-01 |
| Epic | EPIC-000 Setup |

## Description

Menyiapkan Docker Compose untuk menjalankan backend (Laravel), frontend, dan PostgreSQL secara lokal.

## Input Artifacts

- docs/architecture/deployment-concept.md
- docs/planning/wbs.md (WBS 0.1)

## Output Artifacts

- docker/docker-compose.yml
- docker/Dockerfile.backend
- docker/Dockerfile.frontend
- .env.example
- docs/devops/local-setup.md

## Acceptance Criteria

- [ ] `docker compose up -d` berhasil tanpa error
- [ ] Backend accessible di port 8000
- [ ] Frontend accessible di port 5173
- [ ] PostgreSQL accessible dan persistent volume aktif
- [ ] `.env.example` lengkap tanpa secret asli
- [ ] Dokumentasi local-setup.md dapat diikuti developer baru

## Dependencies

- — (no dependency)

## Traceability

| SRS Ref | FR/NFR | Planning Ref |
|---------|--------|--------------|
| — | — | WBS 0.1 |

## Notes

Task ini harus selesai sebelum task development lainnya.

---

# TASK-002 — Migration users table

| Field | Value |
|-------|-------|
| ID | TASK-002 |
| Title | Migration users table |
| Type | feature |
| Priority | critical |
| Status | todo |
| Assigned Agent | database-engineer |
| Effort | S |
| Sprint | sprint-01 |
| Epic | EPIC-001 Auth |

## Description

Membuat migration tabel users sesuai SRS Authentication.

## Input Artifacts

- docs/srs/{project}/SRS-auth-v1.0.0.md (Section 8 Data Requirement)
- docs/architecture/database-design.md

## Output Artifacts

- backend/database/migrations/xxxx_create_users_table.php

## Acceptance Criteria

- [ ] Migration up/down berjalan tanpa error
- [ ] Kolom sesuai database design
- [ ] Index unique pada email
- [ ] Foreign key (jika ada) terdefinisi benar

## Dependencies

- TASK-001 — done

## Traceability

| SRS Ref | FR/NFR | Planning Ref |
|---------|--------|--------------|
| SRS-auth-v1.0.0.md | FR-001 | WBS 1.1 |

## Notes

---

# Epic Reference

| Epic ID | Name | SRS Ref | Status |
|---------|------|---------|--------|
| EPIC-000 | Project Setup | — | Planned |
| EPIC-001 | Authentication | SRS-auth-v1.0.0.md | Planned |
