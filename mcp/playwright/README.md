# MCP package: playwright

Status: **ready** (auto-wire)

Browser E2E / automation via `npx @playwright/mcp`.

## Prerequisites

1. Node.js 18+
2. First run boleh mengunduh browser Playwright

## Setup

1. `node -v` (≥ 18)
2. Wire MCP (di bawah)
3. Jika browser belum ada:

```powershell
npx playwright install
```

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp playwright
```

Restart host AI.

## Smoke

Minta navigasi ke URL uji dan ambil title / screenshot via agent.

## Upstream

`@playwright/mcp` (npm). Catalog: Rogue Development.
