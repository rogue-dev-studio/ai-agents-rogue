# MCP package: chrome-devtools

Status: **ready** (auto-wire)

Inspect / automate Chromium via `npx chrome-devtools-mcp`.

## Prerequisites

1. Node.js 18+
2. Browser Chromium-based (Chrome / Edge / dll.)
3. (Opsional) `CHROME_PATH` jika binary tidak di PATH default

## Setup aplikasi

1. Install Chrome atau Edge
2. `node -v` (≥ 18)
3. Tidak ada plugin “Install from Disk” — MCP diunduh oleh `npx`

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp chrome-devtools
```

Opsional di env MCP: `CHROME_PATH=C:\Path\To\chrome.exe`

Restart host AI.

## Smoke

Minta buka URL uji / ambil snapshot halaman.

## Upstream

`chrome-devtools-mcp` (npm). Catalog: Rogue Development.
