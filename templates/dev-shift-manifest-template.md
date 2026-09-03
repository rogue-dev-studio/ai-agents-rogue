# Dev Shift Manifest — {Project Name}

> Salin ke `project/{id}/docs/shift/current.md` saat shift dimulai. Update setiap tick.

---

## Meta

| Field | Value |
|-------|-------|
| Shift ID | SHIFT-{YYYY-MM-DD}-{nn} |
| Project ID | {project-id} |
| Status | `active` \| `paused` \| `completed` \| `blocked` |
| Started at | {YYYY-MM-DD HH:mm} {timezone} |
| Ends at | {YYYY-MM-DD HH:mm} |
| Duration budget | {e.g. 8h} |
| Max ticks | {number or unlimited} |
| Ticks completed | 0 |
| Trigger | `prompt` \| `/dev-shift` |
| Shift type | `improvement` \| `maintenance` \| `maintenance+improvement` |
| Mode | `e2e` \| `manual-plan-only` |
| Baseline audit | `pending` \| `in_progress` \| `done` (wajib jika maintenance*) |
| Loop armed | `false` \| `true` |
| Loop interval | {30m default} |
| Next wake at | — |
| Resume prompt ref | `docs/shift/current.md` § Continuation |

---

## Continuation (wajib shift berdurama)

| Field | Value |
|-------|-------|
| `ends_at` | {datetime} — **jangan** `completed` sebelum ini |
| `loop_armed` | false → true setelah arm loop turn pertama |
| `last_tick_at` | — |
| `ticks_this_session` | 0 |

Resume prompt (salin ke `/loop`):

```markdown
Lanjutkan continuous-dev-shift: baca manifest ini, time check, multi-tick, re-arm loop jika ends_at belum tiba.
```

---

## Rules

### Scope

- **Modules allowed:** {all | list modules}
- **Out of scope:** {explicit exclusions}

### Hard stops (default)

- [ ] No production deploy
- [ ] No git commit/push unless user requests
- [ ] Pause on critical business decision
- [ ] Pause if same blocker 3 ticks in a row

### Autonomous pick priority

1. P0 bugs / QA blockers / security findings
2. Backlog `ready` (critical → high → medium → low)
3. Roadmap `Planned` without task
4. Small improvements from impact log
5. **Idle tick** (sweep → regression → perf/consistency → planning) bila waktu sisa

### Idle tick types (manifest)

`fix` · `sweep` · `regression` · `perf` · `consistency` · `planning` · `deferred` — lihat skill `continuous-dev-shift` § Idle tick.

{performance | security | UX | none}

---

## Current tick

| Field | Value |
|-------|-------|
| Tick # | — |
| Task ID | — |
| Title | — |
| Pick reason | — |
| Flow variant | bug \| refactor \| feature \| analysis \| sweep \| regression \| perf \| consistency \| planning \| deferred |
| Assigned roles | — |
| Started tick at | — |

---

## Shift board

| Tick | Task | Flow | QA | Review | Status | Notes |
|------|------|------|----|--------|--------|-------|
| — | — | — | — | — | — | — |

---

## Blockers

| ID | Description | Owner | Since tick |
|----|-------------|-------|------------|
| — | — | — | — |

---

## Handoff (update each tick)

```markdown
**Orchestrator → PO:** …
**PO → PM:** …
**PM → Tech Lead:** …
**Engineering:** …
**QA → Reviewer:** …
**Reviewer → Orchestrator:** …
```

---

## Shift summary (fill on complete)

### Completed

- Tasks done: …
- Artifacts: …

### Partial / deferred

- …

### Impact highlights

- …

### Recommended next shift

1. …
2. …

---

## Links

- Daily log: `docs/shift/shift-{YYYY-MM-DD}.md`
- Backlog: `docs/tasks/backlog.md`
- Roadmap: `docs/planning/roadmap.md`
- Impact log: `docs/planning/impact-log.md`
- Maintenance audit: `docs/shift/maintenance-audit-{YYYY-MM-DD}.md`
