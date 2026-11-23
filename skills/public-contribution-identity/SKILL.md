---
name: public-contribution-identity
description: >-
  Protect public Git authorship and release metadata. Use before commits, pushes,
  pull requests, releases, changelogs, or generated public files when AI, bot,
  assistant, Copilot, agent, or automation attribution must not appear unless the
  user explicitly approves it.
experience_level: max
---

# Public Contribution Identity

## When to use

- Before creating or amending a commit
- Before pushing a branch or opening a pull request
- Before publishing release notes, changelogs, or generated artifacts
- When the user asks to keep assistant or automation identity out of public metadata

## When not to use

- Do not rewrite published history unless the repository owner explicitly requests it
- Do not replace a real author with a false identity
- Do not remove required human, organization, license, or copyright attribution
- Do not bypass platform policy or conceal prohibited automation

## Procedure

1. Resolve the repository's established human or organization identity from Git history and project policy; never invent one.
2. Draft commit and PR text without assistant-identifying trailers or signatures, including `Co-authored-by`, `Generated-by`, `Assisted-by`, or equivalent bot credits.
3. Run `scripts/check-public-identity.ps1` against the proposed message and public files.
4. Inspect staged files for secrets and unintended assistant-identifying metadata.
5. Commit, push, or publish only when the user has requested that action.
6. If a pushed branch contains unintended metadata, obtain explicit approval before amending and use `--force-with-lease`, never an unrestricted force push.
7. Verify the resulting public commit, PR, or release metadata after publication.

## Quality bar

- Public authorship reflects the authenticated human or organization, not an invented identity
- No assistant-identifying trailer is added by default
- Required attribution to Rogue Development and third parties remains intact
- No secrets or machine-local files are published
- History rewriting is explicit, narrow, and verified

## DoD

- [ ] Public metadata contains no unapproved assistant or bot attribution
- [ ] Human or organization authorship is truthful
- [ ] Required legal attribution is preserved
- [ ] Validation passes before publication
- [ ] Published metadata is verified after push or release

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
