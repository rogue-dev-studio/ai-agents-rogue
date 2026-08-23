#!/usr/bin/env node
/**
 * @Author: rogue-dev-studio
 * @Date: 2026-08-22 14:00:00
 * @Last Modified by: rogue-dev-studio
 * @Last Modified time: 2026-08-22 14:00:00
 */
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';

const BASE = process.env.YOUTUBE_API_URL ?? 'http://127.0.0.1:8787';

async function api(path, init) {
  const res = await fetch(`${BASE}${path}`, init);
  const data = await res.json();
  if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
  return data;
}

const tools = [
  {
    name: 'youtube_auth_status',
    description: 'Check local YouTube OAuth configuration and channel connection.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
  {
    name: 'youtube_start_auth',
    description: 'Get Google OAuth URL for manual browser login (no auto-upload).',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
  {
    name: 'youtube_upload_video',
    description:
      'Upload MP4 to YouTube only when user explicitly confirms. Requires confirm=true.',
    inputSchema: {
      type: 'object',
      properties: {
        videoPath: { type: 'string', description: 'Absolute path to .mp4 file' },
        title: { type: 'string' },
        description: { type: 'string' },
        descriptionPath: { type: 'string', description: 'Markdown description file path' },
        privacyStatus: { type: 'string', enum: ['public', 'unlisted', 'private'] },
        confirm: {
          type: 'boolean',
          description: 'Must be true — explicit manual upload gate',
        },
      },
      required: ['videoPath', 'title', 'confirm'],
      additionalProperties: false,
    },
  },
];

const server = new Server({ name: 'youtube-mcp', version: '0.1.0' }, { capabilities: { tools: {} } });

server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools }));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  try {
    if (name === 'youtube_auth_status') {
      const data = await api('/auth/status');
      return { content: [{ type: 'text', text: JSON.stringify(data, null, 2) }] };
    }
    if (name === 'youtube_start_auth') {
      const data = await api('/auth/start');
      return {
        content: [
          {
            type: 'text',
            text: `Open this URL in a browser to connect YouTube:\n${data.authUrl}`,
          },
        ],
      };
    }
    if (name === 'youtube_upload_video') {
      if (args?.confirm !== true) {
        throw new Error('Manual upload blocked: set confirm=true after user approval.');
      }
      const data = await api('/upload', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(args),
      });
      return { content: [{ type: 'text', text: JSON.stringify(data, null, 2) }] };
    }
    throw new Error(`Unknown tool: ${name}`);
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    return { content: [{ type: 'text', text: `Error: ${message}` }], isError: true };
  }
});

const transport = new StdioServerTransport();
await server.connect(transport);
