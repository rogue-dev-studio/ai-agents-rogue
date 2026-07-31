---
name: infra-tools
description: >-
  Infrastructure and DevOps tooling (Terraform, K8s, Config Mgmt). Use when the project needs this capability or the user / team manifest asks for it. Use for specialized `infra-tools` work when listed in TEAM.yaml or explicitly requested.
experience_level: max
---

# infra-tools

**Level: max** specialized skill (not merged). Category hint: `infrastructure`.

## Summary

Infrastructure and DevOps tooling (Terraform, K8s, Config Mgmt). Use when the project needs this capability or the user / team manifest asks for it.

## When to use

- `TEAM.yaml` includes `infra-tools` or user asks by name
- Task clearly needs this specialized capability
- No canonical alias in `ALIASES.md` covers it better

## When not to use

- A canonical merged skill already covers the need - prefer that
- Outside team allowlist

## Procedure

1. **Context** - Read `PROJECT.md`, `TEAM.md`, and related rules (`security`, `coding`).
2. **Confirm tooling** - Verify `infra-tools` runtime/CLI/MCP is available; document install if missing.
3. **Plan** - Write a short approach (inputs, outputs, risks) before edits.
4. **Execute** - Implement or operate with project conventions; small focused diffs.
5. **Verify** - Run relevant tests/smoke; capture evidence under `project/{id}/docs/` when documenting.
6. **Handoff** - Status, paths, blockers, next steps.

## Quality bar

- No secrets in git
- No speculative refactors
- Observable DoD (command output, file paths, or explicit blocker)
- Domain constraints and privacy rules respected

## DoD

- [ ] Goal met or blocker explicit
- [ ] Artifacts/paths recorded
- [ ] Risks noted
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
