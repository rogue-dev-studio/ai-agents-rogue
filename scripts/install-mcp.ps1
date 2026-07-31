<#
.SYNOPSIS
  Merge AI Agents Rogue MCP package fragments into host MCP config files.
.PARAMETER Target
  Project root
.PARAMETER Mcp
  Package id(s): none | blender | all | comma-list
.PARAMETER Hosts
  Which hosts to wire: cursor, claude, opencode, antigravity, generic, all (default)
.PARAMETER CatalogRoot
  Catalog root (default: parent of scripts/)
.PARAMETER SkipGates
  Skip attribution/entitlement when already verified by install.ps1
#>
param(
  [string]$Target = ".",
  # string[] so PowerShell comma lists (context7,playwright) are not space-joined
  [string[]]$Mcp = @("blender"),
  [string[]]$Hosts = @("all"),
  [string]$CatalogRoot = "",
  [switch]$SkipGates
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
  $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
  $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}
$TargetRoot = (Resolve-Path $Target).Path

if (-not $SkipGates) {
  & (Join-Path $PSScriptRoot "verify-attribution.ps1") -CatalogRoot $CatalogRoot
  if ($LASTEXITCODE -ne 0) { exit 1 }
  & (Join-Path $PSScriptRoot "verify-official-upstream.ps1") -CatalogRoot $CatalogRoot
  if ($LASTEXITCODE -ne 0) { exit 1 }
  & (Join-Path $PSScriptRoot "check-github-entitlement.ps1") -CatalogRoot $CatalogRoot
  if ($LASTEXITCODE -ne 0) { exit 1 }
}

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path $Path)) { New-Item -ItemType Directory -Path $Path -Force | Out-Null }
}

function Get-McpPackageIds($Spec) {
  $parts = @()
  foreach ($s in @($Spec)) {
    if ($null -eq $s) { continue }
    $parts += @("$s".Split(",") | ForEach-Object { $_.Trim().ToLowerInvariant() } | Where-Object { $_ })
  }
  if ($parts.Count -eq 0 -or ($parts.Count -eq 1 -and $parts[0] -eq "none")) { return @() }
  $mcpRoot = Join-Path $CatalogRoot "mcp"
  if ($parts -contains "all" -or $parts -contains "all-available") {
    $ids = @()
    Get-ChildItem $mcpRoot -Directory -ErrorAction SilentlyContinue |
      Where-Object { $_.Name -notlike "_*" -and (Test-Path (Join-Path $_.FullName "cursor.mcp.fragment.json")) } |
      ForEach-Object { $ids += $_.Name }
    return $ids
  }
  return $parts
}

function Get-HostList($HostsSpec) {
  $h = @()
  foreach ($s in @($HostsSpec)) {
    if ($null -eq $s) { continue }
    $h += @("$s".Split(",") | ForEach-Object { $_.Trim().ToLowerInvariant() } | Where-Object { $_ })
  }
  if ($h -contains "all") {
    return @("cursor", "claude", "opencode", "antigravity", "generic")
  }
  return $h
}

function Read-JsonFile([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) { return $null }
  try {
    return (Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json)
  } catch {
    Write-Warning "Could not parse JSON: $Path"
    return $null
  }
}

function Write-JsonFile([string]$Path, $Object) {
  Ensure-Dir (Split-Path $Path)
  $json = $Object | ConvertTo-Json -Depth 14
  [System.IO.File]::WriteAllText($Path, $json + "`n")
}

function Get-FragmentObject([string]$PkgDir) {
  $fragPath = Join-Path $PkgDir "cursor.mcp.fragment.json"
  if (-not (Test-Path -LiteralPath $fragPath)) { return $null }
  $uvxOk = $false
  try { $null = Get-Command uvx -ErrorAction Stop; $uvxOk = $true } catch {}
  $nodeFrag = Join-Path $PkgDir "cursor.mcp.fragment.node.json"
  if (-not $uvxOk -and (Test-Path -LiteralPath $nodeFrag)) {
    Write-Host "uvx not found; using node launcher fragment for $(Split-Path $PkgDir -Leaf)"
    $fragPath = $nodeFrag
  }
  $catalogToken = ($CatalogRoot -replace '\\', '/')
  $raw = [System.IO.File]::ReadAllText($fragPath).Replace('${AAR_CATALOG}', $catalogToken)
  return ($raw | ConvertFrom-Json)
}

function Merge-McpServersIntoHashtable($ExistingServers, $Fragment) {
  $map = @{}
  if ($ExistingServers) {
    foreach ($p in $ExistingServers.PSObject.Properties) { $map[$p.Name] = $p.Value }
  }
  if ($Fragment -and $Fragment.mcpServers) {
    foreach ($p in $Fragment.mcpServers.PSObject.Properties) {
      $map[$p.Name] = $p.Value
      Write-Host "  + $($p.Name)"
    }
  }
  return $map
}

