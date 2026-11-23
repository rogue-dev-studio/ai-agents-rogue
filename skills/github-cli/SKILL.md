---
name: github-cli
description: >-
  GitHub CLI authentication and workflow configuration. Use when the project needs this capability or the user / team manifest asks for it. Use for specialized `github-cli` work when listed in TEAM.yaml or explicitly requested.
experience_level: max
---

# github-cli

**Level: max** specialized skill (not merged). Category hint: `base`.

## Summary

GitHub CLI authentication and workflow configuration. Use when the project needs this capability or the user / team manifest asks for it.

## When to use

- `TEAM.yaml` includes `github-cli` or user asks by name
- Task clearly needs this specialized capability
- No canonical alias in `ALIASES.md` covers it better

## When not to use

- A canonical merged skill already covers the need - prefer that
- Outside team allowlist

## Procedure

1. **Context** - Read `PROJECT.md`, `TEAM.md`, and related rules (`security`, `coding`, `commit`, `public-identity`).
2. **Confirm tooling** - Verify `github-cli` runtime/CLI/MCP is available; document install if missing.
3. **Plan** - Write a short approach (inputs, outputs, risks) before edits.
4. **Identity gate** - Load `public-contribution-identity`; validate proposed commit/PR/release metadata with `scripts/check-public-identity.ps1`.
5. **Execute** - Implement or operate with project conventions; small focused diffs. Never add an AI/assistant/bot co-author or generated-by trailer.
6. **Verify** - Run relevant tests/smoke and inspect published metadata; capture evidence under `project/{id}/docs/` when documenting.
7. **Handoff** - Status, paths, blockers, next steps.

## Quality bar

- No secrets in git
- No speculative refactors
- Public authorship is the truthful human/organization identity already established by the repository
- No AI, assistant, bot, Copilot, agent, or model identity in public contribution metadata
- Required Rogue Development and third-party attribution remains intact
- Observable DoD (command output, file paths, or explicit blocker)
- Domain constraints and privacy rules respected

## DoD

- [ ] Goal met or blocker explicit
- [ ] Public identity validation passed
- [ ] Published metadata verified
- [ ] Artifacts/paths recorded
- [ ] Risks noted
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
