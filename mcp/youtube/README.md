# YouTube MCP

Status: **ready**

Proxy MCP ke **YouTube OAuth upload API lokal** (service HTTP di mesin developer). Upload **hanya manual** (`confirm: true`).

## Prerequisites

- Node.js 20+
- Local API service running (default `http://127.0.0.1:8787`)
- Google Cloud OAuth + YouTube Data API v3 enabled
- `.env` on the API service (client id/secret, redirect) — **never commit secrets**

Reference implementation may live in your app repo under `services/youtube-api/`; this MCP only proxies HTTP.

## Wire host MCP

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp youtube
```

Restart Cursor. Set `YOUTUBE_API_URL` in fragment env if your API is not on `:8787`.

## Tools

| Tool | Fungsi |
|------|--------|
| `youtube_auth_status` | Cek OAuth + channel |
| `youtube_start_auth` | URL login Google |
| `youtube_upload_video` | Upload MP4 (wajib `confirm: true`) |

## Smoke

1. `curl http://127.0.0.1:8787/health`
2. Panggil `youtube_auth_status` dari agent
3. Jangan panggil upload tanpa persetujuan user

Skill: `youtube-publishing`.
