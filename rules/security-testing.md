# Security Testing Rules

Apply to SAST, DAST, IAST, penetration testing, vulnerability validation, threat hunting, and security tooling.

## Must always

- Confirm asset ownership, written authorization, target list, environment, time window, allowed techniques, rate/impact limits, data handling, and stop contact before active testing.
- Prefer source review, static analysis, synthetic fixtures, local environments, and read-only inventory.
- Use the least intrusive validation that answers the security question; preserve evidence and record tool/version, scope, and limitations.
- Stop if scope is ambiguous, a test affects an unapproved system, or unexpected sensitive data appears.
- Obtain explicit approval before production testing, account changes, containment, cloud policy changes, destructive actions, or third-party disclosure.
- Route code scanning to `appsec`, vulnerability lifecycle to `vulnerability-management`, and live incident work to `incident-response`.

## Must never

- Probe arbitrary public IPs/domains, evade controls, persist, exfiltrate, collect credentials, or disrupt availability.
- Execute unknown malware on the host or generate payloads intended to compromise systems.
- Treat a scanner finding, model output, or unverified report as confirmed impact.
- Store secrets, personal data, or sensitive exploit material in public artifacts.

## Reporting

Record authorized scope, evidence, confidence, impact, safe remediation, verification status, and residual risk. Do not include weaponized reproduction steps beyond what is necessary for the authorized owner to validate and fix the issue.
