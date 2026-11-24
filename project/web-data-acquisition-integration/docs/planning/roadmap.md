# Roadmap — Web Data Acquisition Integration

| Milestone | Outcome | Status |
|-----------|---------|--------|
| M1 — Requirements and safety boundaries | Scope, allowed collection, privacy, and stop conditions defined | Done |
| M2 — Canonical playbooks | Web data skill authored; browser skill extended without duplicating bulk collection guidance | Done |
| M3 — Repository routing | Rule, role, agent, Orchestrator, catalogs, and docs-only MCP entry aligned | Done |
| M4 — Quality verification | Cross-reference, structural, whitespace, and attribution gates recorded | Done |

## Work breakdown

| WBS | Work | Owner | Dependency | Status |
|------|------|-------|------------|--------|
| 1.1 | Define functional scope and collection stop conditions | Business/System Analysis | — | Done |
| 1.2 | Choose canonical skill boundaries and MCP maturity | Solution Architect | 1.1 | Done |
| 2.1 | Author web-data skill and rule | Web Data Acquisition Engineer | 1.1, 1.2 | Done |
| 2.2 | Extend browser automation and aliases | Browser Automation / Web Data Acquisition Engineer | 1.2 | Done |
| 3.1 | Add role, agent, Orchestrator, and catalog routing | Orchestrator / Web Data Acquisition Engineer | 2.1, 2.2 | Done |
| 4.1 | Run validation, direct review, and record results | QA / Code Reviewer | 3.1 | Done |

## Risks

| Risk | Mitigation |
|------|------------|
| Capability aliases could imply vendor affiliation or runtime support. | Clearly document aliases as capability mappings and mark MCP docs-only. |
| Collection may exceed permission or site policy. | Require scope up front and stop at disallow, denial, authentication, and rate-limit boundaries. |
| Personal data may be collected unnecessarily. | Minimize fields, define purpose and retention, and avoid sensitive/private data. |
| A crawler can produce excessive load. | Bound request volume and concurrency; honor `Retry-After`; stop on throttling. |
