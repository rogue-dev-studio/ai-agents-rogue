---
name: after-effects
description: >-
  Automate Adobe After Effects composition editing, rendering, and workflows
  through MCP.
---

# After Effects


## Summary

Automate Adobe After Effects via MCP.

## When to use

- User needs After Effects composition edits, rendering, or automation
- `TEAM.yaml` or chat names `after-effects`
- MCP entry `after-effects` is configured

## Prerequisites

1. Adobe After Effects installed
2. Wire MCP:
   ```powershell
   .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp after-effects
   ```

## Procedure

1. **Context** — Confirm project.
2. **Execute** — Use After Effects MCP tools. Save outputs under `project/{id}/artifacts/media/`.
3. **Verify** — Check render logs or exported files.

## DoD

- [ ] After Effects MCP connected
- [ ] Requested tasks done
- [ ] No tokens in git

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
