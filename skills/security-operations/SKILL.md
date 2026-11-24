---
name: security-operations
description: >-
  Build or improve SOC and security operations. Use for SIEM/log management,
  alert triage, detection engineering, defensive threat hunting, YARA rules,
  and security monitoring.
expertise_level: expert
---

# Security Operations

## When to use

- Design SOC processes, telemetry, SIEM data sources, alert triage, or detection coverage
- Analyze user-provided logs and security alerts
- Author or validate defensive YARA rules against approved, offline samples

## Procedure

1. Define system ownership, log sources, retention, privacy boundaries, and analyst authority.
2. Establish baseline telemetry, time synchronization, access controls, and auditability.
3. Triage alerts by evidence, confidence, scope, and business impact; preserve source context.
4. Create detections with rationale, test fixtures, false-positive analysis, versioning, and rollback.
5. For YARA, use offline authorized samples or benign fixtures; document rule intent and test for false positives before deployment.
6. Limit threat hunting to approved telemetry and systems; distinguish observed activity from attribution or speculation.
7. Tune alerts and report coverage, response time, false-positive rate, and outstanding gaps.

## Safety boundaries

- Do not execute unknown malware or provide evasion, persistence, or payload-generation guidance.
- Do not collect unrelated user content or expand searches to systems outside the approved environment.
- Coordinate incident actions through `incident-response`; disruptive containment requires explicit approval.

## Definition of done

- [ ] Telemetry scope and privacy controls are documented.
- [ ] Detections include tests, limitations, and ownership.
- [ ] YARA rules are validated on authorized offline data or synthetic fixtures.
- [ ] Findings are evidence-based and linked to response procedures.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
