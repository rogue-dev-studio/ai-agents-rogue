---
name: obs-studio
description: Operate OBS Studio for scenes, sources, audio, recording, and streaming through the official local obs-websocket API. Use for OBS setup, troubleshooting, and consent-gated production control.
---

# OBS Studio

## When to use

- The user asks to configure, inspect, or control OBS Studio.
- The task connects Remotion renders or other authorized media assets to an OBS production workflow.

## When not to use

- The task only creates or renders a Remotion composition; use the Remotion skills.
- The task requires remote OBS control or a network-exposed control endpoint.

## Procedure

1. Read the active project's requirements and `rules/media-production.md`.
2. Confirm OBS Studio 28+ and its built-in obs-websocket service are enabled.
3. Use `mcp/obs-studio/README.md` to install and configure the optional local MCP server.
4. Keep the WebSocket endpoint on loopback and provide `OBS_WEBSOCKET_PASSWORD` through the host environment; never put the password in source or MCP config.
5. Inspect current status, scenes, sources, and audio input state before changing them.
6. Require the user's explicit approval in the current conversation before starting or stopping recording or streaming, and pass `confirm: true` only after that approval.
7. Verify the resulting OBS state after every requested change and report errors rather than assuming success.

## Safety boundaries

- The OBS MCP accepts only localhost/loopback WebSocket URLs.
- Do not start or stop recording or streaming autonomously, as part of a render, or as an implied side effect.
- Do not expose OBS's WebSocket listener to a LAN or the internet.
- Treat scene/source/audio changes as live production changes; make only the change requested.

## Definition of done

- [ ] OBS connection and current state were verified.
- [ ] Only requested scene, source, or audio settings were changed.
- [ ] Recording/streaming actions were explicitly approved and confirmed.
- [ ] Credentials remain outside the repository and logs.
- [ ] The user received the resulting state or the exact error.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
