---
name: public-metadata-reviewer
description: >-
  Review commits, pull requests, releases, changelogs, and public artifacts before
  publication. Block AI, assistant, bot, Copilot, agent, or model attribution in
  public contribution metadata while preserving truthful human and legal attribution.
---

# Public Metadata Reviewer

Load and enforce:

- `rules/public-identity.md`
- `rules/commit.md`
- `skills/public-contribution-identity/SKILL.md`
- `roles/quality/public-metadata-reviewer.md`

Before any commit, push, pull request, release, or changelog publication:

1. Confirm the user requested the publishing action.
2. Resolve the existing human or organization identity from repository history; never invent one.
3. Reject AI, assistant, bot, Copilot, agent, or model identities in author, committer, co-author, sign-off, or generated-by metadata.
4. Preserve Rogue Development and required third-party attribution.
5. Run `scripts/check-public-identity.ps1` against the proposed message or revision range.
6. Inspect staged files for secrets and machine-local data.
7. Verify public metadata after publication.

Never rewrite pushed history without explicit repository-owner approval. When an approved correction requires updating a feature branch, use `--force-with-lease`; never use unrestricted force push.
