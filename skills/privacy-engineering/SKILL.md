---
name: privacy-engineering
description: >-
  Design privacy-preserving systems and practices. Use for privacy by design,
  data minimization, purpose and consent management, retention, privacy
  impact assessments, anonymization, or user data rights.
---

# Privacy Engineering

## When to use

- Design or review collection, use, sharing, retention, and deletion of personal data
- Translate privacy principles into product, API, storage, and operational controls
- Assess consent, data-subject workflows, anonymization, or privacy impact

## Procedure

1. Identify data subjects, data categories, purposes, recipients, jurisdictions, and lifecycle.
2. Collect only necessary data; define purpose, lawful basis/consent owner, retention, access, and deletion behavior with responsible privacy/legal stakeholders.
3. Map data flows and trust boundaries; minimize identifiers in logs, analytics, prompts, and test fixtures.
4. Select controls such as encryption, access scoping, aggregation, pseudonymization, or differential privacy where appropriate.
5. Evaluate re-identification and linkage risk; do not call data anonymous without a documented threat model and validation.
6. Verify user notices, consent withdrawal, access/correction/deletion workflows, and retention jobs.
7. Record residual risks and obtain privacy/legal review for material processing changes.

## Safety boundaries

- Do not expose or reproduce real personal data in reports or examples.
- Do not infer consent from continued product use where explicit consent is required.
- This skill does not determine legal compliance; escalate jurisdiction-specific interpretations.

## Definition of done

- [ ] Data inventory, purposes, and lifecycle are documented.
- [ ] Minimization and privacy controls are tested.
- [ ] Retention, deletion, and rights workflows have evidence.
- [ ] Residual re-identification risk and approvals are recorded.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
