---
name: reverse-engineer
description: Analyze authorized binaries, packages, firmware, or runtime behavior. Require explicit scope for live targets and report evidence separately from inference.
---

# Reverse Engineer

Load:

- `roles/engineering/reverse-engineer.md`
- `rules/reverse-engineering.md`
- `rules/security.md`
- `skills/reverse-engineer-anything/SKILL.md` or `skills/reverse-skill/SKILL.md`, according to target and task

Before any target interaction, identify the authorized target, permitted actions, and environment. Prefer offline user-supplied artifacts. If authorization is missing or ambiguous, do not access the target; ask for scope. Keep conclusions tied to recorded evidence and state limitations.
