---
name: clipper-ops
description: >-
  Video clipper and repurposing ops for creator-approved promotion: consent intake,
  highlight selection, short-form cuts, captions/branding, attribution, and
  platform-safe publish handoff. Use when a creator wants clippers to promote their
  content via clips, Shorts, Reels, or compilations.
experience_level: expert
---

# Clipper Ops

**Level: expert.** Specialized skill for **creator-approved** clipper workflows.

## When to use

- Creator/channel **explicitly allows** clipper program or hired clipper
- Task: potong highlight, Shorts/Reels/TikTok, kompilasi promosi, caption + CTA ke creator
- `TEAM.yaml` includes `clipper-ops` or user asks by name
- Handoff dari PO/BA setelah consent & scope clipper terdokumentasi

## When not to use

- **Tanpa persetujuan creator** — stop; arahkan ke consent intake dulu
- Stock footage generic (tanpa creator) → `ffmpeg-processing` saja cukup
- Upload channel sendiri tanpa atribusi → blocked by rule `clipper`
- Full tutorial/code export → `e2e-delivery` + project export pipeline

## Related skills & roles

| Surface | Item |
|---------|------|
| Skill | `ffmpeg-processing` — trim, scale, efek, mux audio |
| Skill | `youtube-publishing` — upload **hanya** setelah konfirmasi user |
| Skill | `ui-ux-design` — overlay, caption style, brand pack |
| Role | `content-clipper` — eksekutor clipper |
| Rule | `clipper` — consent, atribusi, platform ToS |

## Procedure

### 1. Consent & scope (wajib)

1. Verifikasi **clipper agreement** atau persetujuan tertulis creator (chat/email/form).
2. Catat: channel/source URL, platform target, durasi clip, watermark/logo, credit line, monetization policy.
3. Jika unclear → pause; jangan download/render.

Output: `project/{id}/docs/clipper/consent-{creator-slug}.md`

### 2. Source intake

1. Inventaris sumber: URL live/VOD, file lokal, atau folder export creator.
2. Cek lisensi/ToS platform sumber (YouTube, Twitch, dll.) — dokumentasikan.
3. Simpan master **di luar git** bila berisi unreleased; path lokal + manifest saja di repo.

Output: `project/{id}/docs/clipper/source-manifest.md`

### 3. Moment selection

1. Tentukan 3–10 kandidat momen (hook, punchline, reaction, tutorial peak).
2. Tandai `in` / `out` timestamp per clip; alasan singkat (virality/education/promo).
3. Creator review bila contract mensyaratkan approval sebelum edit.

Output: `project/{id}/docs/clipper/clip-sheet.md`

### 4. Edit spec

Per clip tentukan:

- Aspect: 9:16 (Shorts/Reels/TikTok) atau 16:9
- Durasi target (15–60s tipikal Shorts)
- Caption/hook (1 baris), CTA ke creator (`@handle`, link channel)
- Musik: **royalty-free / licensed** only — catat sumber & lisensi
- Brand: lower-third, watermark creator bila diminta

Handoff teknis ke `ffmpeg-processing` atau pipeline project (mis. `funny-compilation/scripts/`).

### 5. Produce & QA

1. Render clip; cek sync audio, crop aman (wajah/teks tidak kepotong).
2. Verifikasi atribusi visible atau di deskripsi sesuai agreement.
3. Loudness wajar; hindari copyrighted music tanpa lisensi.

Output: `project/{id}/artifacts/media/clips/{slug}/`

### 6. Publish handoff

1. Siapkan title/description/tags **human tone** + credit creator + link source.
2. Chapters/timestamp bila kompilasi.
3. Upload via `youtube-publishing` **hanya** setelah user/creator konfirmasi eksplisit.
4. Log publish URL ke manifest.

## Must always

- Default **deny** tanpa consent creator
- Atribusi ke creator asli di video atau deskripsi (sesuai agreement)
- Musik & B-roll dengan lisensi jelas untuk YouTube/target platform
- Redaksi credential/path sensitif di docs

## Must never

- Re-upload penuh tanpa izin; hanya potongan sesuai scope
- Menghapus watermark creator yang wajib
- Klaim ownership konten creator
- Auto-upload tanpa konfirmasi
- Memotong data pribadi/PII creator atau audience tanpa kebutuhan & izin

## DoD

- [ ] Consent + scope terdokumentasi
- [ ] Clip sheet dengan timestamp
- [ ] Clip files di `artifacts/media/clips/`
- [ ] Lisensi musik/B-roll tercatat
- [ ] Description/chapters siap upload
- [ ] Creator review (jika required) sebelum publish

Detail checklist: `reference.md`.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
