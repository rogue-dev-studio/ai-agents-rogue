# MCP catalog

Nilai `-Mcp`: `none` (default), satu id, daftar dipisah koma, atau `all` (= semua yang punya `cursor.mcp.fragment.json`).

Runtime: hybrid — fragment Rogue + engine via `npx`/`uvx`/URL remote (lihat [README.md](./README.md#model-runtime-hybrid)).  
Indeks kegunaan: [`../INDEX.md`](../INDEX.md#mcp-packages).

## Ready (auto-wire)

| Id | Skill terkait | Runtime |
|----|---------------|---------|
| `blender` | `blender` | Blender + addon + `uvx blender-mcp` |
| `photoshop` | `photoshop` | Photoshop desktop + `uvx photoshop-mcp-server` |
| `illustrator` | `illustrator` | Illustrator desktop + `npx illustrator-mcp-server` |
| `context7` | `mcp-integrations` | Remote HTTP Context7 |
| `atlassian` | `mcp-integrations` | Remote SSE Atlassian/Jira |
| `linear` | `mcp-integrations` | Remote HTTP Linear |
| `chrome-devtools` | `browser-automation` | `npx chrome-devtools-mcp` |
| `playwright` | `browser-automation` | `npx @playwright/mcp` |
| `pal` | `mcp-integrations` | `uvx pal-mcp-server` + API keys |

## Partial (docs only — no fragment yet)

| Id | Skill terkait | Catatan |
|----|---------------|---------|
| `comfyui` | `comfyui` | GPU + ComfyUI + MCP server (vendor locally) |
| `imagemagick` | `imagemagick` | OS ImageMagick + optional MCP server |
| `jupyter` | `jupyter-notebooks` | Jupyter + MCP server |
| `kicad` | `kicad` | KiCad desktop + MCP |
| `ngspice` | `ngspice` | NGSpice + MCP |
| `qgis` | `qgis` | QGIS desktop + MCP |
| `pbr-rendering` | `pbr-rendering` | GPU + Blender MCP |
| `mcp-builder` | `skill-authoring` | Scaffold MCP (`mcp/_template`) |

Contoh:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender,playwright,context7
```
