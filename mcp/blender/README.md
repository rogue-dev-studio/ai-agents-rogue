# MCP package: blender

Control Blender from Cursor via [BlenderMCP](https://github.com/ahujasid/blender-mcp) (addon socket + `blender-mcp` MCP server).

## Source

- MCP protocol package: `blender-mcp` / ahujasid — install via `uvx` or pip (not vendored as binary here).
- Addon + launcher in this package: Rogue Development — see repo `NOTICE` / `LICENSE`.

## Prerequisites

1. **Blender** 3.0+ (4.x recommended) installed on the machine  
2. **`uv`** (provides `uvx`) **or** `pip install blender-mcp`  
3. Enable the addon and start its server (port **9876**)

## Install addon

```powershell
# From catalog root or after install-mcp
python ai-agents-rogue\mcp\blender\addon\install-addon.py
```

Or Blender UI: Preferences → Add-ons → Install → select `addon/blender_mcp_addon.py` → enable **Blender MCP** → sidebar (N) → **Start Server**.

Windows manual copy example (adjust version):

```powershell
copy ai-agents-rogue\mcp\blender\addon\blender_mcp_addon.py "$env:APPDATA\Blender Foundation\Blender\4.2\scripts\addons\"
```

## Wire Cursor MCP

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender
```

Merges `cursor.mcp.fragment.json` into `.cursor/mcp.json` (prefers `uvx blender-mcp`).  
If `uvx` is missing, use the node launcher fragment manually or install uv.

Restart Cursor after changing `mcp.json`.

## Smoke

1. Open Blender → Start Server (9876)  
2. Cursor MCP shows `blender` connected  
3. Ask agent to get scene info / create a cube  

## Optional tools

- `tools/blender-mcp-proxy.js` — Docker/GUI proxy; not required for local desktop  
- `mcp-server/server.js` — Windows-friendly launcher if Cursor should call `node` instead of `uvx`
