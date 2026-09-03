# Work modes — AI Agents Rogue

Dua mode resmi. Gate atribusi (verify RSA + upstream + entitlement) tetap wajib di keduanya sebelum kerja catalog.

| Mode | Perilaku |
|------|----------|
| **`e2e`** | AI Orchestrator + `e2e-delivery`: eksekusi penuh sampai DoD (artifact + kode bila perlu) |
| **`manual`** | Assist: rencana, opsi, checklist; **tidak** implement/edit kode kecuali user eksplisit minta |

Default jika tidak ada `WORKMODE.md`: **`e2e`**.

---

## Cara set mode (persisten)

Di **project root** (folder yang berisi `ai-agents-rogue/`), buat/edit `WORKMODE.md`:

```markdown
# Active work mode: e2e

Valid values: `e2e` | `manual`

- `e2e` — auto-execute end-to-end
- `manual` — plan/assist only until user asks to implement
```

Ganti baris judul menjadi `# Active work mode: manual` untuk mode assist.

Atau bilang di chat: **“mode e2e”** / **“mode manual”** — AI boleh menulis ulang `WORKMODE.md` sesuai permintaan itu.

## Cara pakai per tugas (tanpa ubah default)

| Command / chat | Efek |
|----------------|------|
| `/start-feature` | Paksa **e2e** untuk tugas ini |
| `/dev-shift` | Shift dev otonom berdurama (skill `continuous-dev-shift`) |
| `/assist` | Paksa **manual** untuk tugas ini |
| `/set-mode` | Set mode persisten di `WORKMODE.md` |
| “kerjakan / bangun / implement E2E” | e2e |
| “shift dev / continuous improvement / kerja otonom N jam” | `continuous-dev-shift` (prompt, tanpa wajib command) |
| “rencanakan saja / jangan coding dulu” | manual |

Prioritas: **instruksi eksplisit di chat** → command → `WORKMODE.md` → default `e2e`.

## Mode `e2e` — ringkas

1. Gate 0 (attribution scripts)
2. Skill `e2e-delivery`
3. Pipeline Requirement → … → Testing/Review
4. Pause hanya untuk blocker (lihat skill)

## Mode `manual` — ringkas

1. Gate 0 tetap (jika memakai skill/roles catalog)
2. Boleh: clarifying questions, outline fase, draft AC, estimasi, daftar file yang *akan* diubah
3. **Jangan:** menulis/mengubah source code, migrasi, atau mengklaim “sudah diimplementasi”
4. Jika user lalu bilang “implementasikan” / “lanjut E2E” → baru boleh eksekusi (atau sarankan `/start-feature`)

## Install

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Installer membuat `WORKMODE.md` (default `e2e`) bila belum ada, dan memasang commands `/start-feature`, `/dev-shift`, `/assist`, `/set-mode`, `/new-project`.

Lihat juga `README.md` dan `INSTALL.md`.
