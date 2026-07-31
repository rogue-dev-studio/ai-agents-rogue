# MCP package: photoshop

Status: **ready** (auto-wire)

Control **Adobe Photoshop** via `uvx photoshop-mcp-server`.

## Prerequisites

1. Adobe Photoshop desktop terpasang (lisensi valid)
2. [uv](https://github.com/astral-sh/uv) / `uvx` di PATH
3. Photoshop **sedang berjalan** saat tool dipanggil (Windows COM/API)

## Setup aplikasi

1. Install Photoshop dari Adobe Creative Cloud (versi sesuai `PS_VERSION`, default **2024**)
2. Buka Photoshop sekali dan biarkan running
3. Install `uv` jika belum: https://github.com/astral-sh/uv

Tidak ada “Install from Disk” di Photoshop — runtime MCP diunduh on-demand oleh `uvx`.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp photoshop
```

Opsional: ubah `PS_VERSION` di `.cursor/mcp.json` (atau host lain) ke `2025` / `2023` sesuai install Anda.

Restart host AI.

## Smoke

1. Photoshop terbuka  
2. MCP `photoshop` connected  
3. Minta agent: info dokumen / buat layer uji  

## Upstream runtime

- Package: `photoshop-mcp-server`  
- https://github.com/loonghao/photoshop-python-api-mcp-server  

Catalog: Rogue Development — `NOTICE` / `LICENSE`.
