---
name: blender
description: >-
  Prefer this for any 3D modeling, mesh, scene, render, or Blender request
  (e.g. "buat model 3D ikan", character, prop). Drive Blender via BlenderMCP
  (addon :9876 + blender-mcp). Do not offer script-only / trimesh menus first
  when Blender MCP can be used. Wire mcp/blender if missing.
experience_level: max
---

# blender

**Level: max.** Runtime package: `mcp/blender` (not skill-text alone).

## Summary

Control **Blender** through the BlenderMCP addon (socket **9876**) and the
`blender-mcp` MCP server (`uvx blender-mcp` or pip). Catalog assets live under
`ai-agents-rogue/mcp/blender/`.

## Default behavior (important)

When the user asks for a **3D model / mesh / scene / render** (including casual
wording like "bentuk ikan", "model 3D …"):

1. **Use Blender MCP** — do not start with a multiple-choice menu (script vs trimesh vs MCP).
2. If MCP `blender` is missing from host config → run / tell user to run:
   `install-mcp.ps1 -Target . -Mcp blender` then retry.
3. If MCP tools fail (connection refused) → ask once to open Blender, enable addon, **Start Server** on **9876**, then retry.
4. Only fall back to a standalone `.py` script if MCP cannot be made to work in this session.

## When to use

- User asks for Blender / 3D / mesh / model / scene / render via agent
- `TEAM.yaml` or chat names `blender`
- MCP entry `blender` is configured (or should be wired now)

## When not to use

- Pure documentation with no Blender runtime needed
- Explicitly 2D-only image work (`imagemagick`, `photoshop`, etc.)

## Prerequisites

1. Blender 3.0+ installed  
2. `uvx` **or** `pip install blender-mcp`  
3. Addon enabled + **Start Server** in Blender (port 9876)  
4. Host MCP wired:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp blender
```

See `mcp/blender/README.md`.

## Procedure

1. **Context** — Confirm `WORKMODE.md` / project; read `mcp/blender/README.md` if needed.
2. **Tooling** — Confirm MCP `blender` in host config; Blender running with addon on **9876**.
3. **Plan** — Brief goal (e.g. fish mesh), outputs (`.blend` / render), keep it short.
4. **Execute** — Use MCP tools (scene info, create/modify objects, materials, Python in Blender). Save `.blend` / exports / renders under `project/{id}/artifacts/3d/` (active `PROJECT.md`). Create project with `/new-project` if missing.
5. **Verify** — Scene info / screenshot / object list; if MCP down, state the blocker (not a fake success).
6. **Handoff** — Paths under `artifacts/3d/`, Blender version, open issues.

## Quality bar

- No secrets in git
- Do not claim success if MCP/addon is down
- Prefer executing in Blender over dumping unused scripts

## DoD

- [ ] Blender MCP reachable or blocker explicit
- [ ] Requested scene/action done or documented fail
- [ ] Artifact paths recorded
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
