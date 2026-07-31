# MCP package: imagemagick (partial)

Status: **partial** — docs only.

## Prerequisites

1. ImageMagick terpasang di OS (`magick -version`)
2. (Opsional) MCP server ImageMagick lokal bila Anda punya

## Setup aplikasi

### Windows

Install dari https://imagemagick.org/ (centang “Add to PATH” bila ada).

### Linux / macOS

```bash
# contoh
sudo apt install imagemagick   # Debian/Ubuntu
brew install imagemagick       # macOS
```

## Wire

Belum ada fragment auto-wire. Skill playbook CLI: `skills/imagemagick`.  
Jika ada MCP server lokal, tambahkan manual ke config host.

## Smoke

```powershell
magick -version
```
