# Media Production Rules

Apply to Remotion, OBS Studio, and media handoffs.

## Remotion

- Route creation, markup, preview, rendering, captions, maps, and licensing through the relevant `remotion-*` skills.
- Follow `remotion-license` before commercial use or when license status is unclear.
- Keep compositions deterministic and editable in Studio where the request expects editability.
- Treat generated or rendered media as a deliverable; do not publish or upload it without explicit user approval.
- OBS is an optional presentation/recording destination, not an automatic side effect of rendering.

## OBS Studio

- Use the official built-in obs-websocket interface, local loopback only, with authentication enabled.
- Store the WebSocket password in the host environment or secret store, never in the repository or generated MCP config.
- Inspect OBS state before changing it and verify state after the change.
- Require explicit approval in the current conversation before starting or stopping a stream or recording; the MCP call must additionally include `confirm: true`.
- Never infer permission to publish, broadcast, or record from a request to create or render media.

## Media rights and privacy

- Use only user-provided, licensed, or otherwise authorized media.
- Avoid capturing personal, private, or confidential content unless it is necessary and the user authorized that capture.
- Preserve required attribution and licensing information in publish handoffs.
