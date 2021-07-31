# MCP package: blender

Status: **ready** (auto-wire)

Control **Blender** from AI hosts via BlenderMCP (addon socket **9876** + `blender-mcp` / node launcher).

## Prerequisites

1. Blender 3.0+ (4.x recommended)
2. `uv` / `uvx` **or** Node.js 18+ (fallback launcher `mcp-server/server.js`)
3. Addon **Blender MCP** installed and **Start Server** running

## Setup aplikasi (wajib — bukan bawaan Blender)

Blender MCP **tidak** ikut install Blender. Pasang addon dari katalog:

### A. Install from Disk (disarankan)

1. Blender → **Edit → Preferences → Add-ons**
2. **Install…** / **Install from Disk**
3. Pilih file:

   `ai-agents-rogue/mcp/blender/addon/blender_mcp_addon.py`

4. Enable / centang **Blender MCP**
5. Di 3D View tekan **N** → panel **Blender MCP** → **Start Server**
6. Pastikan server listen di port **9876**

### B. Script installer

```powershell
python .\ai-agents-rogue\mcp\blender\addon\install-addon.py
```

Sesuaikan versi Blender jika perlu (`--blender-version 4.2`, dll.).

### C. Copy manual (Windows)

Sesuaikan folder versi (`4.2`, `4.3`, …):

```powershell
copy .\ai-agents-rogue\mcp\blender\addon\blender_mcp_addon.py "$env:APPDATA\Blender Foundation\Blender\4.2\scripts\addons\"
```

Lalu enable di Preferences → Add-ons → **Blender MCP** → **Start Server**.

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender
```

Restart Cursor / host AI.

## Cek port 9876

```powershell
Get-NetTCPConnection -LocalPort 9876 -State Listen
# atau: netstat -ano | findstr ":9876"
```

Kosong = server belum Start di Blender.

## Smoke

1. Blender: Start Server  
2. Host: MCP `blender` connected  
3. Minta agent: scene info / buat cube / model sederhana  

## Upstream runtime

- `blender-mcp` / [ahujasid/blender-mcp](https://github.com/ahujasid/blender-mcp)  
- Addon + launcher di paket ini: Rogue Development — `NOTICE` / `LICENSE`
