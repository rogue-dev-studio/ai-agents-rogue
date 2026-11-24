# QA Test Plan — Cybersecurity Capability Integration

## Structural checks

- All new skills have valid frontmatter and the mandatory Rogue attribution footer.
- All custom agents have valid frontmatter and reference existing role, rule, and skill paths.
- Every named capability appears in the skill catalog or is explicitly merged into a canonical skill.
- The MCP entry is docs-only and has no fragment, package manifest, or runtime dependency.
- Third-party repositories are not copied; no credentials, scanner commands against external targets, or offensive automation are introduced.

## Acceptance coverage

| Case | Requirement | Expected result | Status |
|------|-------------|-----------------|--------|
| QA-01 | FR-01 / AC-1 | Each requested security domain is discoverable in skill catalog/index or merged IAM/PASTA guidance. | Pass — catalog/index inspection |
| QA-02 | FR-02 / AC-2 | IAM is in `auth-access-control`; PASTA is in `threat-modeling`; there is no duplicate PASTA skill. | Pass — skill path and alias inspection |
| QA-03 | FR-03 | Orchestrator routes each security domain to bounded roles and agents. | Pass — routing and agent references inspected |
| QA-04 | FR-04 / AC-2 | Authorization and scope rules prevent active testing when scope is absent; impactful action needs approval. | Pass — static policy review |
| QA-05 | FR-05 / AC-3 | CodeQL/OWASP/ASVS/YARA and remediation topics have vendor-neutral first-party guidance without imported payloads. | Pass — skills/copy scope inspected |
| QA-06 | FR-06 / AC-4 | Security MCP remains docs-only and no install fragment/runtime is implied. | Pass — no fragment or package manifest |

## Safety checks

- Missing authorization blocks live target access and active testing.
- Production-impacting containment, identity changes, or cloud changes require explicit approval and a rollback/evidence plan.
- Skills prohibit credential collection, evasion, persistence, destructive testing, and unsupported compliance claims.

## Repository checks

- Attribution seal, official upstream pin, GitHub entitlement, skill/agent compliance, and whitespace checks must pass before completion.
- Manually verify all documentation links and cross-catalog references.

## Execution record

Execution:

- `scripts/check-skill-compliance.ps1` — PASS (all skill and agent files compliant).
- `git diff --check` — PASS (Git reported only configured CRLF-to-LF normalization warnings for existing catalog files).
- Targeted PowerShell validation — PASS (edited Markdown links and new agent skill/role/rule references exist; no non-intentional trailing whitespace).
- Capability/MCP check — PASS (all 11 skill files exist; `mcp/security-tooling` has no runtime fragment or package manifest).
- `scripts/verify-attribution.ps1` — PASS (RSA seal verified; 166 skills).
- `scripts/verify-official-upstream.ps1` — PASS (official key fingerprint and GitHub upstream verified).
- `scripts/check-github-entitlement.ps1` — PASS (authenticated account is an allowlisted maintainer).
- No live target, cloud account, malware sample, or external scanner was accessed.
