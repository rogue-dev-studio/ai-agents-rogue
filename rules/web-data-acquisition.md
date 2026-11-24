# Web Data Acquisition Rules

Apply when an agent searches, fetches, maps, crawls, screenshots, or extracts data from websites or web APIs.

## Must always

- Record the collection purpose, authorized source scope, allowed data fields, request volume/frequency, destination, and retention before collection.
- Prefer official APIs, publisher exports, or open/licensed datasets over page scraping.
- Check applicable source terms, licenses, robots directives, and documented quotas; pause when authority or restrictions are unclear.
- Use bounded timeouts, concurrency, retries, and conservative backoff. Honor `Retry-After` and identify automated clients where appropriate.
- Treat reachable public pages as potentially copyrighted, licensed, personal, or otherwise restricted data.
- Preserve source URL, retrieval time, method, validation status, and material limitations.
- Minimize personal data and apply `rules/privacy.md` whenever data may identify or link to a person.
- Require explicit approval for recurring jobs, third-party processors, or writes to external storage/services.

## Must never

- Bypass authentication, authorization, paywalls, CAPTCHA, anti-bot controls, IP blocks, or rate limits.
- Use rotating proxies, account rotation, stealth settings, forged identities, or fingerprint evasion to continue after a restriction.
- Collect credentials, session cookies, private-account content, or sensitive personal data by scraping.
- Continue after explicit denial, robots disallow, repeated `403`, or a rate limit without a clearly permitted retry window.
- Submit forms, post, follow, purchase, or trigger other side effects unless the user separately requested and authorized that exact action.
- Treat a named vendor, actor, API, or MCP as installed, approved, or available unless it is explicitly configured.

When blocked, stop, report the response and scope limitation, and offer an approved API/export or another user-authorized source. Do not silently change targets or methods.
