# AI Agents Rogue — OpenCode

Install menempatkan:

- `AGENTS.md` di root target
- Skills → `.opencode/skills/`
- Commands → `.opencode/commands/`
- Roles → `.opencode/agents/roles/`
- Opsional MCP → merge ke **`opencode.json`** (`mcp.servers`, format local/remote) bila `-Mcp`

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp all -Hosts opencode
```

Lihat [OpenCode MCP docs](https://opencode.ai/docs/mcp-servers). Restart OpenCode setelah mengubah config.
