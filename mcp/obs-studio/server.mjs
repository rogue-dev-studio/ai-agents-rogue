#!/usr/bin/env node
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';
import { createObsService } from './src/obs-service.mjs';
import { createObsToolExecutor, obsTools } from './src/obs-tools.mjs';

const server = new Server(
  { name: 'aar-obs-studio', version: '0.1.0' },
  { capabilities: { tools: {} } },
);
const obs = createObsService();
const execute = createObsToolExecutor(obs);

server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools: obsTools }));
server.setRequestHandler(CallToolRequestSchema, async ({ params }) => {
  try {
    const result = await execute(params.name, params.arguments);
    return { content: [{ type: 'text', text: JSON.stringify(result, null, 2) }] };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    return { content: [{ type: 'text', text: `OBS MCP error: ${message}` }], isError: true };
  }
});

await server.connect(new StdioServerTransport());
