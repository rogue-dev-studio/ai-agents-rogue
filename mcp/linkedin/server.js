
console.log("LinkedIn MCP Server starting...");

const { Server } = require("@modelcontextprotocol/sdk/server/index.js");
const { StdioServerTransport } = require("@modelcontextprotocol/sdk/server/stdio.js");

const server = new Server({
  name: "linkedin-mcp-server",
  version: "1.0.0",
}, {
  capabilities: {
    tools: {},
  },
});

// Setup transport and start
const transport = new StdioServerTransport();
server.connect(transport).catch(console.error);

