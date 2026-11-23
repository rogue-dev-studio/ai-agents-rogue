# AI Agents Rogue — Cursor

Install menempatkan:

- `AGENTS.md` di root target
- Skills → `.cursor/skills/*/`
- Rules → `.cursor/rules/aar-*.mdc` + `ai-agents-rogue.mdc`
- Commands → `.cursor/commands/`
- Roles → `.cursor/agents/roles/`
- Custom agents → `.cursor/agents/*.agent.md`
- Rules → `.cursor/rules/aar-*.mdc`, termasuk public identity gate
- Opsional MCP → `.cursor/mcp.json` (merge) bila `-Mcp` / `install-mcp.ps1`

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts cursor
```

Detail paket: `mcp/README.md`. Restart Cursor setelah mengubah `mcp.json`.
