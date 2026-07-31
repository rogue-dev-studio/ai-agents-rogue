# MCP package: mcp-builder (partial)

Status: **partial** — scaffold docs.

Pakai template katalog untuk paket MCP baru (bukan server runtime siap pakai).

## Prerequisites

1. Node.js 18+ (jika menulis server JS)
2. Familiar dengan MCP SDK

## Setup / scaffold

1. Salin `mcp/_template/` → `mcp/<id>/`
2. Isi `package.json`, `README.md`, `cursor.mcp.fragment.json`
3. Daftarkan di `mcp/CATALOG.md`
4. Hubungkan skill di `skills/<id>/SKILL.md`
5. Re-seal resmi hanya oleh Rogue Development

Opsional:

```powershell
npm install @modelcontextprotocol/sdk
```

Skill terkait: `skills/skill-authoring`.
