# MCP package: comfyui (partial)

Run [ComfyUI](https://github.com/comfyanonymous/ComfyUI) locally (GPU recommended), then add an MCP server entry when you have a ComfyUI MCP implementation to point at.

## Steps

1. Install/run ComfyUI with GPU
2. Place or install a ComfyUI MCP server locally
3. Add a `command`/`args` entry to `.cursor/mcp.json` (or use `install-mcp` once a fragment exists)
4. Restart the AI host

Status: **partial** — not auto-merged by `install-mcp -Mcp all` until a fragment is added.
