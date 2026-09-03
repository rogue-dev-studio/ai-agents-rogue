# Templates

Starter template untuk artifact AI Agents Rogue.

Salin template ke project target saat memulai project baru.

---

## Daftar Template

| Template | Analogi | Salin Ke | Agent Owner |
|----------|---------|----------|-------------|
| [srs-template.md](./srs-template.md) | PDF formal | `docs/srs/{project}/` | Business Analyst, System Analyst |
| [planning-template.md](./planning-template.md) | Spreadsheet | `docs/planning/` | Product Owner, Project Manager |
| [task-template.md](./task-template.md) | Jira board | `docs/tasks/` | Project Manager, Tech Lead |
| [dev-shift-prompt-template.md](./dev-shift-prompt-template.md) | Shift prompt | Chat (copy-paste) | AI Orchestrator |
| [dev-shift-command-template.md](./dev-shift-command-template.md) | Shift command | `/dev-shift` | AI Orchestrator |
| [dev-shift-manifest-template.md](./dev-shift-manifest-template.md) | Shift state | `docs/shift/current.md` | Shift Coordinator |
| [impact-log-template.md](./impact-log-template.md) | Impact per tick | `docs/planning/impact-log.md` | PO + Shift Coordinator |
| [maintenance-audit-template.md](./maintenance-audit-template.md) | Full-stack audit | `docs/shift/maintenance-audit-{date}.md` | Shift Coordinator + QA + UI/UX |

---

## Dev shift (continuous autonomous)

Skill: `continuous-dev-shift` · Command: `/dev-shift` · Rule: `rules/shift.md` · Role: `shift-coordinator.md`

Salin prompt dari `dev-shift-prompt-template.md` **atau** jalankan command dari `dev-shift-command-template.md`. Manifest aktif → `docs/shift/current.md`.

---

## Urutan Penggunaan

```
1. srs-template.md      → Isi requirement (BA + SA)
2. planning-template.md → Buat roadmap & WBS (PO + PM)
3. task-template.md     → Breakdown ke sprint & task (PM + Tech Lead)
4. Development          → Engineer implement code
```

---

## Referensi

- Artifact system: `core/artifact-system.md`
- Delivery flow: `core/delivery-flow.md`
- Task lifecycle: `core/task-system.md`
- Agent definitions: `AGENTS.md`
