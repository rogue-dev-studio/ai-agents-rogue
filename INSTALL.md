# Install — AI Agents Rogue

Untuk user yang sudah (atau akan) **Star + Fork** repo resmi  
https://github.com/rogue-dev-studio/ai-agents-rogue

Author: [Rogue Development](https://github.com/rogue-dev-studio)

Download ZIP **tanpa** fork+star tidak berhak install (installer akan menolak).

---

## 1. Star + Fork

1. Buka https://github.com/rogue-dev-studio/ai-agents-rogue
2. Klik **Star**
3. Klik **Fork** → fork ke akun GitHub Anda

Tunggu beberapa detik agar API GitHub mengenali star/fork.

## 2. Autentikasi GitHub CLI

Installer memanggil GitHub API. Pilih salah satu:

```powershell
# Disarankan
gh auth login
```

atau set environment variable:

```powershell
$env:GITHUB_TOKEN = "ghp_...."   # scope: read:user + akses repo publik
```

## 3. Clone ke project Anda

Catalog harus berada sebagai subfolder **`ai-agents-rogue`** di **project root** (bukan hanya isi file di root project).

```powershell
cd path\to\project-anda
git clone https://github.com/<username-anda>/ai-agents-rogue.git ai-agents-rogue
```

Atau clone dari upstream resmi (tetap wajib punya fork+star di akun yang sama dengan `gh auth`):

```powershell
git clone https://github.com/rogue-dev-studio/ai-agents-rogue.git ai-agents-rogue
```

## 4. Install ke host AI

Dari **project root** (folder yang berisi `ai-agents-rogue/`):

```powershell
# Semua host (Cursor, Claude, OpenCode, …) + full catalog
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

```bash
./ai-agents-rogue/scripts/install.sh . all
```

Opsional (hanya jika Anda sudah membuat `teams/<id>/` sendiri):

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Team <id>
```

Installer otomatis menjalankan:

1. Verify RSA seal (`ATTRIBUTION.seal`)
2. Pin kunci resmi vs GitHub upstream
3. Cek entitlement star + fork

Gagal di salah satu → install **berhenti**.

## 5. Cek manual (opsional)

Dari dalam folder catalog:

```powershell
cd ai-agents-rogue
.\scripts\verify-attribution.ps1
.\scripts\verify-official-upstream.ps1
.\scripts\check-github-entitlement.ps1
```

Exit code `0` = OK.

## 6. Setelah install

- Ikuti `AGENTS.md` di project root
- Mode kerja: baca **`WORKMODES.md`** + file `WORKMODE.md` (dibuat installer, default `e2e`)
- E2E: `/start-feature` · Manual/assist: `/assist` · Ganti default: `/set-mode`
- Project baru: `.\ai-agents-rogue\scripts\new-project.ps1 ...` atau `/new-project`

## Troubleshooting

| Gejala | Perbaikan |
|--------|-----------|
| Entitlement failed / not starred | Star + Fork repo resmi, lalu retry |
| Cannot read `/user` | `gh auth login` ulang atau token valid |
| Seal / signature INVALID | Jangan ubah file catalog; restore dari repo resmi |
| Upstream key unreachable | Pastikan repo resmi sudah live + jaringan OK |
| Fork belum terdeteksi | Pastikan fork dari `rogue-dev-studio/ai-agents-rogue`, bukan copy manual |

## Yang tidak perlu (dan jangan) Anda miliki

- `.attribution-private.xml` — kunci signing **hanya** Rogue Development  
- Anda **tidak** perlu (dan tidak boleh) re-seal resmi; pakai `ATTRIBUTION.seal` dari upstream

Lihat juga `LICENSE`, `NOTICE`, dan `README.md`.
