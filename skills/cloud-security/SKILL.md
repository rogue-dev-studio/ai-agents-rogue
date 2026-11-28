---
name: cloud-security
description: >-
  Secure AWS, Azure, or GCP infrastructure. Use for cloud IAM, security
  groups, network exposure, encryption, key management, misconfiguration
  review, CIS-aligned hardening, or shared-responsibility decisions.
---

# Cloud Security

## When to use

- Review or harden an authorized AWS, Azure, or GCP environment
- Evaluate IAM policies, security groups/firewalls, encryption, logging, or cloud posture
- Map controls to a selected CIS benchmark or shared-responsibility boundary

## When not to use

- Cloud CLI installation alone → `cloud-tools`
- Application-layer security → `appsec`
- Identity architecture across apps and users → `auth-access-control` and `zero-trust`

## Procedure

1. Confirm tenant/account/project ownership, regions, environment, and read/write scope.
2. Start with read-only inventory; identify public exposure, privileged identities, key lifecycle, logging, backups, and network boundaries.
3. Compare only the relevant controls against current official provider guidance and the selected CIS benchmark version.
4. Rank misconfigurations by exposure, data sensitivity, privilege, and exploit preconditions; record evidence and uncertainty.
5. Propose least-privilege, encryption, segmentation, and recovery changes with blast radius and rollback.
6. Apply changes only when explicitly requested and approved; verify control state afterward.

## Safety boundaries

- Never request, print, or store cloud credentials; use the user's approved secret manager and minimal scope.
- Do not enumerate unrelated tenants, access third-party resources, or make production changes by implication.
- Do not disable audit logging, TLS validation, or security controls as a workaround.

## Definition of done

- [ ] Account scope and permission mode are explicit.
- [ ] Findings map to observed resource identifiers and current state.
- [ ] Proposed changes include impact, owner, verification, and rollback.
- [ ] No secrets or unauthorized resources were accessed.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
