# MCP packages — AI Agents Rogue

Paket MCP opsional untuk host AI. Skill di `skills/` adalah playbook; paket di sini menyediakan **fragment config**, addon/launcher bila ada, dan panduan runtime.

## Model runtime (hybrid)

Katalog Rogue **berdiri sendiri** di lapisan skill + wiring + install. Engine MCP **tidak** di-vendor penuh ke repo (kecuali addon/launcher lokal seperti Blender).

| Jenis | Contoh | Saat dipakai |
|-------|--------|----------------|
| Remote SaaS | `context7`, `atlassian`, `linear` | URL vendor + jaringan / OAuth |
| Unduh on-demand | `playwright`, `chrome-devtools`, `pal`, `blender-mcp`, `photoshop-mcp-server`, `illustrator-mcp-server` | `npx` / `uvx` (npm / PyPI) |
| Lokal di katalog | addon Blender + `mcp-server/server.js`; OBS stdio + obs-websocket | `mcp/blender/`, `mcp/obs-studio/` |
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
- **obs-studio**: OBS Studio 28+, authenticated obs-websocket on loopback, Node dependencies installed with `npm ci`

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

## Panduan setup per paket

Tiap folder `mcp/<id>/README.md` berisi prerequisites, setup app/addon, wire, dan smoke.

| Id | Setup khas |
|----|------------|
| [`blender`](./blender/README.md) | **Install from Disk** addon + Start Server `:9876` |
| [`photoshop`](./photoshop/README.md) | Photoshop running + `uvx` + `PS_VERSION` |
| [`illustrator`](./illustrator/README.md) | Illustrator running + Node/`npx` |
| [`context7`](./context7/README.md) / [`atlassian`](./atlassian/README.md) / [`linear`](./linear/README.md) | Remote + OAuth/API |
| [`chrome-devtools`](./chrome-devtools/README.md) / [`playwright`](./playwright/README.md) | Node + browser |
| [`pal`](./pal/README.md) | `uvx` + API keys |
| [`obs-studio`](./obs-studio/README.md) | OBS 28+ + local password in host environment; recording/streaming calls require explicit confirmation |
| [`web-data-acquisition`](./web-data-acquisition/README.md) | Docs only; no scraper MCP runtime or provider credentials |
| Partial (`comfyui`, `kicad`, …) | Docs only — lihat README masing-masing |

Remotion, reverse-engineering, security-tooling, and web-data-acquisition entries are intentionally docs-only; see [`remotion`](./remotion/README.md), [`reverse-engineering`](./reverse-engineering/README.md), [`security-tooling`](./security-tooling/README.md), and [`web-data-acquisition`](./web-data-acquisition/README.md). No generic server is implied.

## Attribution

Detail di README tiap paket. Credit catalog: Rogue Development (`NOTICE` / `LICENSE`).
