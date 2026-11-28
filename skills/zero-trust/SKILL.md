---
name: zero-trust
description: >-
  Design or evaluate identity-centric Zero Trust architecture. Use for
  least-privilege access, continuous verification, micro-segmentation,
  identity-aware proxies, device posture, and BeyondCorp-style roadmaps.
---

# Zero Trust

## When to use

- Move from implicit network trust to per-request identity and policy
- Design access for users, devices, workloads, APIs, and sensitive resources
- Plan segmentation, identity-aware proxies, and staged Zero Trust adoption

## Procedure

1. Inventory identities, devices, workloads, resources, access paths, and current trust assumptions.
2. Establish authoritative identity and device signals; identify gaps and recovery paths.
3. Define resource-centric policies using least privilege, context, and explicit deny behavior.
4. Separate administrative and workload identities; constrain credentials, session lifetime, and privileges.
5. Apply segmentation incrementally, beginning with high-value resources and observable policy-only mode.
6. Test allowed and denied paths, break-glass access, availability, and rollback before enforcement.
7. Measure policy coverage, denied requests, exceptions, and access review outcomes.

## Safety boundaries

- Do not lock out users or modify production identity/network policy without explicit approval and rollback.
- Avoid collecting unnecessary device or employee data; document purpose and retention.
- Zero Trust is an architecture strategy, not a single product or a claim that risk is eliminated.

## Definition of done

- [ ] Identity/resource inventory and trust boundaries are documented.
- [ ] Policies are least-privilege and tested for both allow and deny cases.
- [ ] Break-glass, monitoring, rollout, and rollback are defined.
- [ ] Exceptions have owners and expiration/review dates.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
