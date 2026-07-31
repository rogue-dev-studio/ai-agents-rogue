# MCP packages — AI Agents Rogue

Paket MCP opsional untuk host AI. Skill di `skills/` adalah playbook; paket di sini menyediakan **fragment config**, addon/launcher bila ada, dan panduan runtime.

## Model runtime (hybrid)

Katalog Rogue **berdiri sendiri** di lapisan skill + wiring + install. Engine MCP **tidak** di-vendor penuh ke repo (kecuali addon/launcher lokal seperti Blender).

| Jenis | Contoh | Saat dipakai |
|-------|--------|----------------|
| Remote SaaS | `context7`, `atlassian`, `linear` | URL vendor + jaringan / OAuth |
| Unduh on-demand | `playwright`, `chrome-devtools`, `pal`, `blender-mcp`, `photoshop-mcp-server`, `illustrator-mcp-server` | `npx` / `uvx` (npm / PyPI) |
| Lokal di katalog | addon Blender + `mcp-server/server.js` | Sudah ada di `mcp/blender/` |
| Partial | `comfyui`, `kicad`, … | Docs saja sampai ada fragment + runtime stabil |

Jangan harapkan mode offline penuh sebagai default. Mode vendored/air-gapped hanya jika nanti ditambah secara eksplisit.

## Host targets

| Host | Config yang di-merge |
|------|----------------------|
| Cursor | `.cursor/mcp.json` (`mcpServers`) |
| Claude Code | `.mcp.json` di project root (`mcpServers`) |
| OpenCode | `opencode.json` → `mcp.servers` (local/remote) |
| Antigravity / generic | `.agents/mcp.json` (`mcpServers`, portable) |

## Prasyarat umum

- Paket **npx**: Node.js 18+
- Paket **uvx**: [uv](https://github.com/astral-sh/uv)
- Paket **remote**: jaringan + OAuth/API key sesuai README paket
- **blender**: Blender 3+ + addon (`mcp/blender`)
- **photoshop** / **illustrator**: Adobe desktop app + lisensi valid

## Install

```powershell
# Semua host + semua paket ready
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts all

# Hanya Cursor + Claude
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender,playwright -Hosts cursor,claude

# Via install.ps1 (MCP hosts mengikuti -Hosts)
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Mcp all
```

Paket **partial** tidak di-wire oleh `-Mcp all`. Lihat [CATALOG.md](./CATALOG.md).

## Attribution

Detail di README tiap paket. Credit catalog: Rogue Development (`NOTICE` / `LICENSE`).
