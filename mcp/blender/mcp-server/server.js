#!/usr/bin/env node
/**
 * Blender MCP Server Launcher (AI Agents Rogue)
 *
 * Starts blender-mcp which talks to the BlenderMCP addon (socket :9876).
 * Prefer: uvx blender-mcp
 * Fallback: python -m blender_mcp.server
 *
 * AI Agents Rogue local launcher for Cursor / other MCP hosts.
 */
const { spawn, execSync } = require('child_process');

const BLENDER_HOST = process.env.BLENDER_HOST || 'localhost';
const BLENDER_PORT = process.env.BLENDER_PORT || '9876';

function cmdExists(cmd) {
  try {
    if (process.platform === 'win32') {
      execSync(`where ${cmd}`, { stdio: 'pipe' });
    } else {
      execSync(`command -v ${cmd}`, { stdio: 'pipe', shell: true });
    }
    return true;
  } catch {
    return false;
  }
}

function hasModule(pythonBin, mod) {
  try {
    execSync(`"${pythonBin}" -c "import ${mod}"`, { stdio: 'pipe' });
    return true;
  } catch {
    return false;
  }
}

function pickPython() {
  for (const bin of ['python', 'python3', 'py']) {
    if (cmdExists(bin) && hasModule(bin, 'blender_mcp')) return bin;
  }
  return null;
}

function startServer() {
  const env = { ...process.env, BLENDER_HOST, BLENDER_PORT };
  let child;

  if (cmdExists('uvx')) {
    console.error(`Using uvx blender-mcp → ${BLENDER_HOST}:${BLENDER_PORT}`);
    child = spawn('uvx', ['blender-mcp'], { env, stdio: 'inherit', shell: process.platform === 'win32' });
  } else {
    const py = pickPython();
    if (!py) {
      console.error('blender-mcp not found.');
      console.error('Install:  pip install blender-mcp');
      console.error('Or:       winget/scoop/uv install uv  then use uvx blender-mcp');
      process.exit(1);
    }
    console.error(`Using ${py} -m blender_mcp.server → ${BLENDER_HOST}:${BLENDER_PORT}`);
    child = spawn(py, ['-m', 'blender_mcp.server'], { env, stdio: 'inherit', shell: process.platform === 'win32' });
  }

  child.on('error', (err) => {
    console.error('Failed to start Blender MCP:', err.message);
    process.exit(1);
  });
  child.on('exit', (code) => process.exit(code || 0));
}

startServer();
