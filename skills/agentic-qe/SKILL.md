---
name: agentic-qe
description: >-
  Canonical quality engineering: test strategy, case generation, coverage
  gates, exploratory checks, and security-tinged QA (incl. Shannon-style
  pentest track when requested).
---

# Agentic QE — Quality Engineering (Canonical)

**Level: max.** Alias khusus: `shannon` (jalur pentest otonom — tetap butuh izin untuk tes agresif).

## When to use

- Setelah implementasi / sebelum release
- Minta test plan, generate tests, coverage, bug report
- Validasi AC dari `clarity`

## Procedure

### 1. Intake

AC/FR, diff area, risiko (auth, data, money).

### 2. Strategy matrix

| Layer | Kapan |
|-------|--------|
| Unit | logic murni |
| Integration | API/DB boundaries |
| E2E | pakai `browser-automation` untuk P0 UI |
| Exploratory | UX ambigu |
| Security smoke | authz, injection basics; deep pentest → track `shannon` + izin user |

### 3. Cases

ID, precondition, steps, expected, priority P0–P2. Map AC → case IDs.

### 4. Implement & run

- Ikuti test runner project
- Catat perintah + hasil di `project/{id}/docs/qa/`

### 5. Gate

- P0 covered
- S1/S2 tidak terbuka tanpa keputusan user
- Blocker env dijelaskan (bukan silent skip)

## Bug template

```markdown
### Bug: <title>
- Severity: S1-S4
- AC:
- Steps:
- Expected / Actual:
- Area:
```

## DoD

- [ ] Matrix AC×tests
- [ ] P0 executed atau blocker jelas
- [ ] Laporan di docs/qa
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
