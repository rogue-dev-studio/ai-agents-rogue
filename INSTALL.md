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
| [uv](https://github.com/astral-sh/uv) / `uvx` | Opsional | MCP Blender / Photoshop (`uvx …`) |
| Blender 3+ | Opsional | Hanya jika memakai paket `mcp/blender` |
| Adobe Photoshop / Illustrator | Opsional | Hanya jika memakai `mcp/photoshop` atau `mcp/illustrator` |
| Node.js 18+ | Opsional | `npx` MCP (Playwright, Illustrator, chrome-devtools, …) |

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
Update berkala: lihat **§5 Update**.

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

**Pack domain lokal** (HR interview, SIMRS, dll.) ikut otomatis pada full catalog: default `-IncludeDomains hr` (`hr-cv-lifecycle`, `hr-psychometric`, `hr-employee-ops`). Opsional:

```powershell
# HR + SIMRS
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -IncludeDomains hr,simrs
# Semua pack di teams/
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -IncludeDomains all
# Hanya katalog tersegel (tanpa pack lokal)
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -IncludeDomains none
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

### MCP (opsional)

Skill teks saja **tidak** mengaktifkan MCP. Wire paket dari `mcp/` ke host AI.

**Model runtime (hybrid):** katalog memasang fragment + playbook Rogue. Engine MCP biasanya **unduh saat dipakai** (`npx` / `uvx`) atau **remote URL** (Context7, Atlassian, Linear). Hanya sebagian aset lokal (mis. addon Blender) yang ikut di repo. Detail: [`mcp/README.md`](./mcp/README.md#model-runtime-hybrid).

```powershell
# Bersama install (MCP di-wire ke host yang sama dengan -Hosts)
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Mcp all

# MCP saja ke semua host adapter
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts all

# Hanya Cursor + Claude
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender,playwright -Hosts cursor,claude
```

```bash
./ai-agents-rogue/scripts/install.sh . all "" all
pwsh -File ./ai-agents-rogue/scripts/install-mcp.ps1 -Target . -Mcp all -Hosts all
```

Target file: `.cursor/mcp.json`, `.mcp.json` (Claude), `opencode.json`, `.agents/mcp.json`.  
`-Mcp`: `none` (default), id, daftar koma, atau `all` (paket **ready**). Lihat [`mcp/CATALOG.md`](./mcp/CATALOG.md).  

**Setup per paket (app/addon):** baca README di `mcp/<id>/` — indeks di [`mcp/README.md`](./mcp/README.md#panduan-setup-per-paket).  
Contoh Blender: Preferences → Add-ons → **Install from Disk** → `mcp/blender/addon/blender_mcp_addon.py` → enable → sidebar **N** → **Start Server** (`:9876`) → restart host.

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

## 5. Update (sudah pernah install)

Jika catalog di project Anda sudah ada dan Rogue merilis update di `master`:

### Langkah

1. **Pull catalog terbaru** (dari project root):

```powershell
git -C ai-agents-rogue pull origin master
```

```bash
git -C ai-agents-rogue pull origin master
```

Jika Anda clone dari **fork** sendiri, merge/rebase dulu dari upstream `rogue-dev-studio/ai-agents-rogue` ke fork, lalu `pull` fork tersebut.

2. **Install ulang** ke host AI (wajib — `pull` saja tidak menyalin skill/rules ke `.cursor/` / `.agents/` / dll.):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

Dengan MCP:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Mcp all
```

```bash
./ai-agents-rogue/scripts/install.sh . all
# opsional MCP:
pwsh -File ./ai-agents-rogue/scripts/install-mcp.ps1 -Target . -Mcp all -Hosts all
```

3. **Restart** Cursor / Claude Code / OpenCode / host lain agar skill & MCP config terbaca.

### Catatan

- Star + fork + `gh auth` / `GITHUB_TOKEN` tetap berlaku di setiap install.
- Jangan re-seal; jangan edit file yang di-hash di `ATTRIBUTION.seal`.
- Jangan andalkan ZIP lama — selalu `git pull` dari repo/fork yang sync ke `master` resmi.

---

## 6. Cek manual (opsional)

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

## 7. Setelah install

1. **Restart** host AI (Cursor / Claude Code / dll.) agar skills & rules ter-load.  
2. Pastikan muncul (contoh Cursor):  
   - `.cursor/skills/` (termasuk `e2e-delivery`)  
   - `.cursor/rules/aar-*.mdc` dan `ai-agents-rogue.mdc`  
   - Commands: `/start-feature`, `/dev-shift`, `/assist`, `/set-mode`, `/new-project`  
   - Bila `-Mcp` dipakai: `.cursor/mcp.json` berisi server terkait  
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
| Seal / signature INVALID / hash mismatch | `git -C ai-agents-rogue pull origin master` lalu install ulang (§5); jangan ubah skill manual; jangan pakai ZIP lama |
| Upstream key unreachable | Jaringan OK + repo resmi dapat diakses |
| Fork belum terdeteksi | Fork harus dari `rogue-dev-studio/ai-agents-rogue`, bukan copy folder manual |
| Skills tidak muncul di Cursor | Restart Cursor; cek path install `-Target` benar (project root) |
| MCP Blender tidak connect | Install addon + Start Server di Blender; `uvx`/`pip install blender-mcp`; cek `.cursor/mcp.json`; restart Cursor |
| MCP Photoshop / Illustrator tidak connect | App Adobe harus terpasang + running; `uvx`/`npx` OK; sesuaikan `PS_VERSION`; restart host |
| Permission denied `install.sh` | `chmod +x ai-agents-rogue/scripts/install.sh` |

---

## Yang tidak perlu (dan jangan) Anda miliki

- `.attribution-private.xml` — kunci signing **hanya** Rogue Development  
- Anda **tidak** perlu (dan tidak boleh) re-seal resmi; pakai `ATTRIBUTION.seal` dari upstream  

Lihat juga `LICENSE`, `NOTICE`, `README.md`, dan `WORKMODES.md`.
