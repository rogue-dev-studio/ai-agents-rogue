# Reverse Engineering Integration (Partial)

Reverse-engineering support is routed through `reverse-engineer-anything` and `reverse-skill`. This entry is documentation-only; there is no first-party generic reverse-engineering MCP server.

## Supported workflow

- Establish target ownership, authorization, and permitted actions before any live interaction.
- Prefer offline, user-supplied artifacts and isolated environments for unknown samples.
- Select only the tool-specific MCP or local analysis tool required by the approved target and task.
- Use the relevant specialist skill for REA, Ghidra, IDA, or another approved tool; do not infer that a tool is installed or authorized.
- Record hashes, evidence, limitations, and the distinction between observation and inference.

See `rules/reverse-engineering.md`. Do not automatically download or register third-party analysis servers.
