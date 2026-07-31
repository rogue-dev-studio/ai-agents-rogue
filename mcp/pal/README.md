# MCP package: pal

Status: **ready** (auto-wire)

Provider Abstraction Layer via `uvx pal-mcp-server`.

## Prerequisites

1. [uv](https://github.com/astral-sh/uv) / `uvx`
2. API key provider sesuai docs PAL (OpenAI, Anthropic, dll.)

## Setup

1. Install `uv`
2. Siapkan env key (jangan commit ke git), mis. di env MCP host atau `.env` lokal yang di-ignore
3. Baca docs upstream untuk nama variabel yang wajib

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp pal
```

Tambahkan key ke konfigurasi MCP host. Restart host AI.

## Smoke

Panggil tool PAL sederhana setelah key valid.

## Upstream

[pal-mcp-server](https://github.com/BeehiveInnovations/pal-mcp-server). Catalog: Rogue Development.
