# Architecture — Media and Reverse Workflow Integration

## Decisions

### ADR-01: OBS control uses the built-in local obs-websocket API

- OBS Studio 28+ ships obs-websocket by default.
- The MCP is a local Node.js stdio process that connects to `ws://127.0.0.1:4455` by default.
- Only loopback endpoints are accepted; the server does not expose an HTTP listener.
- `OBS_WEBSOCKET_PASSWORD` is required at runtime and is never embedded in the repository fragment.
- Read/status, scene/source, and audio tools map to explicit OBS WebSocket request types.
- Stream and recording start/stop tools require `confirm: true` and a user-approved action.

### ADR-02: Remotion and reverse-engineering do not get fake generic MCP servers

- Remotion uses its existing CLI, Studio, and browser automation workflows; its MCP entry is docs-only.
- Reverse engineering uses target-specific tools already selected by the relevant skill (for example REA, Ghidra, or IDA); its MCP entry is docs-only.
- No unaudited tool download or automatic target connection is introduced by this change.

## Package boundaries

```text
skills/obs-studio/       workflow guidance
roles/engineering/       specialist responsibilities
agents/                  host-discoverable specialist profiles
rules/                   cross-agent safety and media production constraints
mcp/obs-studio/          local stdio server + obs-websocket client
mcp/remotion/            docs-only Studio/CLI guidance
mcp/reverse-engineering/ docs-only tool-specific integration guidance
```

## Error behavior

Invalid configuration, missing credentials, OBS connection failures, invalid arguments, and OBS request failures return MCP tool errors. No status or action reports success unless the underlying OBS request succeeds.
