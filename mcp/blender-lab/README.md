# MCP package: blender-lab

Status: **ready** (auto-wire)

Official **Blender Lab** MCP ([blender.org/lab/mcp-server](https://www.blender.org/lab/mcp-server/)) — not the community stack in `mcp/blender`.

```text
MCP Client  ⇐ MCP/stdio ⇒  blender-mcp (Lab)  ⇐ TCP ⇒  Blender Lab MCP extension
```

Upstream: [projects.blender.org/lab/blender_mcp](https://projects.blender.org/lab/blender_mcp)

## vs `mcp/blender` (community)

| | `blender-lab` (ini) | `blender` (community) |
|--|---------------------|------------------------|
| Origin | Blender Lab | ahujasid / catalog addon |
| Blender | **5.1+** | 3.0+ (4.x OK) |
| In-Blender piece | Extensions → **MCP** (Lab repo) | Add-ons → Blender MCP (disk) |
| Host MCP id | `blender-lab` | `blender` |
| PyPI / install | `git+…#subdirectory=mcp` (package name `blender-mcp`) | `uvx blender-mcp` (PyPI community) |

**Jangan** menjalankan kedua stack sekaligus pada port yang sama (default **9876**). Pilih satu — atau pakai **auto** (disarankan):

```powershell
.\ai-agents-rogue\scripts\install-blender-mcp-auto.ps1 -Target .
```

Deteksi versi Blender: **5.1+** → wire `blender-lab`; else → `blender` (community). Manifest lokal (gitignored): `ai-agents-rogue/active-mcp/blender.json`.

## Prerequisites

1. **Blender 5.1 or newer**
2. [uv](https://github.com/astral-sh/uv) (`uvx`)
3. Blender Lab **MCP** extension installed, enabled, and **listening** (preferences → Start MCP Server)
4. Network once to fetch the MCP server from `projects.blender.org` (first `uvx` run)

## Setup Blender extension (wajib)

Blender tidak mengirim MCP bawaan. Pasang extension resmi:

### A. Otomatis (Blender 5.1+, disarankan)

```powershell
.\ai-agents-rogue\scripts\install-blender-lab-extension.ps1
.\ai-agents-rogue\scripts\install-blender-lab-extension.ps1 -OpenBlender
```

Script: unduh `mcp-*.zip` resmi → `repo-add` Lab → `extension install` (remote) atau `install-file` (ZIP) → enable. Setelah itu **Start MCP Server** di UI (kecuali Auto Start aktif).

### B. Extensions repository (manual)

1. Blender → **Edit → Preferences → Extensions**
2. Add repository (jika belum): `https://lab.blender.org/`
3. Cari / pasang **MCP**, enable
4. Di preferences extension: **Start MCP Server** (default host `localhost`, port **9876**)

Detail UI: [MCP Server — Blender](https://www.blender.org/lab/mcp-server/)

### C. Drag & drop / Install from Disk

Unduh paket extension dari halaman Lab / release repo, lalu Install from Disk sesuai dokumentasi resmi. Drag & drop ke Blender mungkin perlu **dua kali** (tambah repo Lab, lalu install add-on).

## Wire host MCP

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender-lab
```

Fragment memasang entry `blender-lab` yang menjalankan:

```text
uvx --from git+https://projects.blender.org/lab/blender_mcp.git#subdirectory=mcp blender-mcp
```

Env opsional (sudah di fragment):

- `BLENDER_MCP_HOST` — default `localhost`
- `BLENDER_MCP_PORT` — default `9876`

Restart Cursor / host AI setelah wire.

### Alternatif: pip editable / install

```powershell
pip install "git+https://projects.blender.org/lab/blender_mcp.git#subdirectory=mcp"
```

Lalu di `mcp.json` pakai `"command": "blender-mcp"` (pastikan PATH ke entry point itu, dan **bukan** community PyPI `blender-mcp`).

### Alternatif: `.mcpb` bundle

Release assets: [lab/blender_mcp releases](https://projects.blender.org/lab/blender_mcp/releases) (`blender-*.mcpb`). Hanya jika client mendukung MCP Bundle; Cursor wire katalog ini memakai `uvx --from git+…`.

## Security

Official docs: server mengeksekusi kode dari LLM di dalam Blender **tanpa guard**. Gunakan VM / mesin tanpa data sensitif bila ragu.

## Smoke

1. Blender 5.1+: MCP extension **Start** (port 9876 listen)
2. Host: MCP `blender-lab` connected
3. Prompt uji: scene info / rename data-block / explain geometry nodes (lihat contoh di Lab docs)

## Skill

Playbook: `skills/blender` — untuk Lab, wire **`blender-lab`**; untuk Blender &lt; 5.1 tetap pakai `mcp/blender`.
