# AI Agents Rogue — Claude Code

Install menempatkan:

- `AGENTS.md` di root target
- Pointer singkat di `CLAUDE.md` (append jika belum ada)
- Skills → `.claude/skills/`
- Commands → `.claude/commands/`
- Roles → `.claude/agents/roles/`
- Opsional MCP → **`.mcp.json`** (project root, format `mcpServers`) bila `-Mcp` / `install-mcp.ps1 -Hosts claude`

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts claude
```

Restart Claude Code setelah mengubah `.mcp.json`.
