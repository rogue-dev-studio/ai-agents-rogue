<#
.SYNOPSIS
  Auto-detect Blender version and wire Lab MCP (5.1+) or community MCP (<5.1).
.DESCRIPTION
  Does not modify sealed install-mcp.ps1. Writes machine-local manifest under
  active-mcp/ (gitignored). Removes conflicting blender / blender-lab host entry.
.EXAMPLE
  .\install-blender-mcp-auto.ps1 -Target .
#>
param(
  [string]$Target = ".",
  [string]$CatalogRoot = "",
  [string[]]$Hosts = @("all"),
  [switch]$SkipGates
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
  $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
  $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}
$TargetRoot = (Resolve-Path $Target).Path

$resolveScript = Join-Path $PSScriptRoot "resolve-blender-mcp.ps1"
$resolved = & $resolveScript -CatalogRoot $CatalogRoot
$pkg = [string]$resolved.PackageId
$remove = @($resolved.AlternateRemove)

Write-Host "Blender MCP auto: $pkg ($($resolved.Reason))"

$manifestDir = Join-Path $CatalogRoot "active-mcp"
if (-not (Test-Path -LiteralPath $manifestDir)) {
  New-Item -ItemType Directory -Path $manifestDir -Force | Out-Null
}
$manifest = [ordered]@{
  packageId      = $pkg
  blenderVersion = $resolved.BlenderVersion
  labMinVersion  = $resolved.LabMinVersion
  resolvedAt     = (Get-Date -Format "o")
  reason         = $resolved.Reason
  mode           = "auto-version"
  blenderExe     = $resolved.BlenderExe
}
($manifest | ConvertTo-Json -Depth 4) + "`n" | Set-Content -LiteralPath (Join-Path $manifestDir "blender.json") -Encoding UTF8

function Remove-ConflictingMcpEntries([string[]]$Paths, [string[]]$Ids) {
  foreach ($path in $Paths) {
    if (-not (Test-Path -LiteralPath $path)) { continue }
    try {
      $json = Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
      Write-Warning "Skip unreadable MCP config: $path"
      continue
    }
    if (-not $json.mcpServers) { continue }
    $changed = $false
    $map = @{}
    foreach ($p in $json.mcpServers.PSObject.Properties) {
      if ($Ids -contains $p.Name) {
        Write-Host "  - remove $($p.Name) from $path"
        $changed = $true
        continue
      }
      $map[$p.Name] = $p.Value
    }
    if ($changed) {
      $json.mcpServers = [pscustomobject]$map
      ($json | ConvertTo-Json -Depth 14) + "`n" | Set-Content -LiteralPath $path -Encoding UTF8
    }
  }
}

$hostConfigs = @(
  (Join-Path $TargetRoot ".cursor\mcp.json"),
  (Join-Path $TargetRoot ".mcp.json"),
  (Join-Path $TargetRoot ".agents\mcp.json"),
  (Join-Path $TargetRoot "opencode.json")
)
Remove-ConflictingMcpEntries $hostConfigs $remove

$installArgs = @(
  "-NoProfile", "-ExecutionPolicy", "Bypass",
  "-File", (Join-Path $PSScriptRoot "install-mcp.ps1"),
  "-Target", $TargetRoot,
  "-Mcp", $pkg,
  "-Hosts", ($Hosts -join ",")
)
if ($SkipGates) { $installArgs += "-SkipGates" }
& powershell @installArgs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Done. Restart host AI. Blender: Start MCP Server on :9876."
exit 0
