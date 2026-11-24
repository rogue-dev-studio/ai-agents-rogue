# Privacy Engineering Rules

Apply whenever personal, sensitive, customer, employee, or linkable data is designed, collected, processed, logged, analyzed, or shared.

## Must always

- Define purpose, data categories, data subjects, recipients, lawful/consent basis owner, retention, access, and deletion before collection.
- Minimize data in source code, prompts, logs, analytics, test fixtures, and reports; prefer synthetic or aggregated data.
- Restrict access and use encryption and audit trails appropriate to sensitivity.
- Evaluate re-identification and linkage risk before calling data anonymous; document assumptions and residual risk.
- Route jurisdiction-specific interpretation and material processing changes to the responsible privacy/legal owner.

## Must never

- Infer consent or reuse data for a new purpose without approval.
- Avoid exposing personal data in examples, screenshots, logs, or public reports when redaction or synthesis is sufficient.
- Claim legal compliance or anonymity without supporting evidence and responsible review.
