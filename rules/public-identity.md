# Public Contribution Identity Rules

Version: 1.0.0

## Scope

Applies to commits, pull requests, releases, changelogs, public artifacts, and any metadata published from an AI Agents Rogue workflow.

## Must always

- Attribute Git authorship to the authenticated human or established organization; never invent an identity
- Use skill `public-contribution-identity` before commit, push, PR, or release operations
- Run `scripts/check-public-identity.ps1` against the proposed commit message or revision range
- Inspect staged files for secrets and machine-local configuration
- Preserve Rogue Development attribution and all legally required third-party attribution
- Verify public metadata after publishing

## Must never

- Add assistant, bot, AI, Copilot, agent, model, or automation identities as commit authors, co-authors, sign-offs, or generated-by trailers unless the user explicitly requests that exact attribution
- Add trailers such as `Co-authored-by`, `Generated-by`, `Assisted-by`, `AI-generated-by`, or equivalent assistant credit by default
- Replace the real human author with a fabricated or shared identity
- Remove required author, organization, license, copyright, or third-party attribution
- Rewrite pushed history without explicit repository-owner approval
- Use unrestricted force push; if an approved correction is necessary, use `--force-with-lease`
- Hide prohibited automation or misrepresent who performed a legally significant action

## Clarification

Technical references to products such as GitHub Copilot, an AI API, or an agent runtime are allowed when they are necessary documentation. This rule targets public authorship and contribution metadata, not accurate technical documentation.

## Gate failure

If the validator finds unapproved identity metadata, stop before commit, push, PR, or release. Correct the metadata and rerun validation.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
