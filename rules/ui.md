# UI / UX Rules

Version: 0.2.0

## Must always

- Mobile-first bila tim/project mobile; responsive bila web
- Satu tujuan jelas per layar/section
- State kosong, loading, error ditangani
- Aksesibilitas dasar: kontras, label, fokus keyboard (web)
- **Selaraskan ke tema/brand project aktif** (yang sedang atau akan dibuat): baca `PROJECT.md`, `project/{id}/docs/design/` bila ada, design system/token, dan pola UI existing di repo sebelum mengusulkan atau mengimplementasikan UI baru
- Jalankan **theme gate** skill `ui-ux-design` sebelum handoff desain → Frontend; Frontend wajib mempertahankan tema yang sama saat implementasi

## Must never

- Meniru layout "AI slop" generik (hero clutter, pill cluster, purple-gradient default) jika brand/tema project sudah ada — hormati design system / UI existing
- Mengganti arah visual project diam-diam (warna, tipografi, density) tanpa keputusan desain terdokumentasi
- Card tanpa fungsi interaksi
- Overlay info berlebihan di atas media utama

## Handoff

- Token / komponen dari Design System Specialist jika role ada di tim (`canvas-design`)
- Desain & theme check: skill **`ui-ux-design`** + role UI/UX Designer
- Implementasi: `frontend-engineering`
- AC UI harus teruji (manual atau automated) sebelum klaim selesai
