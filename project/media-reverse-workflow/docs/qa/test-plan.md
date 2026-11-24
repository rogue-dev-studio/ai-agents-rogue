# QA Test Plan — Media and Reverse Workflow Integration

## Focused MCP tests

- Accept the default loopback URL and reject remote hosts, unsupported protocols, URL credentials, and missing passwords.
- Reject invalid scene IDs, empty names, invalid volume bounds, and missing production confirmation.
- Verify every OBS operation maps to its expected obs-websocket request and arguments.
- Verify scene, source, mute, and volume changes against the state returned by OBS.
- Verify audio input inspection returns the mute state and volume in decibels.
- Verify request errors are returned as MCP errors and no failed call is shaped as success.
- Verify serialized operations use one OBS connection and do not race concurrent callers.

## Catalog checks

- New skill has the required attribution footer and appears in both indexes.
- Every Ready MCP package has a valid fragment; docs-only packages have none.
- Fragment JSON parses and includes no password.
- Attribution seal, official upstream pin, entitlement, and compliance checks pass.
- `git diff --check` reports no whitespace errors.