function ConvertTo-OpenCodeServer($CursorServer) {
  # Cursor: { command, args, env, url } -> OpenCode: { type local|remote, command[], environment, url }
  if ($CursorServer.url) {
    $o = [ordered]@{ type = "remote"; url = [string]$CursorServer.url }
    if ($CursorServer.headers) { $o.headers = $CursorServer.headers }
    return [pscustomobject]$o
  }
  $cmd = @()
  if ($CursorServer.command) { $cmd += [string]$CursorServer.command }
  if ($CursorServer.args) {
    foreach ($a in @($CursorServer.args)) { $cmd += [string]$a }
  }
  $o = [ordered]@{ type = "local"; command = $cmd }
  if ($CursorServer.env) { $o.environment = $CursorServer.env }
  return [pscustomobject]$o
}

function Merge-CursorStyle([string]$DestPath, $Fragment) {
  $existing = Read-JsonFile $DestPath
  $servers = $null
  if ($existing -and $existing.mcpServers) { $servers = $existing.mcpServers }
  $map = Merge-McpServersIntoHashtable $servers $Fragment
  Write-JsonFile $DestPath ([pscustomobject]@{ mcpServers = [pscustomobject]$map })
  Write-Host "Wrote/updated: $DestPath"
}

function Merge-OpenCode([string]$DestPath, $Fragment) {
  $existing = Read-JsonFile $DestPath
  if (-not $existing) {
    $existing = [pscustomobject]@{
      '$schema' = "https://opencode.ai/config.json"
      mcp = [pscustomobject]@{ servers = [pscustomobject]@{} }
    }
  }
  # Ensure mcp.servers exists
  $serversObj = $null
  if ($existing.mcp -and $existing.mcp.servers) {
    $serversObj = $existing.mcp.servers
  } elseif ($existing.mcp) {
    # older flat form under mcp - preserve other keys if any
  }
  $map = @{}
  if ($serversObj) {
    foreach ($p in $serversObj.PSObject.Properties) { $map[$p.Name] = $p.Value }
  }
  if ($Fragment.mcpServers) {
    foreach ($p in $Fragment.mcpServers.PSObject.Properties) {
      $map[$p.Name] = ConvertTo-OpenCodeServer $p.Value
      Write-Host "  + $($p.Name) (opencode)"
    }
  }
  $mcpProp = [pscustomobject]@{ servers = [pscustomobject]$map }
  # Rebuild root preserving unrelated keys
  $hash = [ordered]@{}
  foreach ($p in $existing.PSObject.Properties) {
    if ($p.Name -eq 'mcp') { continue }
    $hash[$p.Name] = $p.Value
  }
  if (-not $hash.Contains('$schema') -and -not $hash.Contains('schema')) {
    $hash['$schema'] = "https://opencode.ai/config.json"
  }
  $hash['mcp'] = $mcpProp
  Write-JsonFile $DestPath ([pscustomobject]$hash)
  Write-Host "Wrote/updated: $DestPath"
}

$ids = Get-McpPackageIds $Mcp
if ($ids.Count -eq 0) {
  Write-Host "MCP: none (skip)"
  exit 0
}

$hostList = Get-HostList $Hosts
Write-Host "MCP packages: $($ids -join ', ')"
Write-Host "MCP hosts:    $($hostList -join ', ')"

foreach ($id in $ids) {
  $pkgDir = Join-Path $CatalogRoot "mcp\$id"
  if (-not (Test-Path $pkgDir)) {
    Write-Error "Unknown MCP package: $id (expected mcp/$id)"
    exit 1
  }
  $frag = Get-FragmentObject $pkgDir
  if (-not $frag) {
    Write-Warning "MCP package '$id' has no cursor.mcp.fragment.json (partial?) - skip; see mcp/$id/README.md"
    continue
  }
  Write-Host "MCP package: $id"
  foreach ($h in $hostList) {
    switch ($h) {
      "cursor" {
        Merge-CursorStyle (Join-Path $TargetRoot ".cursor\mcp.json") $frag
      }
      "claude" {
        # Claude Code project MCP (same mcpServers shape as Cursor)
        Merge-CursorStyle (Join-Path $TargetRoot ".mcp.json") $frag
      }
      "opencode" {
        Merge-OpenCode (Join-Path $TargetRoot "opencode.json") $frag
      }
      "antigravity" {
        Merge-CursorStyle (Join-Path $TargetRoot ".agents\mcp.json") $frag
      }
      "generic" {
        Merge-CursorStyle (Join-Path $TargetRoot ".agents\mcp.json") $frag
      }
      default { Write-Warning "Unknown MCP host '$h' - skip" }
    }
  }
  Write-Host "MCP package done: $id (see mcp/$id/README.md)"
}

Write-Host "Restart each host after MCP config changes. Blender also needs addon server on :9876."
exit 0
