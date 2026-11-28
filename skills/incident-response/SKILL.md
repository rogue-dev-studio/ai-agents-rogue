---
name: incident-response
description: >-
  Prepare for, detect, respond to, or recover from a security incident. Use
  for incident playbooks, severity classification, breach handling,
  containment planning, evidence preservation, NIST incident response, and
  post-incident reviews.
---

# Incident Response

## When to use

- Build or exercise incident response plans and communication trees
- Triage a suspected incident from user-provided alerts, logs, or artifacts
- Plan containment, recovery, lessons learned, or NIST-aligned response activities

## Procedure

1. Establish incident authority, affected systems, time window, business impact, and evidence custody.
2. Preserve relevant logs and artifacts before changes; record timestamps, hashes, and collection limits.
3. Classify severity using impact, scope, data sensitivity, and confidence; clearly label unknowns.
4. Recommend containment options with operational impact, dependencies, and rollback. Obtain explicit approval before account suspension, isolation, shutdown, deletion, or other disruptive action.
5. Coordinate legal, privacy, leadership, and customer communications through the designated incident commander.
6. Verify recovery from trusted state, rotate exposed credentials through approved owners, and monitor for recurrence.
7. Complete a blameless review with actions, owners, deadlines, and evidence of closure.

## Safety boundaries

- Do not destroy evidence, wipe systems, or contact suspected actors.
- Do not disclose incident details or personal data beyond approved stakeholders.
- Never claim a breach or exoneration without evidence; escalate uncertain material impacts.

## Definition of done

- [ ] Incident scope, timeline, severity, and confidence are documented.
- [ ] Evidence is preserved with custody and privacy safeguards.
- [ ] Containment and recovery actions are authorized and verified.
- [ ] Follow-up actions have owners and due dates.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
