# Architecture — Web Data Acquisition Integration

## Decision

Use first-party workflow guidance rather than adding scraper code or a provider integration. Keep bulk collection and browser interaction distinct: `web-data-acquisition` owns source discovery, bounded collection, extraction, and provenance; `browser-automation` owns deterministic browser interaction and UI verification.

## Capability mapping

| Requested capability family | Canonical destination |
|-----------------------------|-----------------------|
| Search, URL mapping, single-page fetch, crawl, extraction | `web-data-acquisition` |
| Actor/API/CLI-based collection patterns and rendered scraping | `web-data-acquisition` as vendor-neutral patterns only |
| Browser screenshots and dynamic page interaction | `browser-automation` |
| Large crawler queues, retry, dataset/pipeline design | `web-data-acquisition` |
| Collect → enrich → store workflow | `web-data-acquisition`; destinations must be approved and access-controlled |

## Integration surfaces

- `skills/ALIASES.md`, `skills/CATALOG.md`, and `INDEX.md` expose canonical routing.
- `rules/web-data-acquisition.md` defines scope, rate, privacy, provenance, and stop conditions.
- `roles/engineering/web-data-acquisition.md` owns collection design and delivery quality.
- `agents/web-data-acquisition-engineer.agent.md` is a thin route to that role, skill, and rule.
- `roles/management/ai-orchestrator.md` routes collection tasks and directs UI automation separately.
- `mcp/web-data-acquisition` is docs-only; no generic scraper runtime is implied.

## Safety and privacy boundaries

Use official APIs, permitted exports, or open/licensed data first. Use only explicitly authorized source scope and minimum necessary fields. Stop on access restrictions, denial, robots disallow, CAPTCHA, paywalls, authentication barriers, or rate limits; do not retry around a block. Do not use stealth, proxy rotation, account rotation, or anti-bot bypass. Preserve source, time, method, and retention metadata.
