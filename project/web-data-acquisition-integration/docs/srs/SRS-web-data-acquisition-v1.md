# SRS — Web Data Acquisition Integration

## 1. Problem and goal

Unify the user-requested web search, URL mapping, page collection, crawling, extraction, scraper architecture, and browser automation capabilities into discoverable first-party guidance in AI Agents Rogue.

## 2. Scope

### In scope

- One canonical `web-data-acquisition` skill for permitted search, mapping, bounded crawling, structured extraction, and collect/enrich/store pipeline design.
- Extend the existing `browser-automation` skill for permitted rendered-page access, screenshots, and deterministic browser interaction.
- Add the matching rule, engineering role, agent wrapper, Orchestrator routes, catalog/index entries, and docs-only MCP record.
- Represent the 14 requested ecosystems as capability aliases only, without implying affiliation or a live integration.

### Out of scope

- Copying, installing, or vendoring third-party skills, agents, source, or licenses.
- Installing scraper runtimes, actors, SDKs, MCP servers, provider credentials, or proxy services.
- Bypassing authentication, paywalls, CAPTCHA, robots exclusions, anti-bot controls, explicit denials, or rate limits.
- Collecting private, sensitive, or unnecessary personal data.

## 3. Functional requirements

| ID | Requirement | Acceptance criteria |
|----|-------------|---------------------|
| FR-01 | Consolidate the requested capabilities into canonical house skills. | Search, map, crawl, extract, crawler libraries, and collect/enrich/store map to `web-data-acquisition`; browser interaction maps to `browser-automation`. |
| FR-02 | Require a documented collection scope. | Before collection, the operator records purpose, allowed domains/paths, fields, volume/cadence, destination, and retention. |
| FR-03 | Enforce conservative stop conditions. | The workflow stops at access restrictions, disallow signals, denials, CAPTCHA, paywalls, authentication barriers, and rate limits; `429` honors `Retry-After`. |
| FR-04 | Provide first-party orchestration and ownership. | Orchestrator routes relevant tasks to the web data role/agent with the collection and privacy rules. |
| FR-05 | Avoid implying an implementation that is not present. | MCP catalog labels the integration docs-only and lists no runnable provider/runtime. |
| FR-06 | Preserve privacy and traceability. | Output records source URL, retrieval time, method, and permitted provenance; collected fields are minimized and retention is defined. |

## 4. Non-functional requirements

- No new dependencies, network access, credentials, or runtime integrations are introduced.
- Guidance is portable and explicit about authorization, privacy, limits, and error handling.
- Existing browser testing behavior remains available and does not become a bulk-scraping route.

## 5. Assumptions and risks

- Vendor/platform names in the request are aliases for capability discovery, not endorsements, upstream content imports, or integration claims.
- Public visibility does not itself establish permission to collect or reuse data.
- Data rights and site policies vary; the workflow prefers official APIs, permitted exports, and open/licensed datasets.
- A production scraper or provider-specific MCP requires separate scope, security, licensing, and architecture approval.
