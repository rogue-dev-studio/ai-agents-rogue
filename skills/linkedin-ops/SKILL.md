# LinkedIn Ops

**Level: max.**

## Summary

Manage LinkedIn Company Page posts and engagement via official API/MCP.

## When to use

- User asks to draft, schedule, or manage professional content on LinkedIn
- Project requires community updates or outreach
- MCP entry `linkedin` is configured

## Prerequisites

1. LinkedIn Company Page Admin access
2. App created in LinkedIn Developer Portal (Client ID/Secret)
3. Wire MCP:
   ```powershell
   .\ai-agents-rogue\scripts\install-mcp.ps1 -Target . -Mcp linkedin
   ```

## Procedure

1. **Setup** — Ensure LinkedIn MCP is connected with authorized credentials.
2. **Context** — Confirm project and content strategy (role `social-media-manager`).
3. **Plan** — Identify content and target audience.
4. **Execute** — Use LinkedIn MCP tools to draft/post/analyze.
5. **Verify** — Check LinkedIn Page for correct post formatting and content.

## DoD

- [ ] LinkedIn MCP connected
- [ ] Posts published/scheduled and verified
- [ ] Anti-slop check passed for content
- [ ] No tokens in git

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
