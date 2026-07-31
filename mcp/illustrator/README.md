# MCP package: illustrator

Control **Adobe Illustrator** from AI hosts via `illustrator-mcp-server` (`npx`).

Rogue owns this package (fragment + docs + skill). Engine runtime is public npm/`npx` — hybrid model (see [`../README.md`](../README.md#model-runtime-hybrid)).

## Prerequisites

1. Adobe Illustrator desktop installed (ideally running)
2. Node.js 18+
3. macOS/Windows per upstream bridge (ExtendScript / OS automation)

## Wire

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp illustrator
```

Restart the AI host after config changes.

## Upstream runtime

- Package: `illustrator-mcp-server`
- Project: https://github.com/ie3jp/illustrator-mcp-server

Catalog: Rogue Development — `NOTICE` / `LICENSE`.
