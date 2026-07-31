---
name: mcp-integrations
description: >-
  Canonical MCP server integration playbook: allowlist, Cursor mcp.json merge,
  smoke tests, and scaffolding. Use with ai-agents-rogue/mcp packages.
---

# MCP Integrations (Canonical)

**Level: max.** Aliases: `context7-mcp`, `jira-mcp`, `linear-mcp`, `excalidraw-mcp`, `pal-mcp-server`.

Catalog packages: see [`mcp/CATALOG.md`](../../mcp/CATALOG.md) and [`mcp/README.md`](../../mcp/README.md).

## Procedure

1. Daftar MCP yang diizinkan tim (jangan pasang semua). Mulai dari `mcp/CATALOG.md`.
2. Wire host: `scripts/install-mcp.ps1 -Target . -Mcp <id>` (merge ke `.cursor/mcp.json`).
3. Auth OAuth/token di secret store bila server butuh; scope minimum; **jangan** commit token.
4. Uji 3 tool calls emas per server setelah restart Cursor.
5. Scaffold paket baru dari `mcp/_template/` hanya jika gap jelas; daftarkan di CATALOG.
6. Dokumentasikan di notes project: server → guna → owner.

## DoD

- [ ] Allowlist MCP tertulis
- [ ] Smoke tools OK
- [ ] Token tidak di git
- [ ] Entry `.cursor/mcp.json` ada tanpa menimpa server lain tanpa sengaja
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
