# MCP package: linear

Status: **ready** (auto-wire)

Linear issues/projects via **remote** HTTP MCP.

## Prerequisites

1. Jaringan internet
2. Akun Linear + auth sesuai prompt host

## Setup

Tidak ada app lokal. URL: `https://mcp.linear.app/mcp`.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp linear
```

Restart host AI → selesaikan auth jika diminta.

## Smoke

Minta daftar issue Linear di workspace Anda.

## Upstream

Linear MCP. Catalog: Rogue Development.
