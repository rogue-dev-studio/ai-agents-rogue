# AI Agents Rogue — Antigravity / generic `.agents`

Install menempatkan:

- Skills → `.agents/skills/`
- Commands → `.agents/commands/`
- Roles → `.agents/roles/`
- Opsional MCP → **`.agents/mcp.json`** (`mcpServers`) bila `-Mcp` / `install-mcp.ps1 -Hosts antigravity` (atau `generic`)

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts antigravity
```

Host yang membaca `.agents/mcp.json` secara native bervariasi; file ini juga sebagai salinan portable dari fragment Cursor.
