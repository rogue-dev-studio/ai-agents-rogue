# Security Tooling MCP Guidance

Status: **partial** — documentation only; there is no security-tooling MCP server or installable fragment in this repository.

## Scope

Use the first-party skill and role playbooks for authorized source review, cloud posture review, defensive telemetry/detection, and vulnerability lifecycle coordination. This directory is a routing/documentation reference, not a scanner, pentest runtime, cloud connector, SIEM, or incident-response automation service.

## Safety and integration

- Read `rules/security-testing.md` and obtain explicit authorization and a bounded target/environment scope before active testing.
- Prefer local source analysis, synthetic data, and read-only inventory.
- Do not paste credentials, personal data, or sensitive logs into external tools.
- Any future MCP integration requires a separate security review, explicit allowlisting, least-privilege credentials, local tests, and documented data flows before it is wired or called ready.
- No third-party security skill payloads, scanners, or plugin runtimes are included by this entry.

## Related first-party guidance

- `skills/appsec/SKILL.md`
- `skills/cloud-security/SKILL.md`
- `skills/security-operations/SKILL.md`
- `skills/vulnerability-management/SKILL.md`
- `skills/incident-response/SKILL.md`
