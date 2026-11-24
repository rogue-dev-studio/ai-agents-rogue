# Web Data Acquisition MCP Guidance

Status: **partial** — documentation only. This repository does not include a web-scraping MCP server, vendor API credentials, actor runtime, proxy service, or installable fragment.

## Scope

Use the first-party `web-data-acquisition` skill and role to design authorized research and collection workflows. `browser-automation` covers approved rendered-page interaction and screenshots. This entry does not install or configure Firecrawl, Apify, Scrapfly, Bright Data, Decodo, ScrapingBot, Scrapling, Crawlee, Crawl4AI, or other third-party services.

## Requirements for any future integration

- Define source, purpose, permitted fields, volume, data flow, retention, and owner.
- Prefer official APIs and authorized exports; use least-privilege credentials held outside the repository.
- Require a separate security/privacy review, explicit allowlisting, local tests, and documented processor terms before wiring a service.
- Enforce bounded request rates and stop on authentication barriers, CAPTCHA, paywalls, blocks, or rate limits.
- Never enable proxy rotation, anti-bot bypass, identity evasion, or collection of private credentials/session data.

## Related first-party guidance

- `skills/web-data-acquisition/SKILL.md`
- `skills/browser-automation/SKILL.md`
- `rules/web-data-acquisition.md`
- `rules/privacy.md`
- `roles/engineering/web-data-acquisition.md`
