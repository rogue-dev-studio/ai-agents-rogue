# SRS — Media Production and Reverse Engineering Workflow

Version: 1.0  
Status: Approved by user scope selection  
Project: `media-reverse-workflow`

## 1. Problem and goal

The catalog contains Remotion and reverse-engineering skills, but does not yet route them consistently through rules, roles, agents, and MCP guidance. OBS Studio also needs a first-party workflow, including a usable local MCP integration.

The goal is to make these capabilities discoverable and safe to use without importing more third-party skill content or exposing credentials.

## 2. Actors

- AI Orchestrator: routes requests and coordinates delivery.
- Remotion Engineer: creates, previews, and renders Remotion compositions.
- Reverse Engineer: analyzes authorized artifacts and reports evidence-backed findings.
- OBS Studio Engineer: configures OBS workflows and its local MCP server.
- User: grants target scope and confirms production-impacting actions.

## 3. Scope

### In scope

- Add an OBS Studio skill, engineering role, custom agent, rule, and local OBS WebSocket MCP package.
- Integrate existing Remotion and reverse-engineering skills with rules, roles, agents, and orchestrator routing.
- Document Remotion and reverse-engineering MCP options as partial integrations where no first-party generic server is provided.
- Add project documentation, catalog entries, install guidance, and focused tests.

### Out of scope

- Starting OBS or configuring a live production setup automatically.
- Remote OBS control, OBS plugin installation, media publishing, or deployment.
- Building a general-purpose reverse-engineering MCP server.
- Building a Remotion MCP server; existing Remotion Studio and browser workflows remain the supported route.
- Changing the existing third-party skill payloads beyond a narrow Remotion-to-OBS handoff note.

## 4. Functional requirements

| ID | Requirement |
|----|-------------|
| FR-01 | The catalog must expose an OBS Studio skill and route OBS, Remotion, and authorized reverse-engineering work to dedicated roles and agents. |
| FR-02 | The OBS MCP server must report OBS status, list scenes and scene sources, inspect input mute/volume, switch scenes, change source visibility, and set input mute/volume. |
| FR-03 | The OBS MCP server must support starting and stopping recording and streaming only when the tool call includes `confirm: true`. |
| FR-04 | The OBS MCP server must default to loopback and reject non-loopback WebSocket URLs. |
| FR-05 | The OBS MCP server must obtain the WebSocket password from `OBS_WEBSOCKET_PASSWORD`; the repository and generated MCP fragment must contain no real password. |
| FR-06 | The Remotion and reverse-engineering MCP catalog entries must accurately state that they are docs-only/partial and must not pretend to provide a generic server. |
| FR-07 | Reverse-engineering guidance must require authorized scope and evidence-based reporting; it must not authorize activity against an unspecified third-party target. |

## 5. Non-functional requirements

- NFR-01: use the official OBS built-in obs-websocket interface (OBS Studio 28+), with a maintained JavaScript client.
- NFR-02: expose clear errors to MCP callers and keep protocol traffic on stdout only.
- NFR-03: serialize OBS requests so concurrent calls cannot create competing WebSocket identifications.
- NFR-04: use the repository's existing Node.js MCP conventions and built-in Node test runner.
- NFR-05: do not add secrets, machine-specific paths, or generated dependency trees to the repository.

## 6. Acceptance criteria

1. Given the catalog is installed, when users search the index, then the OBS skill, three specialist roles/agents, integration rules, and MCP maturity are visible.
2. Given the OBS MCP is called without OBS running or without required credentials, when a tool executes, then it returns an explicit MCP error and does not report a success-shaped fallback.
3. Given the OBS URL points to a non-loopback host, when the server initializes, then it rejects the configuration before opening a network connection.
4. Given a caller requests audio inspection, when an existing input name is supplied, then the server returns its mute state and volume in decibels.
5. Given a caller requests scene/source/audio changes, when valid arguments are supplied, then the server sends the matching obs-websocket request and verifies the resulting state.
6. Given recording or streaming control is requested without `confirm: true`, when the call executes, then it is rejected and no production request is sent.
7. Given all new files are present, when catalog, attribution, compliance, MCP fragment, and focused unit checks run, then they pass without changing unrelated existing files.

## 7. Open questions

- None. User selected all OBS control categories; the implementation will apply the confirmation gate to all start/stop recording and streaming calls.

## 8. Assumptions and risks

- OBS Studio 28+ is available locally and has obs-websocket authentication enabled.
- A production-impacting action is permitted only when the user explicitly requests it in the active conversation; `confirm: true` is a second runtime gate, not a replacement for user approval.
- Scene switching and audio/source state changes can affect a live show; the MCP is installed only when explicitly selected and must be used within the user's authorized OBS session.
- The MCP remains loopback-only even if the user attempts to configure a LAN endpoint.
