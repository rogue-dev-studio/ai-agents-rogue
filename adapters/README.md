# Adapters

Konten kanonik: `AGENTS.md`, `roles/`, `skills/`, `core/`, `templates/`, `rules/`.

| Host | Skills | Roles | Shared |
|------|--------|-------|--------|
| **Cursor** | `.cursor/skills/` | `.cursor/agents/roles/` + `.cursor/agents/*.agent.md` | `AGENTS.md`, `ai-agents-rogue/**`, `.cursor/rules/ai-agents-rogue.mdc` |
| **Antigravity** | `.agents/skills/` | `.agents/roles/` + `.agents/agents/*.agent.md` | `AGENTS.md`, `ai-agents-rogue/**` |
| **Claude Code** | `.claude/skills/` | `.claude/agents/roles/` + `.claude/agents/*.agent.md` | `AGENTS.md`, pointer di `CLAUDE.md` |
| **OpenCode** | `.opencode/skills/` | `.opencode/agents/roles/` + `.opencode/agents/*.agent.md` | `AGENTS.md`, `ai-agents-rogue/**` |
| **Generic** | `.agents/skills/` | `.agents/roles/` + `.agents/agents/*.agent.md` | sama |
| **GitHub Copilot** | `.github/skills/` | `.github/agents/roles/` + `.github/agents/*.agent.md` | `.github/copilot-instructions.md`, `.github/instructions/` |

Install: `../scripts/install.ps1` / `install.sh`.

Semua host menerima skill/rule/agent `public-contribution-identity` untuk memblokir identitas AI/assistant/bot pada metadata publik sebelum commit, push, PR, atau release.
