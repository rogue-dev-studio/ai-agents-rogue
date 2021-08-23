# Clipper Rules

Version: 0.1.0

Hard constraints untuk pekerjaan **clipper / repurposing** konten creator. Detail prosedur: skill `clipper-ops` + role Content Clipper.

## Must always

- **Consent creator** terdokumentasi sebelum download, edit, atau publish clip
- **Atribusi** ke creator asli (on-screen dan/atau description) sesuai agreement
- Musik & asset pihak ketiga: **lisensi jelas** untuk platform target (YouTube-safe bila upload YT)
- Simpan master sensitif/unreleased **di luar git**; manifest path saja di repo
- Upload/publish: gate konfirmasi (`youtube-publishing`) — tidak auto-upload
- Catat sumber footage, timestamp clip, dan lisensi musik di docs project

## Must never

- Clip/re-upload konten creator **tanpa izin**
- Menghapus watermark atau credit wajib creator
- Klaim ownership atau brand impersonation
- Memakai musik/chart audio bercopyright tanpa lisensi
- Bypass DRM atau scrape melawan ToS platform sumber
- Commit file master unreleased atau credential creator ke git

## Review triggers (wajib libatkan Security + PO bila relevan)

- Footage belum rilis / embargo
- Konten anak, medis, atau PII audience
- Monetization / revenue share clipper
- Multi-platform syndication (YT + TikTok + IG)
- Dispute atau revoke consent creator
