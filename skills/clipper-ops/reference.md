# Clipper Ops — Reference

## Consent checklist (minimum)

- [ ] Creator name / channel / contact
- [ ] Scope: boleh clip jenis apa (gameplay, podcast, tutorial, vlog, …)
- [ ] Platform publish clipper (YT Shorts, TikTok, IG, …)
- [ ] Monetization: boleh / tidak / revenue share
- [ ] Credit format: on-screen, description, pinned comment
- [ ] Watermark/logo creator wajib atau opsional
- [ ] Review gate: creator approve sebelum publish atau post langsung
- [ ] Retensi: hapus clip jika creator revoke

## Clip sheet template

| # | Source | In | Out | Hook | Platform | Status |
|---|--------|----|----|------|----------|--------|
| 1 | URL/file | 00:01:23 | 00:01:45 | … | 9:16 Shorts | draft |

## FFmpeg patterns (delegasi `ffmpeg-processing`)

```bash
# Trim + scale 9:16 center crop
ffmpeg -ss START -i input.mp4 -t DURATION \
  -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" \
  -c:v libx264 -c:a aac clip.mp4
```

## Music sources (YouTube-safe examples)

| Source | License note |
|--------|----------------|
| Wikimedia Commons | Cek per file (CC0, CC BY, …) — catat atribusi |
| Creator-provided stems | Izin eksplisit di consent |
| Platform audio library | Ikuti ToS platform target |
| Synth/local generate | Royalty-free bila generate sendiri |

**Hindari:** chart music, random "no copyright" tanpa verifikasi.

## Platform reminders (bukan legal advice)

- YouTube: atribusi + fair use **bukan** otomatis aman — ikuti consent creator
- Shorts/Reels: hormati music library masing-masing platform
- Jangan bypass DRM atau download melawan ToS

## Artifact paths

| Artifact | Path |
|----------|------|
| Consent | `project/{id}/docs/clipper/consent-*.md` |
| Sources | `project/{id}/docs/clipper/source-manifest.md` |
| Clip sheet | `project/{id}/docs/clipper/clip-sheet.md` |
| Clips | `project/{id}/artifacts/media/clips/` |
| Upload meta | `project/{id}/artifacts/media/clips/*-youtube.json` |

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
