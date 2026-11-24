# Task Board — Media and Reverse Workflow Integration

| ID | Task | Depends on | Status | Done when |
|----|------|------------|--------|-----------|
| T-01 | Add requirements and architecture artifacts | — | Done | SRS and architecture decisions are written |
| T-02 | Add rules, roles, OBS skill, and specialist agents | T-01 | Done | Each specialist is discoverable and references the right safety rules |
| T-03 | Implement OBS MCP package | T-01 | Done | Read/control tools, read-back verification, and explicit production gates are implemented |
| T-04 | Update indexes and partial MCP guidance | T-02, T-03 | Done | Catalogs correctly distinguish ready from docs-only integrations |
| T-05 | Run focused tests and repository gates | T-02, T-03, T-04 | Done | Unit tests, stdio and installer smoke tests, and required integrity checks pass |
