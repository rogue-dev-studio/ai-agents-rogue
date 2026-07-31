# MCP package: photoshop

Control **Adobe Photoshop** from AI hosts via `photoshop-mcp-server` (`uvx`).

Rogue owns this package (fragment + docs + skill). Engine runtime is public PyPI/`uvx` — hybrid model (see [`../README.md`](../README.md#model-runtime-hybrid)).

## Prerequisites

1. Adobe Photoshop desktop installed (set `PS_VERSION`, default `2024`)
2. [uv](https://github.com/astral-sh/uv) / `uvx`
3. Photoshop running when you invoke tools (Windows COM / API path per upstream)

## Wire

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp photoshop
```

Optional: change `PS_VERSION` in the host MCP config (`2025`, `2023`, …).

Restart the AI host after config changes.

## Upstream runtime

- Package: `photoshop-mcp-server`
- Project: https://github.com/loonghao/photoshop-python-api-mcp-server

Catalog: Rogue Development — `NOTICE` / `LICENSE`.
