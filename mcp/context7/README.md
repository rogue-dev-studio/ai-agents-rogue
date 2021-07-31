# MCP package: context7

Status: **ready** (auto-wire)

Dokumentasi library terkini via **remote** Context7 MCP.

## Prerequisites

1. Jaringan internet
2. (Opsional) API key dari https://context7.com/dashboard

## Setup

Tidak ada app lokal. Remote URL: `https://mcp.context7.com/mcp`.

Opsional: set `CONTEXT7_API_KEY` dan header di file MCP host setelah wire.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp context7
```

Restart host AI. Auth/OAuth sesuai prompt host bila diminta.

## Smoke

Minta docs untuk library yang dikenal (mis. React) via agent.

## Upstream

[upstash/context7](https://github.com/upstash/context7). Catalog: Rogue Development.
