# MCP package: illustrator

Status: **ready** (auto-wire)

Control **Adobe Illustrator** via `npx illustrator-mcp-server`.

## Prerequisites

1. Adobe Illustrator desktop terpasang (lisensi valid)
2. Node.js 18+ (`npx`)
3. Illustrator idealnya **running** (ExtendScript / OS automation)

## Setup aplikasi

1. Install Illustrator dari Adobe Creative Cloud
2. Buka Illustrator
3. Pastikan Node.js: `node -v` (18+)

Tidak ada addon “Install from Disk” di paket Rogue — bridge mengikuti upstream npm.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp illustrator
```

Restart host AI. First run `npx` akan unduh paket.

## Smoke

1. Illustrator terbuka  
2. MCP `illustrator` connected  
3. Minta agent: baca dokumen / export uji  

## Upstream runtime

- Package: `illustrator-mcp-server`  
- https://github.com/ie3jp/illustrator-mcp-server  

Catalog: Rogue Development — `NOTICE` / `LICENSE`.
