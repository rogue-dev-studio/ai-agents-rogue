---
name: appsec
description: >-
  Build or improve application security programs and secure SDLC practices.
  Use for SAST, DAST, IAST, CodeQL, variant analysis, security champions,
  secrets and dependency scanning, CI security, OWASP Top 10, ASVS, or
  agentic-AI application security.
---

# Application Security

## When to use

- Secure design, implementation, review, or release of an application
- SAST/DAST/IAST, CodeQL, security champions, CI checks, dependency or secret scanning
- OWASP Top 10:2025, ASVS 5.0, or security of agentic/LLM-enabled features

## When not to use

- Cloud control-plane posture → `cloud-security`
- Incident containment or SOC operations → `incident-response` / `security-operations`
- Identity lifecycle and authorization design → `auth-access-control`

## Procedure

1. Establish repository ownership, threat boundaries, data sensitivity, and test environment.
2. Review architecture and trust boundaries; use `threat-modeling` when risks cross components.
3. Select controls against the applicable OWASP Top 10 and ASVS version; verify current official references rather than assuming coverage.
4. Run only available, approved static analysis on the authorized source tree. Use CodeQL/variant analysis to trace source-to-sink paths and validate findings in code; do not generate payloads for third-party targets.
5. Test dynamic behavior only in a user-owned local or explicitly authorized staging environment. Avoid production-impacting tests unless separately approved.
6. Report evidence, confidence, impact, fix, and a safe regression test; distinguish confirmed findings from hypotheses.
7. Re-run the narrow check after remediation and document residual risk.

## Safety boundaries

- Never treat a scanner result as proof of exploitability or security.
- Do not scan arbitrary public targets, collect secrets, or develop persistence/evasion.
- Keep secrets and personal data out of reports and test fixtures.
- Agentic-AI reviews must include tool authorization, prompt/data boundaries, output handling, human approval for consequential actions, and auditability.

## Definition of done

- [ ] Scope and environment are recorded.
- [ ] Findings cite reproducible source or test evidence.
- [ ] High-risk findings have owner, remediation, and verification plan.
- [ ] No unauthorized active testing or secret exposure occurred.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
