# Install — AI Agents Rogue

Panduan untuk user yang ingin memakai catalog di project mereka.

**Repo resmi:** https://github.com/rogue-dev-studio/ai-agents-rogue  
**Author:** [Rogue Development](https://github.com/rogue-dev-studio)

Download ZIP **tanpa** Fork + Star **tidak** berhak install (installer akan menolak).

---

## 0. Prasyarat

Pasang dulu alat berikut (semua OS):

| Alat | Wajib? | Catatan |
|------|--------|---------|
| [Git](https://git-scm.com/) | Ya | Clone catalog |
| [GitHub CLI `gh`](https://cli.github.com/) | Ya (disarankan) | Entitlement star/fork + auth API |
| PowerShell | Ya | Windows: Windows PowerShell 5.1+ atau **PowerShell 7**. Linux/macOS: **`pwsh`** (PowerShell 7) |
| Editor AI host | Ya | Cursor / Claude Code / OpenCode / dll. |

### Cek cepat

```powershell
git --version
gh --version
```

```bash
# Linux / macOS — PowerShell 7 harus ada di PATH
pwsh --version
```

Install PowerShell 7 (Linux/macOS): https://learn.microsoft.com/powershell/scripting/install/installing-powershell  
Install `gh`: https://cli.github.com/

`install.sh` **memerlukan** `pwsh` atau `powershell` karena gate atribusi/entitlement ditulis di PowerShell.

---

## 1. Star + Fork

1. Buka https://github.com/rogue-dev-studio/ai-agents-rogue  
2. Klik **Star**  
3. Klik **Fork** → fork ke akun GitHub Anda  

Tunggu beberapa detik agar API GitHub mengenali star/fork.

---

## 2. Autentikasi GitHub

Installer memanggil GitHub API dengan akun yang sama yang star + fork.

### Opsi A — GitHub CLI (disarankan)

```powershell
gh auth login
```

Ikuti prompt:

1. **GitHub.com**
2. **HTTPS** (umumnya)
3. Authenticate via browser (atau token)
4. Pastikan login sukses: `gh auth status`

### Opsi B — Token environment

Buat Personal Access Token (classic) dengan minimal akses baca user/repo publik, lalu:

```powershell
# Windows PowerShell (sesi ini saja)
$env:GITHUB_TOKEN = "ghp_...."
```

```bash
# Linux / macOS
export GITHUB_TOKEN=ghp_....
```

Jangan commit token ke git.

---

## 3. Clone ke project Anda

Catalog harus menjadi subfolder bernama **`ai-agents-rogue`** di **project root** (bukan mengekstrak isi file langsung ke root project).

```text
project-anda/                 ← project root (Target install)
  ai-agents-rogue/            ← catalog (hasil clone)
  AGENTS.md                   ← dibuat/diisi oleh installer
  WORKMODE.md                 ← dibuat installer (default e2e)
  .cursor/ …                  ← adapter host (setelah install)
```

```powershell
cd path\to\project-anda

# Dari fork Anda
git clone https://github.com/<username-anda>/ai-agents-rogue.git ai-agents-rogue

# Atau dari upstream resmi (tetap wajib star+fork di akun gh auth)
git clone https://github.com/rogue-dev-studio/ai-agents-rogue.git ai-agents-rogue
```

```bash
cd /path/to/project-anda
git clone https://github.com/<username-anda>/ai-agents-rogue.git ai-agents-rogue
```

Pakainya **branch `master` terbaru** (setelah clone: `git -C ai-agents-rogue pull`).

---

## 4. Install ke host AI

Dari **project root** (folder yang berisi `ai-agents-rogue/`):

### Windows

Default Windows sering memblokir `.ps1` (*running scripts is disabled*). Gunakan salah satu:

```powershell
# Jalankan installer sekali dengan Bypass (tidak mengubah policy sistem)
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Atau izinkan skrip lokal untuk akun Windows Anda:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Jika Execution Policy sudah mengizinkan skrip:

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Hanya Cursor:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts cursor
```

### Linux / macOS

```bash
chmod +x ai-agents-rogue/scripts/install.sh
./ai-agents-rogue/scripts/install.sh . all
```

Atau langsung PowerShell:

```bash
pwsh -File ./ai-agents-rogue/scripts/install.ps1 -Target . -Hosts all
```

### Hosts yang didukung

`cursor`, `antigravity`, `claude`, `opencode`, `generic`, atau `all`.

### Tim (opsional)

Hanya jika Anda sudah membuat `ai-agents-rogue/teams/<id>/` sendiri:

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Team <id>
```

### Gate otomatis (sebelum copy file)

1. Verify RSA seal (`ATTRIBUTION.seal`)  
2. Pin kunci resmi vs GitHub upstream  
3. Cek entitlement star + fork  

Gagal di salah satu → install **berhenti**.

---

## 5. Cek manual (opsional)

```powershell
cd ai-agents-rogue
.\scripts\verify-attribution.ps1
.\scripts\verify-official-upstream.ps1
.\scripts\check-github-entitlement.ps1
```

```bash
cd ai-agents-rogue
pwsh -File ./scripts/verify-attribution.ps1
pwsh -File ./scripts/verify-official-upstream.ps1
pwsh -File ./scripts/check-github-entitlement.ps1
```

Exit code `0` = OK.

---

## 6. Setelah install

1. **Restart** host AI (Cursor / Claude Code / dll.) agar skills & rules ter-load.  
2. Pastikan muncul (contoh Cursor):  
   - `.cursor/skills/` (termasuk `e2e-delivery`)  
   - `.cursor/rules/aar-*.mdc` dan `ai-agents-rogue.mdc`  
   - Commands: `/start-feature`, `/assist`, `/set-mode`, `/new-project`  
3. Baca `AGENTS.md` di project root.  
4. Mode kerja: `WORKMODE.md` (default **`e2e`**) + panduan `ai-agents-rogue/WORKMODES.md`.  
5. Project baru:  

```powershell
.\ai-agents-rogue\scripts\new-project.ps1 -Id my-app -Name "My App"
```

atau command `/new-project`.

### Mode singkat

| Mode | Cara |
|------|------|
| E2E (eksekusi penuh) | Default, atau `/start-feature` |
| Manual (plan saja) | `/assist` atau `/set-mode` → `manual` |

---

## Troubleshooting

| Gejala | Perbaikan |
|--------|-----------|
| `running scripts is disabled` / Execution Policy | `powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all` atau `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `gh` / `pwsh` not found | Install GitHub CLI / PowerShell 7; buka terminal baru |
| Entitlement failed / not starred | Star + Fork repo resmi, tunggu sebentar, `gh auth status`, retry |
| Cannot read `/user` | `gh auth login` ulang atau `GITHUB_TOKEN` valid |
| Seal / signature INVALID / hash mismatch | `git -C ai-agents-rogue pull origin master` (jangan ubah skill manual); jangan pakai ZIP lama |
| Upstream key unreachable | Jaringan OK + repo resmi dapat diakses |
| Fork belum terdeteksi | Fork harus dari `rogue-dev-studio/ai-agents-rogue`, bukan copy folder manual |
| Skills tidak muncul di Cursor | Restart Cursor; cek path install `-Target` benar (project root) |
| Permission denied `install.sh` | `chmod +x ai-agents-rogue/scripts/install.sh` |

---

## Yang tidak perlu (dan jangan) Anda miliki

- `.attribution-private.xml` — kunci signing **hanya** Rogue Development  
- Anda **tidak** perlu (dan tidak boleh) re-seal resmi; pakai `ATTRIBUTION.seal` dari upstream  

Lihat juga `LICENSE`, `NOTICE`, `README.md`, dan `WORKMODES.md`.
