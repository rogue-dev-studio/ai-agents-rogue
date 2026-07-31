# MCP package template

Salin folder ini menjadi `mcp/<id>/` lalu lengkapi.

## Checklist README paket baru

Setiap `mcp/<id>/README.md` wajib memuat:

1. **Status** — `ready` (ada fragment) atau `partial`
2. **Prerequisites** — OS/app/runtime
3. **Setup aplikasi** — langkah instal app/addon (termasuk Install from Disk bila relevan)
4. **Wire host MCP** — perintah `install-mcp.ps1`
5. **Smoke** — cara verifikasi singkat
6. **Upstream** — link runtime publik (bila hybrid)

## Langkah paket

1. Copy `_template/` → `mcp/<id>/`
2. Fill `package.json`, `README.md`, `cursor.mcp.fragment.json`
3. Add runtime assets (addon/server) as needed
4. Register in `mcp/CATALOG.md` + `INDEX.md`
5. Point related `skills/<id>/SKILL.md` at this package
