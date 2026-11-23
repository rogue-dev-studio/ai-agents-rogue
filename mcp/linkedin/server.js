require('dotenv').config();
const { Server } = require("@modelcontextprotocol/sdk/server/index.js");
const { StdioServerTransport } = require("@modelcontextprotocol/sdk/server/stdio.js");
const { CallToolRequestSchema, ListToolsRequestSchema } = require("@modelcontextprotocol/sdk/types.js");
const axios = require('axios');

const server = new Server({
  name: "linkedin-mcp-server",
  version: "1.0.0",
}, {
  capabilities: { tools: {} },
});

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "get_profile",
        description: "Get the authenticated user's LinkedIn profile",
        inputSchema: { type: "object", properties: {} },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === "get_profile") {
    try {
      const response = await axios.get('https://api.linkedin.com/v2/me', {
        headers: { 'Authorization': `Bearer ${process.env.LINKEDIN_ACCESS_TOKEN}` }
      });
      return { content: [{ type: "text", text: JSON.stringify(response.data) }] };
    } catch (error) {
      return { content: [{ type: "text", text: `Error: ${error.message}` }] };
    }
  }
  throw new Error("Tool not found");
});

const transport = new StdioServerTransport();
server.connect(transport);
console.error("LinkedIn MCP Server running on stdio");

