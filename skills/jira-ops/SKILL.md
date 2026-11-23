# Jira Ops

**Level: max.**

## Summary

Manage Jira issues, sprints, and boards via MCP.

## When to use

- User asks for Jira integration, issue creation, or status updates
- Project requires tracking in Jira
- MCP entry `jira` is configured

## Prerequisites

1. Jira credentials/API token
2. Wire MCP:
   ```powershell
   .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp jira
   ```

## Procedure

1. **Setup** — Ensure Jira MCP is connected.
2. **Context** — Read `mcp/jira/README.md`.
3. **Plan** — Identify project, issue type, and actions.
4. **Execute** — Use Jira MCP tools (list, create, update, etc.).
5. **Verify** — Confirm changes in Jira UI if possible.

## DoD

- [ ] Jira MCP connected
- [ ] Actions performed successfully
- [ ] No tokens in git

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
