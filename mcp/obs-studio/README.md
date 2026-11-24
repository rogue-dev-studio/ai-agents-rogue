# OBS Studio MCP

Local MCP integration for OBS Studio's official obs-websocket API.

## Requirements

- OBS Studio 28 or newer, with obs-websocket enabled.
- Node.js 18 or newer.
- An OBS WebSocket password configured in OBS Studio.

The server accepts only `localhost`, `127.0.0.1`, or `::1` endpoints. It never opens a listener. OBS itself recommends enabling WebSocket authentication; this package requires `OBS_WEBSOCKET_PASSWORD`.

## Install

From the catalog root:

```powershell
Push-Location .\mcp\obs-studio
npm ci
Pop-Location
.\scripts\install-mcp.ps1 -Target . -Mcp obs-studio -Hosts cursor
```

Configure `OBS_WEBSOCKET_PASSWORD` in the environment of the host application before launching/restarting it. Do not add the password to `.cursor\mcp.json`, a project file, shell history, or source control. The fragment sets only the default loopback URL.

To override the URL, set `OBS_WEBSOCKET_URL` to a loopback `ws://` or `wss://` endpoint. Remote addresses are rejected.

## Tools

Read:

- `obs_get_status`
- `obs_list_scenes`
- `obs_list_scene_sources`
- `obs_get_input_audio_state`

Control scenes and audio:

- `obs_set_scene`
- `obs_set_source_visibility`
- `obs_set_input_mute`
- `obs_set_input_volume`

Production actions:

- `obs_start_recording`, `obs_stop_recording`
- `obs_start_streaming`, `obs_stop_streaming`

Every production action requires `confirm: true`, and the user must explicitly approve that specific action in the current conversation. Do not infer consent from a request to create, render, or preview a video.

Each scene, source, audio, recording, and streaming mutation reads OBS state back before reporting success. A mismatch or OBS request failure is returned as an error.

## Verify

```powershell
Push-Location .\mcp\obs-studio
npm test
node .\server.mjs
```

The final command waits for MCP stdio input; use it only as a manual startup check. For end-to-end testing, install the fragment in the intended host and call `obs_get_status` while OBS is running.

## Troubleshooting

- Missing password: define `OBS_WEBSOCKET_PASSWORD` for the host process and restart the host.
- Connection refused: confirm OBS is running and obs-websocket is enabled on the configured loopback port.
- Authentication failed: update the environment password to match OBS's WebSocket settings.
- Production action blocked: obtain user approval, then pass `confirm: true`.

## Attribution

Catalog implementation by Rogue Development. OBS Studio and obs-websocket are separate projects; see the official [Remote Control Guide](https://obsproject.com/kb/remote-control-guide).
