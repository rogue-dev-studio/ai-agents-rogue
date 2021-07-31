---
name: browser-automation
description: >-
  Canonical browser automation and web UI verification: Playwright, agent
  browser CLIs, and CDP-based tooling in one playbook.
---

# Browser Automation (Canonical)

**Level: max.** Aliases: `playwright`, `agent-browser`.

## When to use

- E2E / smoke UI, regresi alur kritis
- Agent perlu klik/isi form / snapshot halaman
- Debug front-end di browser nyata

## Tool map

| Situasi | Pilih |
|---------|--------|
| Tes otomatis di repo (default) | Playwright (project runner) |
| Agent explorasi cepat | `agent-browser` / snapshot CLI |
| MCP / CDP remote | `mcp/chrome-devtools` atau `mcp/playwright` (`install-mcp.ps1`) |
| Suite QA web app | Playwright project + matrix P0 |

Wire MCP:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp playwright,chrome-devtools
```

## Procedure

### 1. Scope

- Daftar user journey P0 (max 5 dulu)
- Data uji fiktif (jangan PII nyata)
- Environment: local/staging URL dari project

### 2. Stabilize selectors

- Prefer role/label/test-id, hindari CSS rapuh
- Tunggu network/DOM idle sebelum assert

### 3. Author tests / scripts

- Satu file per journey atau describe block jelas
- Screenshot on failure
- Tidak sleep tetap kecuali terpaksa + komen alasan

### 4. Run & triage

- Jalankan subset P0 dulu
- Fail → klasifikasi: product bug vs flaky vs env
- Flaky: quarantine + issue, jangan diabaikan diam-diam

### 5. Report

Tulis ke `project/{id}/docs/qa/`:

- Matrix journey × hasil
- Artifact path (trace/video jika ada)
- Gap coverage

## DoD

- [ ] P0 journeys punya otomasi atau manual steps eksplisit
- [ ] Hasil run tercatat
- [ ] Tidak ada secret di script
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
