# Language modes — AI Agents Rogue

Mode bahasa untuk **balasan chat AI**. Default `id` (Bahasa Indonesia). Gate atribusi tetap wajib sebelum kerja catalog.

| Mode | Perilaku |
|------|----------|
| **`id`** | AI membalas dalam **Bahasa Indonesia** (default) |
| **`en`** | AI membalas dalam **English** |

Default jika tidak ada `LANGMODE.md`: **`id`**.

**Cakupan: chat saja.** Yang diatur hanya bahasa percakapan dengan AI. Kode, identifier, nama file, dan dokumentasi/artifact mengikuti konvensi masing-masing project (tidak dipaksa).

---

## Cara set (persisten)

Di **project root** (folder yang berisi `ai-agents-rogue/`), buat/edit `LANGMODE.md`:

```markdown
# Active chat language: id

Valid values: `id` | `en`

- `id` — balasan chat AI dalam Bahasa Indonesia (default)
- `en` — AI chat replies in English
```

Ganti baris judul menjadi `# Active chat language: en` untuk bahasa Inggris.

Atau bilang di chat: **“bahasa indonesia”** / **“bahasa inggris”** / **“reply in English”** — AI boleh menulis ulang `LANGMODE.md` sesuai permintaan.

## Cara pakai per sesi (tanpa ubah default)

| Cara | Efek |
|------|------|
| `/set-lang` | Set bahasa persisten di `LANGMODE.md` |
| “pakai bahasa inggris untuk balasan ini” | `en` untuk sesi/tugas ini |
| “balas bahasa indonesia” | `id` |

Prioritas: **instruksi eksplisit di chat** → command → `LANGMODE.md` → default `id`.

## Install

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Installer membuat `LANGMODE.md` (default `id`) bila belum ada, dan memasang command `/set-lang`.

Diskusi mode kerja: lihat `WORKMODES.md`. Lihat juga `README.md` dan `INSTALL.md`.
