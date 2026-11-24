# Reverse Engineering Rules

Apply to reverse-engineering, firmware, malware-analysis, and penetration-testing workflows.

- Establish an authorized target and scope before interacting with a live system. If ownership or permission is unclear, stop before target access and ask.
- Prefer offline, user-supplied artifacts and passive analysis. Do not execute unknown samples on the host; use an isolated, approved analysis environment when dynamic analysis is necessary.
- Separate observed evidence from inference. Cite artifact paths, hashes, tool outputs, and limitations; do not claim behavior that was not observed.
- Do not use this rule or a specialist skill as authorization to exploit, persist in, evade defenses on, or exfiltrate from third-party systems.
- Route target selection through `reverse-engineer-anything` or `reverse-skill`; use only the tool or module matching the approved scope.
- Keep credentials, customer data, and proprietary artifacts out of reports unless essential; redact sensitive values.
- For vulnerability findings, report impact and safe remediation; do not weaponize findings outside an explicitly authorized test scope.
