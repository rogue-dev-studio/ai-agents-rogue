# MCP catalog

Nilai `-Mcp`: `none` (default), satu id, daftar dipisah koma, atau `all` (= semua yang punya `cursor.mcp.fragment.json`).

Runtime: hybrid — fragment Rogue + engine via `npx`/`uvx`/URL remote (lihat [README.md](./README.md#model-runtime-hybrid)).  
Indeks kegunaan: [`../INDEX.md`](../INDEX.md#mcp-packages).

## Ready (auto-wire)

| Id | Skill terkait | Runtime |
|----|---------------|---------|
| `linkedin` | `linkedin-ops` | Node.js MCP server in `mcp/linkedin` |
| `blender` | `blender` | Blender + addon + `uvx blender-mcp` |
| `blender-lab` | `blender` | Blender 5.1+ Lab extension + `uvx` from projects.blender.org |
| `photoshop` | `photoshop` | Photoshop desktop + `uvx photoshop-mcp-server` |
| `illustrator` | `illustrator` | Illustrator desktop + `npx illustrator-mcp-server` |
| `context7` | `mcp-integrations` | Remote HTTP Context7 |
| `atlassian` | `mcp-integrations` | Remote SSE Atlassian/Jira |
| `linear` | `mcp-integrations` | Remote HTTP Linear |
| `chrome-devtools` | `browser-automation` | `npx chrome-devtools-mcp` |
| `playwright` | `browser-automation` | `npx @playwright/mcp` |
| `pal` | `mcp-integrations` | `uvx pal-mcp-server` + API keys |
| `youtube` | `youtube-publishing` | Node MCP proxy → local YouTube OAuth API |
| `obs-studio` | `obs-studio` | First-party Node stdio MCP → authenticated loopback obs-websocket |

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
| `remotion` | `remotion-*` | Remotion CLI/Studio and browser workflow; no generic first-party MCP |
| `reverse-engineering` | `reverse-engineer-anything`, `reverse-skill` | Tool-specific integrations only; no generic first-party MCP |
| `security-tooling` | `appsec`, `cloud-security`, `security-operations`, `vulnerability-management` | Documentation and routing only; no first-party scanner, cloud auditor, SIEM, or pentest MCP runtime |
| `web-data-acquisition` | `web-data-acquisition`, `browser-automation` | Documentation only; no scraper server, actor runtime, provider credentials, proxy service, or anti-bot bypass |
| `svg-vector-designer` | `svg-vector-designer` | Documentation only; no vector editor runtime implied |
| `youtube-content-specialist` | `youtube-publishing` | Documentation only; upload gate via `youtube-publishing` MCP/local API with explicit confirm |

Contoh:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender,playwright,context7
.\ai-agents-rogue\scripts\install-blender-mcp-auto.ps1 -Target .
```
