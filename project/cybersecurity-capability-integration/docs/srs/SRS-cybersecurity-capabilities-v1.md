# SRS — Cybersecurity Capability Integration

## 1. Problem and goal

AI Agents Rogue has a baseline security rule and a general Security Engineer role, but lacks discoverable, coordinated playbooks for the cybersecurity domains requested by the user. Add first-party guidance that can be used without importing third-party skill payloads or installing security tooling.

## 2. Actors

- User / system owner: supplies scope, ownership, business context, and approvals.
- AI Orchestrator: routes work to the appropriate security role and skill.
- Security specialists: provide evidence-based defensive guidance within their scope.

## 3. Scope

### In scope

- First-party skills for AppSec, cloud security, compliance, incident response, privacy, security awareness, security operations, threat modeling, vulnerability management, Zero Trust, and smart-contract security.
- Extend the existing `auth-access-control` skill for identity and access management instead of duplicating it.
- Include CodeQL/SAST, variant analysis, OWASP Top 10:2025, ASVS 5.0, agentic-AI security, YARA detection rules, and Snyk-like remediation/learning concepts as vendor-neutral workflows.
- Add security rules, specialist roles and agents, orchestrator routing, catalog/index entries, and docs-only MCP guidance.
- Record PASTA as a workshop method within the canonical threat-modeling skill.

### Out of scope

- Copying, vendoring, or installing skills, agents, plugins, rules, or executable code from third-party repositories.
- Adding vendor MCP servers, scanners, cloud credentials, CI integrations, or dependencies.
- Autonomous exploitation, public-target testing, credential collection, malware execution, evasion, persistence, or destructive incident actions.
- Making legal, audit-certification, or compliance-attestation claims.

## 4. Functional requirements

| ID | Requirement |
|----|-------------|
| FR-01 | Each requested security domain must be discoverable through a first-party skill or an explicitly identified existing skill. |
| FR-02 | Identity and access management must extend `auth-access-control`; PASTA must be a method in `threat-modeling`, avoiding duplicate skill folders. |
| FR-03 | The orchestrator must route application, cloud, incident/SOC, compliance, privacy, and IAM work to bounded roles and agents. |
| FR-04 | Rules must require authorized scope, least privilege, data minimization, evidence-based findings, explicit approvals for impactful actions, and safe testing boundaries. |
| FR-05 | CodeQL/SAST, OWASP/ASVS, YARA, Snyk remediation, and named third-party repositories must be represented as vendor-neutral or optional references only; no third-party payload or runtime may be imported. |
| FR-06 | The security MCP entry must be clearly marked partial/docs-only unless a vetted first-party runtime is actually implemented. |

## 5. Non-functional requirements

- NFR-01: preserve existing repository conventions and attribution requirements.
- NFR-02: make guidance actionable, evidence-based, and explicit about assumptions and limitations.
- NFR-03: use no new package dependencies, credentials, network calls, or local target scans.
- NFR-04: default to read-only analysis and non-production environments.

## 6. Acceptance criteria

1. Given the catalog is searched by any requested security topic, when the index is read, then the matching skill, merged canonical skill, or specialist route is apparent.
2. Given a security task is routed, when its scope is missing or unauthorized, then the agent stops before target interaction and asks for scope/approval.
3. Given a user requests PASTA, CodeQL, YARA, Snyk-style remediation, or smart-contract review, when the task is in scope, then first-party procedures provide safe, bounded guidance without requiring the named vendor's content.
4. Given users inspect the MCP catalog, when no dedicated first-party server exists, then security tooling is labeled docs-only and no fake or vendor server is implied.
5. Given repository gates and structural checks run, when the changes are complete, then attribution, official-upstream, entitlement, skill compliance, and whitespace checks pass.

## 7. Assumptions and risks

- Framework versions and provider features change; skills should tell users to verify current official documentation rather than hard-code tool output.
- Compliance guidance supports control mapping and evidence preparation, not legal advice or certification.
- Security testing can affect production systems; any active testing needs explicit authorization, defined targets, and safe rate/impact limits.
- No new MCP runtime is justified for this catalog-only request; adding a security MCP server would be a separate design decision.

## 8. Third-party source handling

The repositories named in the request are not copied or installed. Their capability areas are handled by first-party skills. Optional links to authoritative standards or vendor documentation may be used for factual lookups, with source and license kept distinct from Rogue-authored guidance.
