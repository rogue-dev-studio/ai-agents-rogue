# Template Planning

Salin ke folder: `docs/planning/`

---

# Product Roadmap — {Project Name}

Version: 1.0.0
Last Updated: {YYYY-MM-DD}
Owner: product-owner

| ID | Feature | Priority | MVP | Phase | Status | Owner Agent | SRS Ref | Target Sprint |
|----|---------|----------|-----|-------|--------|-------------|---------|---------------|
| F-001 | Project Setup | Critical | Yes | 1 | Planned | devops-engineer | — | Sprint 0 |
| F-002 | Authentication | Critical | Yes | 1 | Planned | product-owner | SRS-auth-v1.0.0.md | Sprint 1 |
| F-003 | {Feature} | High | Yes | 1 | Planned | product-owner | SRS-{module}-v1.0.0.md | Sprint 2 |

---

# Work Breakdown Structure — {Project Name}

Version: 1.0.0
Owner: project-manager

| WBS ID | Epic | Feature | Sub Feature | Agent | Effort | Dependency | SRS Ref |
|--------|------|---------|-------------|-------|--------|------------|---------|
| 0.1 | Setup | Docker | Compose setup | DevOps Engineer | S | — | — |
| 0.2 | Setup | Database | Initial migration | Database Engineer | S | 0.1 | — |
| 1.1 | Auth | Login | Migration users | Database Engineer | S | 0.2 | SRS-auth |
| 1.2 | Auth | Login | API login | Backend Developer | M | 1.1 | SRS-auth |
| 1.3 | Auth | Login | UI login page | Frontend Developer | M | 1.2 | SRS-auth |
| 1.4 | Auth | Login | QA login flow | QA Engineer | S | 1.3 | SRS-auth |

---

# Milestone Tracker — {Project Name}

Version: 1.0.0
Owner: project-manager

| Milestone | Target Date | Status | Deliverables | Blocker |
|-----------|-------------|--------|--------------|---------|
| M0 — Project Setup | {date} | Planned | Docker, DB, skeleton app | — |
| M1 — Authentication | {date} | Planned | SRS, API, UI Login | — |
| M2 — {Module} | {date} | Planned | SRS, API, UI | — |
| M3 — QA & Release | {date} | Planned | Test report, release package | — |

---

# Timeline — {Phase/Sprint Range}

Version: 1.0.0
Owner: project-manager

| Week | Phase | Agent | Focus | Output Artifact |
|------|-------|-------|-------|-----------------|
| W1 | Analysis | Business Analyst, System Analyst | Requirement | SRS draft |
| W2 | Planning | Product Owner, Project Manager | Roadmap & WBS | Planning docs |
| W3 | Architecture | Solution Architect, Tech Lead | Design teknis | Architecture + Tech Spec |
| W4 | Development | Engineering | Implementation | Code |
| W5 | Quality | QA, Code Reviewer, Security | Testing & audit | QA + Security report |
| W6 | Release | Delivery Manager, Technical Writer | Docs & release | Release package |

---

# Dependency Map — {Project Name}

Version: 1.0.0
Owner: project-manager

| From | To | Type | Notes |
|------|----|------|-------|
| SRS-auth | Planning WBS 1.x | Hard | WBS auth butuh SRS approved |
| TASK-001 migration | TASK-002 API | Hard | API butuh tabel users |
| TASK-002 API | TASK-003 UI | Hard | UI butuh API contract |
| Design System | UI mockup | Hard | Mockup pakai component DS |
| Backend + Frontend | TASK-QA | Hard | QA butuh implementasi |

---

# Risk Register — {Project Name}

Version: 1.0.0
Owner: project-manager

| ID | Risk | Impact | Probability | Mitigation | Owner |
|----|------|--------|-------------|------------|-------|
| R-001 | Requirement berubah mid-sprint | High | Medium | Freeze scope per sprint | Product Owner |
| R-002 | Dependency task terlambat | High | Medium | Buffer di timeline | Project Manager |
| R-003 | API contract belum final | High | Low | Tech Lead sign-off sebelum FE start | Tech Lead |
