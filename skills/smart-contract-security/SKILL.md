---
name: smart-contract-security
description: >-
  Design or review security of smart contracts. Use for Solidity/EVM access
  control, invariants, upgradeability, oracle and economic risks, static
  analysis, and secure contract development.
---

# Smart Contract Security

## When to use

- Design, review, or test a contract source tree before deployment
- Assess authorization, external calls, arithmetic, asset accounting, upgradeability, or oracle assumptions
- Map findings to invariants, remediation, and regression tests

## Procedure

1. Confirm source ownership, compiler/toolchain versions, intended chain, deployment state, and review scope.
2. Identify privileged roles, assets, external dependencies, upgrade paths, and trust assumptions.
3. State invariants and expected behavior before reviewing implementation.
4. Review source and available tests; use approved static tools locally and validate findings against source.
5. Evaluate access control, state transitions, external-call boundaries, accounting, initialization, and failure handling.
6. Report evidence, impact, confidence, fix, and tests; distinguish code defects from economic assumptions.
7. Re-run focused tests and review the fix; require domain-owner review before deployment.

## Safety boundaries

- Do not interact with or exploit deployed third-party contracts or move assets.
- Do not publish secrets, private keys, or uncoordinated vulnerability details.
- A static review is not an audit guarantee; disclose tool, scope, and test limitations.

## Definition of done

- [ ] Scope, compiler settings, and threat assumptions are recorded.
- [ ] Findings map to code and stated invariants.
- [ ] Fixes have regression tests and independent owner review.
- [ ] Deployment and economic risks are explicitly stated.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
