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
