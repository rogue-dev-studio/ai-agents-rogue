# AI Agents Rogue

Katalog **roles + rules + skills + E2E delivery** untuk Cursor, Antigravity, Claude Code, OpenCode, dll.

**Author:** [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`)

**Izin pakai:** hanya user GitHub yang sudah **Fork + Star** repo resmi  
https://github.com/rogue-dev-studio/ai-agents-rogue  
(bukan download ZIP saja). Install memanggil `scripts/check-github-entitlement.ps1` (`gh auth login` atau `GITHUB_TOKEN`).

Lihat `LICENSE` + `NOTICE` + `ATTRIBUTION.seal` (RSA-signed) + `ATTRIBUTION.public.xml`.
Atribusi **wajib**. Gate: `verify-attribution` + `verify-official-upstream` (pin kunci vs GitHub) + star/fork entitlement.
Private key signing **tidak** dibagikan — hanya Rogue Development yang boleh re-seal resmi.

## Work modes

Dua mode: **`e2e`** (default, auto-execute) dan **`manual`** (plan/assist saja).

Petunjuk lengkap: **[WORKMODES.md](./WORKMODES.md)**

| Cara | Contoh |
|------|--------|
| File persisten | `WORKMODE.md` di project root |
| Command | `/start-feature` (e2e), `/assist` (manual), `/set-mode` |
| Chat | “mode e2e” / “mode manual” |

## Skills

Indeks kegunaan lengkap (skills + MCP + rules + roles): **[INDEX.md](./INDEX.md)**

| Skill | Fungsi |
|-------|--------|
| Canonical merges | lihat `skills/ALIASES.md` + `skills/CATALOG.md` |
| `e2e-delivery` / `clarity` / `agentic-flow` / `agentic-qe` | House E2E + spec + orch + QA |
| Specialized tools / languages / cloud | specialized playbooks |
| `skill-authoring` | menulis skill baru |

Default install = **katalog penuh**. Skill lokal opsional lewat `teams/<id>/skills/` (lihat `teams/README.md`).  
MCP runtime opsional: folder [`mcp/`](./mcp/) + `install-mcp.ps1` / `install.ps1 -Mcp blender` (lihat `mcp/README.md` + `mcp/CATALOG.md`).

## Rules

`rules/global.md`, `author.md`, `security.md`, `coding.md`, `commit.md`, `ui.md` (di-install ke Cursor sebagai `aar-*.mdc`). Ringkas: [INDEX.md § Rules](./INDEX.md#rules).

## Teams

Opsional. Repo resmi **tidak** membawa tim produk bawaan — hanya `teams/_template/`.  
Buat tim sendiri bila perlu subset skills/roles, lalu `install.ps1 -Team <id>`.

## Projects

Di **project root** (bukan di dalam repo catalog): `project/{id}/` berisi dokumentasi pengembangan (`docs/srs`, `planning`, …).

```powershell
.\ai-agents-rogue\scripts\new-project.ps1 -Id my-app -Name "My App"
```

Command: `/new-project`. Active project ditandai di project root `PROJECT.md` (file lokal).

## Roles

18 roles di `roles/` (management → documentation), plus `core/` dan `templates/`. Ringkas: [INDEX.md § Roles](./INDEX.md#roles).

## Install

Panduan lengkap (prasyarat → Star/Fork → auth → clone → install → Cursor → troubleshoot): **[INSTALL.md](./INSTALL.md)**

Ringkas — dari project root setelah catalog ada di `ai-agents-rogue/`:

```powershell
gh auth login
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all
```

```bash
./ai-agents-rogue/scripts/install.sh . all
```

Opsional, setelah Anda membuat tim sendiri:

```powershell
.\ai-agents-rogue\scripts\install.ps1 -Target . -Hosts all -Team <id>
```

**Jangan** commit `.attribution-private.xml` (kunci signing Rogue saja; tidak ikut distribusi).
Yang **wajib** ada di repo publik: `ATTRIBUTION.seal`, `ATTRIBUTION.public.xml`, `LICENSE`, `NOTICE`, `GITHUB_ENTITLEMENT.json`, `INSTALL.md`.
