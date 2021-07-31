---
name: photoshop
description: >-
  Adobe Photoshop via MCP (uvx photoshop-mcp-server). Use when the user needs
  PSD edits, layers, exports, or Photoshop automation from the agent.
  Requires mcp/photoshop wired and Photoshop desktop installed/running.
experience_level: max
---

# photoshop

**Level: max.** Runtime package: `mcp/photoshop` (not skill-text alone).

## Summary

Drive **Adobe Photoshop** from the AI host through a public MCP runtime
(`photoshop-mcp-server` via `uvx`). Rogue owns the playbook + wiring under
`ai-agents-rogue/mcp/photoshop/` and this skill.

## When to use

- User asks for Photoshop / PSD / layer edits / export via agent
- `TEAM.yaml` or chat names `photoshop`
- MCP entry `photoshop` is configured

## When not to use

- Vector-first work → prefer `illustrator`
- Simple batch image ops without Photoshop → `imagemagick`
- Generative raster pipelines → `comfyui` when appropriate

## Prerequisites

1. Adobe Photoshop desktop installed (version matched to `PS_VERSION`, default `2024`)
2. `uv` / `uvx` on PATH
3. Wire MCP:

```powershell
.\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp photoshop
```

See `mcp/photoshop/README.md`.

## Procedure

1. **Context** — Confirm project / `WORKMODE.md`; read `mcp/photoshop/README.md`.
2. **Tooling** — Photoshop running; MCP `photoshop` connected; adjust `PS_VERSION` if needed.
3. **Plan** — Inputs (PSD/assets), outputs (export paths), risks (license, COM/API, long ops).
4. **Execute** — Use MCP tools for document/layer/session ops; keep artifacts in the project tree.
5. **Verify** — Open/export check or explicit blocker if MCP cannot reach Photoshop.
6. **Handoff** — Paths, PS version, open issues.

## Quality bar

- No secrets / Adobe credentials in git
- Do not claim success if Photoshop or MCP is down
- Respect license and file ownership

## DoD

- [ ] Photoshop MCP reachable or blocker explicit
- [ ] Requested edit/export done or documented fail
- [ ] Artifact paths recorded
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
