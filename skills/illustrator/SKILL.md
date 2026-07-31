---
name: illustrator
description: >-
  Adobe Illustrator via MCP (npx illustrator-mcp-server). Use when the user
  needs vector art, artboards, exports, or Illustrator automation from the agent.
  Requires mcp/illustrator wired and Illustrator desktop installed/running.
experience_level: max
---

# illustrator

**Level: max.** Runtime package: `mcp/illustrator` (not skill-text alone).

## Summary

Drive **Adobe Illustrator** from the AI host through a public MCP runtime
(`illustrator-mcp-server` via `npx`). Rogue owns the playbook + wiring under
`ai-agents-rogue/mcp/illustrator/` and this skill.

## When to use

- User asks for Illustrator / AI / SVG / vector / artboard work via agent
- `TEAM.yaml` or chat names `illustrator`
- MCP entry `illustrator` is configured

## When not to use

- Raster/photo retouch → prefer `photoshop`
- Simple CLI image transforms → `imagemagick`
- 3D → `blender`

## Prerequisites

1. Adobe Illustrator desktop installed and ideally running
2. Node.js 18+ (`npx`)
3. Wire MCP:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp illustrator
```

See `mcp/illustrator/README.md`.

## Procedure

1. **Context** — Confirm project / `WORKMODE.md`; read `mcp/illustrator/README.md`.
2. **Tooling** — Illustrator reachable; MCP `illustrator` connected.
3. **Plan** — Inputs (AI/SVG), outputs (export), print vs screen constraints.
4. **Execute** — Use MCP tools (read/manipulate/export); save under `project/{id}/artifacts/design/` (SVG/PDF/AI exports). Create project if missing.
5. **Verify** — Export or document state check; note blockers if bridge fails.
6. **Handoff** — Paths under `artifacts/design/`, AI version, open issues.

## Quality bar

- No secrets / Adobe credentials in git
- Do not claim success if Illustrator or MCP is down
- Respect license and file ownership

## DoD

- [ ] Illustrator MCP reachable or blocker explicit
- [ ] Requested vector/export work done or documented fail
- [ ] Artifact paths recorded
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
