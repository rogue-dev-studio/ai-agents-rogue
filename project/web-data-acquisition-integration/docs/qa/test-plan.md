# QA Test Plan — Web Data Acquisition Integration

## Acceptance coverage

| Case | Requirement | Expected result | Status |
|------|-------------|-----------------|--------|
| QA-01 | FR-01 | Requested capabilities resolve to the two canonical skills, not duplicate skill folders. | Pass — alias/catalog inspection |
| QA-02 | FR-02 / FR-06 | Collection scope and provenance requirements are documented in the skill/rule. | Pass — static policy inspection |
| QA-03 | FR-03 | Blocks and restrictions stop collection; no evasion path is documented. | Pass — static policy inspection |
| QA-04 | FR-04 | Orchestrator routes collection and browser interaction to their proper owners. | Pass — routing inspection |
| QA-05 | FR-05 | MCP records are docs-only and no scraper runtime is installed. | Pass — catalog/package inspection |
| QA-06 | NFR-01 | All changed Markdown has no whitespace errors. | Pass — `git diff --check` |
| QA-07 | Repository quality | Skill/agent compliance and attribution verification pass. | Pass — skill compliance and attribution gates |

## Manual review criteria

- No third-party skill or executable payload is copied into the repository.
- No request can bypass authentication, CAPTCHA, paywall, site denial, robots disallow, or rate limits.
- `429` behavior respects `Retry-After`; concurrency and total volume are bounded.
- Browser automation remains appropriate for approved user journeys, not as a stealth collection mechanism.
- Links among skill, rule, role, agent, Orchestrator, catalogs, and docs-only MCP are valid.

## Execution record

Execution:

- `scripts/check-skill-compliance.ps1` — PASS (all skill and agent files are compliant).
- `git diff --check` — PASS (CRLF normalization warnings only; no whitespace errors).
- `scripts/generate-attribution-seal.ps1` — PASS with explicit user approval; signed seal includes 273 protected files.
- `scripts/verify-attribution.ps1` — PASS (RSA seal verified; 167 skills).
- `scripts/verify-official-upstream.ps1` — PASS (official key fingerprint and GitHub upstream verified).
- `scripts/check-github-entitlement.ps1` — PASS (authenticated user is an allowlisted maintainer).
- Static review and cross-reference inspection — PASS; no scraper runtime or provider credentials added.
- No live websites, accounts, or external services were accessed for this repository change.
