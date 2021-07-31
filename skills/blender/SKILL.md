---
name: blender
description: >-
  Blender 3D via BlenderMCP (addon + blender-mcp). Use when the user needs
  modeling, materials, scene ops, or rendering controlled from the agent.
  Requires mcp/blender package wired into Cursor and Blender server on :9876.
experience_level: max
---

# blender

**Level: max.** Runtime package: `mcp/blender` (not skill-text alone).

## Summary

Control Blender through the BlenderMCP addon (socket **9876**) and the
`blender-mcp` MCP server (`uvx blender-mcp` or pip). Catalog assets live under
`ai-agents-rogue/mcp/blender/`.

## When to use

- User asks for Blender / 3D scene / render via agent
- `TEAM.yaml` or chat names `blender`
- MCP entry `blender` is configured in `.cursor/mcp.json`

## When not to use

- Pure documentation with no Blender runtime
- Prefer other tools if the task is 2D-only image work (`imagemagick`, etc.)

## Prerequisites

1. Blender 3.0+ installed  
2. `uvx` **or** `pip install blender-mcp`  
3. Addon enabled + **Start Server** in Blender (port 9876)  
4. Cursor MCP wired:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender
```

See `mcp/blender/README.md`.

## Procedure

1. **Context** — Confirm `WORKMODE.md` / project; read `mcp/blender/README.md`.
2. **Tooling** — `blender --version`; MCP `blender` connected in Cursor; Blender addon listening.
3. **Plan** — Inputs (scene goals), outputs (`.blend` / renders), risks (GPU, long renders).
4. **Execute** — Use MCP tools (scene info, objects, materials, Python in Blender). Keep diffs/assets in the project tree.
5. **Verify** — Screenshot/scene info or render path; note blockers if MCP disconnects.
6. **Handoff** — Paths, Blender version, open issues.

## Quality bar

- No secrets in git
- Do not claim success if MCP/addon is down
- Domain constraints and privacy rules respected

## DoD

- [ ] Blender MCP reachable or blocker explicit
- [ ] Requested scene/action done or documented fail
- [ ] Artifact paths recorded
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
