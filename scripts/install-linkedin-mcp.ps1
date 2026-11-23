<#
.SYNOPSIS
  Install LinkedIn MCP Server dependencies.
#>
param()

$mcpPath = Join-Path $PSScriptRoot "..\mcp\linkedin"
Write-Host "Installing LinkedIn MCP Server dependencies..."
Set-Location $mcpPath
npm install

Write-Host "Dependencies installed."
Write-Host "Set your LINKEDIN_CLIENT_ID and LINKEDIN_CLIENT_SECRET environment variables."
