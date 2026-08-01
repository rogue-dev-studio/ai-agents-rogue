# UI/UX Design — Reference (Expert)

## Theme / brand alignment gate (blocker)

Sebelum wireframe atau mockup difinalisasi, jawab semua poin:

| # | Pertanyaan | Lulus jika |
|---|------------|------------|
| 1 | Project aktif mana? (`PROJECT.md` / `project/{id}/`) | Identitas produk jelas |
| 2 | Apa tema visual yang sudah ada? (warna, font, density, komponen) | Dirujuk dari docs design **atau** UI existing di repo |
| 3 | Apakah usulan memakai token/pola yang sama? | Ya, atau ada alasan tertulis + approval desain |
| 4 | Apakah usulan bisa dikenali sebagai produk yang sama tanpa membaca nama di nav? | Brand/tema cukup kuat dan konsisten |
| 5 | Apakah menghindari template generik (hero clutter, pill cluster, purple-gradient default, dsb.) ketika project sudah punya arah? | Ya |

**Fail theme gate** → jangan handoff ke Frontend; revisi dulu.

Sumber tema (urut prioritas):

1. Design system / token project (`docs/design/`, stylesheet variables, component library)
2. Layar/modul existing di codebase frontend
3. SRS / UI requirements yang menyebut brand atau tone
4. Asumsi tertulis di `docs/design/` (hanya jika 1–3 kosong)

## Screen checklist

- [ ] Satu tujuan jelas per layar/section
- [ ] Empty / loading / error / success states
- [ ] Hierarki: brand/produk tidak dikalahkan headline generik (bila permukaan branded)
- [ ] Mobile-first atau responsive sesuai rule `ui`
- [ ] Modal/overlay: tidak merusak layout di belakang; fokus terkelola
- [ ] Card hanya jika wadah interaksi (selaras rule `ui`)

## Handoff ke Frontend

- Komponen/token yang wajib dipakai
- Spacing/type scale jika belum di DS
- Catatan tema: “selaras dengan modul X / token Y”
- AC UI yang bisa diverifikasi (`browser-automation` atau manual)

## Anti-patterns

- Mengganti tema project dengan tren visual baru tanpa ADR/desain approval
- Mencampur dua density/typografi tanpa sistem
- Overlay stiker/badge berlebih di atas media utama
- Desain yang hanya cantik di desktop, rusak di mobile
