---
name: web-data-acquisition
description: >-
  Plan authorized web research and data collection: search and map URLs, fetch
  and crawl permitted pages, extract structured Markdown or JSON, and design
  reliable crawler pipelines. Prefer official APIs and stop at access controls,
  rate limits, or anti-bot challenges.
---

# Web Data Acquisition

First-party guidance for authorized web research, collection, and extraction. This skill does not install or imply any vendor, scraper, actor, proxy, or MCP runtime.

## When to use

- Search, map, or crawl an explicitly scoped set of permitted web sources.
- Extract user-authorized page content into Markdown, JSON, or a documented dataset schema.
- Design crawler queues, bounded retries, deduplication, checkpoints, and data-quality checks.
- Choose between an official API, an open dataset, a simple HTTP fetch, or approved browser rendering.

## When not to use

- A one-off web lookup is sufficient; prefer the existing research workflow.
- The task is interactive UI testing or an authorized user journey; use `browser-automation`.
- The source, purpose, permitted fields, volume, or destination is unclear.
- The source requires bypassing authentication, a paywall, CAPTCHA, anti-bot controls, or a stated access restriction.

## Procedure

1. **Define scope** — Record the purpose, source domains and paths, allowed fields, expected volume/frequency, output destination, retention, and the user's authority to collect the data.
2. **Choose the least invasive source** — Prefer an official API, licensed/open dataset, or publisher-provided export. Use public-page fetching only when the source's terms and access policies allow it.
3. **Check source constraints** — Review applicable terms, licenses, robots directives, API quotas, and documented rate limits. If they conflict or are ambiguous, pause and ask the user rather than assuming permission.
4. **Select the retrieval method** — Use bounded HTTP fetches for static pages. Use an approved browser workflow for JavaScript-rendered content; see `browser-automation`. Use a crawler design only when scale requires queues, deduplication, checkpoints, and explicit limits.
5. **Bound requests** — Set timeouts, concurrency, a descriptive user agent when appropriate, caching, and conservative backoff. Honor `Retry-After` and documented quotas. Do not retry in a way that evades a block.
6. **Extract with provenance** — Define a schema before collection. Keep source URL, retrieval time, extraction method, and validation status; distinguish missing, inferred, and observed values.
7. **Minimize and validate** — Collect only necessary fields, avoid sensitive or personal data unless explicitly authorized and necessary, validate schema and quality, and redact before sharing.
8. **Store and report** — Write only to the approved destination, apply retention/deletion requirements, and report sources, volume, limitations, and failures. Do not silently substitute a different source or data sink.

## Stop conditions

Stop collection at authentication or authorization barriers, paywalls, CAPTCHA, explicit denial, robots disallow directives, repeated `403` responses, or rate limiting. For `429`, pause and honor the source's stated retry window; if no safe window is clear, stop and ask. Never rotate identities or proxies to continue after a block.

## Safety and privacy

- Publicly reachable content is not automatically licensed for bulk reuse or free of personal data.
- Do not collect credentials, session cookies, private profiles, or sensitive personal data through scraping.
- Do not evade access controls, bot protections, rate limits, or platform restrictions.
- Do not submit forms, post content, follow accounts, purchase items, or trigger other side effects as a collection shortcut.
- Require separate explicit approval for recurring jobs, third-party data processors, or writes to external destinations.
- Follow `rules/web-data-acquisition.md` and `rules/privacy.md`.

## Definition of done

- [ ] Purpose, source scope, data fields, limits, destination, and retention are recorded.
- [ ] The chosen method respects source policy and stops safely on restrictions.
- [ ] Output is schema-validated, minimized, and traceable to sources.
- [ ] Errors, omissions, and limitations are reported; no hidden third-party runtime is assumed.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
