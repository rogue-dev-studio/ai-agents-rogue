# Remotion Integration (Partial)

Remotion is supported through its CLI, Remotion Studio, and the repository's `remotion-*` skills. This package is documentation-only; there is no generic Remotion MCP server or configuration fragment.

## Supported workflow

- Create/edit compositions with `remotion-create`, `remotion-markup`, and `remotion-interactivity`.
- Preview in Studio with `remotion-studio`.
- Render/export with `remotion-render`.
- Use `browser-automation` to inspect Studio when a browser interaction is needed.
- Check commercial terms with `remotion-license`.
- Hand a rendered asset to OBS only when explicitly requested; see `mcp/obs-studio/README.md`.

Do not install an unrelated third-party MCP server as a substitute for the Remotion CLI or Studio.
