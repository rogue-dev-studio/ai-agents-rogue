# Maintenance & Full-Stack Audit — {Project Name}

> Salin ke `project/{id}/docs/shift/maintenance-audit-{YYYY-MM-DD}.md` saat shift **maintenance** dimulai. Update setiap modul selesai diaudit.

Shift type manifest: `maintenance` atau `maintenance+improvement`.

---

## Meta

| Field | Value |
|-------|-------|
| Shift ID | SHIFT-{YYYY-MM-DD}-{nn} |
| Audit started | {datetime} |
| Scope | {all modules \| list} |
| Baseline complete | no \| partial \| yes |

---

## 1. Code & standards (Code Reviewer + Tech Lead)

Skill: `code-review` · Rule: `coding.md`

| Check | Module/Path | Pass | Finding | Severity | Action |
|-------|-------------|------|---------|----------|--------|
| Layering (no UI→DB, no raw SQL outside persistence) | | | | P0–P2 | |
| Naming & folder conventions | | | | | |
| Duplication / dead code | | | | | |
| Error handling at boundaries | | | | | |
| Security basics (authz, input validation) | | | | | |
| Modal/overlay isolation (if UI) | | | | | |

**Legacy code relevance:** masih dipakai? · duplikat fitur baru? · hapus/defer?

---

## 2. Function & regression (QA)

Skill: `agentic-qe`

| Flow / AC | Last known good | Test run | Pass | Regression | Notes |
|-----------|-----------------|----------|------|------------|-------|
| Auth / session | | | | | |
| Core CRUD paths | | | | | |
| API contracts vs consumers | | | | | |
| Integrations (3rd party) | | | | | |
| Error / empty / loading states | | | | | |

Output: `docs/qa/maintenance-{date}.md`

---

## 3. UI / UX / tampilan (UI/UX Designer)

Skill: `ui-ux-design` · Rule: `ui.md`

| Screen / route | Theme aligned | Consistent w/ design system | A11y basics | Empty/loading/error | Pass | Notes |
|----------------|---------------|----------------------------|---------------|----------------------|------|-------|
| | | | | | | |

**Theme gate:** baca `PROJECT.md`, `docs/design/`, token/CSS existing — tolak AI-slop drift.

**Konsistensi antar layar lama:** typography, spacing, button style, table patterns.

Browser smoke (skill `browser-automation`): screenshot/flow P0 routes bila stack web.

Output: `docs/design/maintenance-ui-{date}.md` (ringkas)

---

## 4. Performance (Engineering + observability)

Skills: `observability-engineering`, stack skills (BE/FE)

| Area | Signal | Baseline | Threshold | Pass | Finding |
|------|--------|----------|-----------|------|---------|
| API hot paths (p95 smoke) | | | | | |
| DB queries (N+1, missing index) | | | | | |
| Frontend bundle / LCP smoke | | | | | |
| Background jobs / cron | | | | | |
| Log noise / missing correlation id | | | | | |

Tidak perlu load test penuh — cukup smoke + red flags terdokumentasi.

---

## 5. Relevance & product fit (Product Owner)

| Feature / module | Still in roadmap? | User value today | Recommend |
|------------------|-------------------|------------------|-----------|
| | yes/no | high/med/low | keep \| improve \| deprecate \| backlog |

Selaraskan `docs/planning/roadmap.md` dan backlog.

---

## 6. Cross-module consistency matrix

| Dimension | Module A | Module B | Consistent? | Fix owner |
|-----------|----------|----------|-------------|-----------|
| API error envelope | | | | |
| Pagination pattern | | | | |
| Form validation UX | | | | |
| Date/time display | | | | |
| Permission messaging | | | | |

---

## 7. Findings → backlog (PM)

| Finding ID | Source § | Priority | Effort | TASK-ID / issue | Status |
|------------|----------|----------|--------|-----------------|--------|
| MAINT-001 | 1/code | | S/M/L | | todo |

Prioritas pick shift maintenance: **P0 audit findings** → open QA → backlog ready.

---

## 8. Sign-off (per shift segment)

| Gate | Role | Verdict | Date |
|------|------|---------|------|
| Code standards | Code Reviewer | pass \| rework | |
| Function / regression | QA | pass \| rework | |
| UI/UX / theme | UI/UX Designer | pass \| rework | |
| Performance smoke | Tech Lead | pass \| defer | |
| Product relevance | Product Owner | pass \| defer | |
| Shift Coordinator | Shift Coordinator | tick continue \| stop | |

Tick **tidak** `done` jika gate wajib maintenance belum pass atau finding P0 terbuka tanpa defer tertulis.
