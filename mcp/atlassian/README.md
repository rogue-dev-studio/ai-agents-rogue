# MCP package: atlassian

Status: **ready** (auto-wire)

Atlassian Rovo MCP (Jira/Confluence) over **SSE** + OAuth di host.

## Prerequisites

1. Jaringan internet
2. Akun Atlassian dengan akses situs/project yang relevan

## Setup

Tidak ada app lokal. Host akan meminta login OAuth saat pertama connect.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp atlassian
```

Restart host AI → selesaikan OAuth jika diminta.

## Smoke

Minta daftar issue / cari Confluence page yang Anda punya aksesnya.

## Upstream

Atlassian remote MCP. Catalog: Rogue Development.
