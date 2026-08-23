---
name: youtube-publishing
description: >-
  Manual YouTube upload via local API and MCP. OAuth setup, auth status,
  and explicit confirm-gated video upload — never auto-upload after export.
---

# YouTube Publishing (Manual)

**Level: standard.** Paket MCP: `mcp/youtube/` · Local API: `project/code-tutorial-studio/services/youtube-api/`.

## Must always

- Jalankan local API sebelum MCP/agent upload
- OAuth credentials di `.env` / secret store — **jangan** commit
- Upload **hanya** setelah user konfirmasi eksplisit (`confirm: true`)
- Default privacy: `unlisted` kecuali user minta lain
- Gunakan `{slug}-youtube.json` dari export (title/description/tags human tone) bila ada
- Jangan pakai template "auto-generated" / bullet langkah mentah di deskripsi upload

## Must never

- Auto-upload setelah export MP4
- Panggil `youtube_upload_video` tanpa persetujuan user di chat/UI
- Menyimpan refresh token di source tree

## Procedure

1. Setup Google Cloud + salin `.env` (lihat `services/youtube-api/README.md`).
2. `npm install && npm start` di folder local API.
3. Wire MCP: `install-mcp.ps1 -Mcp youtube`.
4. `youtube_auth_status` → `youtube_start_auth` (browser) → cek lagi.
5. Saat user minta upload: konfirmasi judul/privasi → `youtube_upload_video` dengan `confirm: true`.

## DoD

- [ ] Local API `/health` OK
- [ ] OAuth channel terhubung
- [ ] Upload hanya via permintaan user
- [ ] Token tidak di git

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
