# MCP package: comfyui (partial)

Status: **partial** — belum auto-wire (`-Mcp all` melewatkan paket ini).

Jalankan [ComfyUI](https://github.com/comfyanonymous/ComfyUI) lokal (GPU disarankan), lalu tambah entry MCP manual bila Anda punya server MCP ComfyUI.

## Prerequisites

1. GPU + driver yang didukung ComfyUI
2. ComfyUI terpasang dan bisa dijalankan
3. Implementasi MCP server ComfyUI (belum di-vendor di katalog Rogue)

## Setup aplikasi

1. Clone/install ComfyUI mengikuti upstream
2. Jalankan UI/server ComfyUI sampai reachable
3. Place MCP server lokal (path Anda sendiri)
4. Tambah `command`/`args` ke `.cursor/mcp.json` (atau host lain)

## Wire (nanti, setelah fragment ada)

```powershell
# Belum tersedia sebagai -Mcp comfyui sampai fragment ditambahkan
```

Sementara: edit MCP config host secara manual. Skill playbook: `skills/comfyui`.

## Smoke

Generate image uji di ComfyUI; pastikan MCP tool terlihat di host jika sudah di-wire.
