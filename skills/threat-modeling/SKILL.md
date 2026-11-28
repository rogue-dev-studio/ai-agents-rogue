---
name: threat-modeling
description: >-
  Identify, analyze, and prioritize threats to an application, service, or
  infrastructure. Use for STRIDE, DREAD, attack trees, trust boundaries,
  asset classification, defensive PASTA workshops, and architecture risk reviews.
---

# Threat Modeling

## When to use

- Design a new system or materially change a trust boundary
- Identify abuse cases, assets, entry points, threat actors, and defensive controls
- Facilitate a PASTA workshop or maintain an architecture threat model

## Procedure

1. Define business objectives, scope, participants, data classification, and risk appetite.
2. Decompose the authorized system into components, data flows, identities, external dependencies, and trust boundaries.
3. Identify assets, security/privacy requirements, and realistic threat scenarios.
4. Use STRIDE or an equivalent taxonomy to check coverage; use PASTA for business-impact-driven analysis.
5. In a PASTA workshop, record objectives, technical scope, decomposition, threat analysis, weaknesses, scenario analysis, and risk/control analysis.
6. Rank risks by impact, likelihood, exposure, and evidence—not severity labels alone.
7. Map each prioritized threat to preventive/detective controls, an owner, verification evidence, and residual risk.

## Safety boundaries

- Keep attack scenarios at the level needed to select defensive controls; do not turn the model into exploit instructions for real targets.
- Threat actors and assumptions are hypotheses unless supported by evidence.
- Revisit the model when architecture, data, identity, or dependencies materially change.

## Definition of done

- [ ] Scope, assumptions, assets, and trust boundaries are explicit.
- [ ] Threats are ranked and linked to concrete controls.
- [ ] Owners and verification criteria exist for high-priority mitigations.
- [ ] Residual risks and review date are recorded.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
