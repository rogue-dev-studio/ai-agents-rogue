---
name: remotion-studio
description: Preview a Remotion video
version: 4.0.546
---

When creating or editing a video, you SHOULD open Studio once the project can run, so the user can preview changes and steer.

In Cursor, run Studio without `--no-open` so the browser opens automatically:

```bash
npx remotion studio
```

In other agent clients, you can also let Studio open the browser automatically with the command above. If you have an in-app browser and intend to use it, run:

```bash
npx remotion studio --no-open
```

If the Studio is already opened, the URL will be printed and the command will exit.
Otherwise, a long-running process will start, and the URL will be printed.

When using `--no-open`, open the exact printed URL in the in-app browser and verify that Studio loads. Once a composition exists, verify that its video preview loads. Do not use `--no-open` if you cannot open the URL in the in-app browser.

## Useful flags

| Argument          | Purpose                                                                                       |
| ----------------- | --------------------------------------------------------------------------------------------- |
| `--log=<level>`   | Set `error`, `warn`, `info` (default), or `verbose` logging.                                  |
| `--port=<number>` | Request a Studio server port; otherwise Remotion finds a free port.                           |
| `--force-new`     | Start another Studio instance even when one is already running for the same project and port. |
## Catalog provenance

- Upstream: [Remotion Agent Skills](https://github.com/remotion-dev/remotion/tree/main/packages/skills)
- Imported from Remotion `v4.0.546` (`4664bd64e6364f92b7e2994db775b28ad1af38a9`).
- Upstream license: MIT, as declared by the official Remotion Agent Plugin.
- Remotion itself has separate usage terms; consult `remotion-license` before commercial use.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.


