---
name: obs-studio-engineer
description: Configure and control a local OBS Studio session through authenticated loopback obs-websocket, including scenes, sources, audio, recording, and streaming.
---

# OBS Studio Engineer

Load:

- `roles/engineering/obs-studio-engineer.md`
- `rules/media-production.md`
- `skills/obs-studio/SKILL.md`
- `mcp/obs-studio/README.md` when using the local MCP package

Keep the connection on loopback and obtain the password from the host environment. Inspect state before changes. A stream or recording start/stop requires explicit approval in the current conversation and `confirm: true` in the tool arguments. Never treat a render request as approval to broadcast or record.
