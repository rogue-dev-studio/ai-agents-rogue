# Architecture — Cybersecurity Capability Integration

## Decision

Extend the catalog with first-party, modular guidance. Reuse existing canonical skills where their responsibility already matches, and split roles by operational ownership rather than creating one agent per framework or vendor.

## Capability map

| Concern | Canonical skill | Owner |
|---------|-----------------|-------|
| Secure SDLC, code audit, OWASP/ASVS, agentic AI | `appsec` | AppSec Engineer + Security Engineer |
| Identity protocols, access policy, IAM lifecycle | `auth-access-control` (extended) | Security Engineer |
| Cloud posture and Zero Trust | `cloud-security`, `zero-trust` | Cloud Security Engineer |
| Control mapping and audit evidence | `compliance-security` | Privacy & Compliance Engineer |
| Personal-data lifecycle and privacy controls | `privacy-engineering` | Privacy & Compliance Engineer |
| Incidents, SOC, detection, YARA, awareness | `incident-response`, `security-operations`, `security-awareness` | Security Operations Engineer |
| PASTA / STRIDE and ranked mitigations | `threat-modeling` | Security Engineer, with relevant domain role |
| CVE intake and remediation lifecycle | `vulnerability-management` | AppSec Engineer + Security Engineer |
| Solidity/EVM contract design and review | `smart-contract-security` | AppSec Engineer / domain owner |

## Integration boundaries

- The existing `rules/security.md` remains the baseline. New rules add safe testing scope and privacy requirements; they do not weaken the baseline.
- Roles own outcomes and escalation. Skills are reusable procedures; agents are thin routing wrappers around roles, rules, and skills.
- `rules/security-testing.md` establishes explicit authorization, least-impact validation, stop conditions, and evidence requirements.
- `rules/privacy.md` establishes data minimization, purpose, access, and retention boundaries.
- No third-party skill payloads, dependencies, scanners, credentials, or MCP servers are added.
- `mcp/security-tooling` is documentation only. A runnable MCP is deferred until a specific first-party, local-only tool contract is approved.

## Safety and evidence

Default to offline/source review and read-only inventory. Active validation is restricted to systems the user owns or has explicitly authorized, with written scope and non-production targets where practical. Findings separate evidence, inference, severity, remediation, and verification.
