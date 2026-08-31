<#
.SYNOPSIS
  Install AI Agents Rogue into a project (full catalog or one team).
.PARAMETER Target
  Project root (default: current directory).
.PARAMETER Hosts
  Comma-separated: cursor, antigravity, claude, opencode, generic, all
.PARAMETER Team
  Optional team id under teams/ (your own id from teams/_template). If set, only that team's skills/roles install.
.PARAMETER IncludeDomains
  Full-catalog only: sync local domain packs (teams/<id>/ local_skills) without trimming catalog.
  Comma list or array: hr, simrs, all, or none to skip. Default when -Team omitted: hr.
.PARAMETER Mcp
  Optional MCP packages to wire: none (default), blender, all, or comma-list
#>
param(
  [string]$Target = ".",
  [string]$Hosts = "all",
  [string]$Team = "",
  [string[]]$IncludeDomains = @(),
  # string[] so PowerShell comma lists are not space-joined
  [string[]]$Mcp = @("none")
)

$ErrorActionPreference = "Stop"

$CatalogRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$TargetRoot = Resolve-Path $Target

function Assert-AuthorIntegrity {
  $verify = Join-Path $PSScriptRoot "verify-attribution.ps1"
  if (-not (Test-Path -LiteralPath $verify)) {
    Write-Error "missing scripts/verify-attribution.ps1"
    exit 1
  }
  & $verify -CatalogRoot $CatalogRoot.Path
  if ($LASTEXITCODE -ne 0) { exit 1 }
}

function Assert-OfficialUpstream {
  $pin = Join-Path $PSScriptRoot "verify-official-upstream.ps1"
  if (-not (Test-Path -LiteralPath $pin)) {
    Write-Error "missing scripts/verify-official-upstream.ps1"
    exit 1
  }
  & $pin -CatalogRoot $CatalogRoot.Path
  if ($LASTEXITCODE -ne 0) { exit 1 }
}

function Assert-GitHubEntitlement {
  $check = Join-Path $PSScriptRoot "check-github-entitlement.ps1"
  if (-not (Test-Path -LiteralPath $check)) {
    Write-Error "missing scripts/check-github-entitlement.ps1"
    exit 1
  }
  & $check -CatalogRoot $CatalogRoot.Path
  if ($LASTEXITCODE -ne 0) { exit 1 }
}

Assert-AuthorIntegrity
Assert-OfficialUpstream
Assert-GitHubEntitlement

$script:SkillNames = @()  # empty = all skills under skills/
$script:RolePaths = @()  # empty = all roles
$script:CommandNames = @("start-feature", "assist", "set-mode", "new-project")
$script:LocalSkillNames = @()
$script:TeamId = $null
$script:TeamDir = $null

function Get-AllCatalogSkills {
  Get-ChildItem (Join-Path $CatalogRoot "skills") -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
    ForEach-Object { $_.Name }
}
function Ensure-Dir([string]$Path) {
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Copy-Tree([string]$Src, [string]$Dst) {
  if (-not (Test-Path $Src)) { return }
  Ensure-Dir $Dst
  Copy-Item -Path (Join-Path $Src "*") -Destination $Dst -Recurse -Force
}

function Read-TeamManifest([string]$YamlPath) {
  $skills = New-Object System.Collections.Generic.List[string]
  $roles = New-Object System.Collections.Generic.List[string]
  $commands = New-Object System.Collections.Generic.List[string]
  $localSkills = New-Object System.Collections.Generic.List[string]
  $section = $null
  foreach ($line in Get-Content $YamlPath) {
    if ($line -match '^\s*#') { continue }
    if ($line -match '^(skills|roles|commands|local_skills)\s*:') {
      $section = $Matches[1]
      if ($line -match '\[\s*\]') { $section = $null }
      continue
    }
    if ($line -match '^[a-zA-Z_][a-zA-Z0-9_]*\s*:') { $section = $null; continue }
    if ($section -and $line -match '^\s*-\s+(\S+)\s*$') {
      $val = $Matches[1].Trim()
      switch ($section) {
        "skills" { [void]$skills.Add($val) }
        "roles" { [void]$roles.Add($val) }
        "commands" { [void]$commands.Add($val) }
        "local_skills" { [void]$localSkills.Add($val) }
      }
    }
  }
  return @{
    Skills = $skills.ToArray()
    Roles = $roles.ToArray()
    Commands = $commands.ToArray()
    LocalSkills = $localSkills.ToArray()
  }
}

function Load-Team([string]$Id) {
  $dir = Join-Path $CatalogRoot "teams\$Id"
  $yaml = Join-Path $dir "TEAM.yaml"
  if (-not (Test-Path $yaml)) {
    throw "Team '$Id' not found. Expected $yaml"
  }
  $m = Read-TeamManifest $yaml
  if ($m.Skills.Count -gt 0) { $script:SkillNames = $m.Skills }
  if ($m.Roles.Count -gt 0) { $script:RolePaths = $m.Roles }
  if ($m.Commands.Count -gt 0) { $script:CommandNames = $m.Commands }
  $script:TeamId = $Id
  $script:TeamDir = $dir
  $script:LocalSkillNames = $m.LocalSkills
  Write-Host "Team:    $Id"
  Write-Host "Skills:  $($script:SkillNames -join ', ')"
  Write-Host "Roles:   $($script:RolePaths.Count) selected"
}

function Copy-Skills([string]$DestSkillsRoot) {
  # Team mode: replace dest skills entirely so previous full-catalog install does not linger
  if ($script:TeamId -and (Test-Path $DestSkillsRoot)) {
    Remove-Item -Recurse -Force $DestSkillsRoot
  }
  Ensure-Dir $DestSkillsRoot
  $names = $script:SkillNames
  if ($names.Count -eq 0) { $names = @(Get-AllCatalogSkills) }
  foreach ($name in $names) {
    $src = Join-Path $CatalogRoot "skills\$name\SKILL.md"
    if (-not (Test-Path $src)) {
      Write-Warning "Skill missing in catalog: $name"
      continue
    }
    $dst = Join-Path $DestSkillsRoot $name
    Ensure-Dir $dst
    Copy-Item $src (Join-Path $dst "SKILL.md") -Force
  }
  if ($script:TeamDir) {
    foreach ($name in $script:LocalSkillNames) {
      $src = Join-Path $script:TeamDir "skills\$name\SKILL.md"
      if (-not (Test-Path $src)) { Write-Warning "Local team skill missing: $name"; continue }
      $dst = Join-Path $DestSkillsRoot $name
      Ensure-Dir $dst
      Copy-Item $src (Join-Path $dst "SKILL.md") -Force
    }
  }
}

function Copy-Commands([string]$DestCommandsRoot) {
  $srcRoot = Join-Path $CatalogRoot "commands"
  if (-not (Test-Path $srcRoot)) { return }
  Ensure-Dir $DestCommandsRoot
  $names = @($script:CommandNames)
  if ($names -notcontains "new-project") { $names += "new-project" }
  foreach ($name in $names) {
    $file = Join-Path $srcRoot "$name.md"
    if (Test-Path $file) {
      Copy-Item $file (Join-Path $DestCommandsRoot "$name.md") -Force
    }
  }
}

function Copy-Roles([string]$DestRolesRoot) {
  # Team mode: replace dest roles so stale flattened/old copies do not linger
  if ($script:TeamId -and (Test-Path $DestRolesRoot)) {
    Remove-Item -Recurse -Force $DestRolesRoot
  }
  Ensure-Dir $DestRolesRoot
  if ($script:RolePaths.Count -eq 0) {
    Copy-Tree (Join-Path $CatalogRoot "roles") $DestRolesRoot
    return
  }
  foreach ($rel in $script:RolePaths) {
    $src = Join-Path $CatalogRoot "roles\$($rel).md"
    if (-not (Test-Path $src)) {
      Write-Warning "Role missing: $rel"
      continue
    }
    $dstFile = Join-Path $DestRolesRoot "$rel.md"
    Ensure-Dir (Split-Path $dstFile -Parent)
    Copy-Item $src $dstFile -Force
  }
}

function Write-TeamOverlay {
  if (-not $script:TeamId) { return }
  $teamOut = Join-Path $TargetRoot "ai-agents-rogue\active-team"
  Ensure-Dir $teamOut
  Copy-Item (Join-Path $script:TeamDir "TEAM.yaml") (Join-Path $teamOut "TEAM.yaml") -Force
  Copy-Item (Join-Path $script:TeamDir "TEAM.md") (Join-Path $teamOut "TEAM.md") -Force
  $ctx = Join-Path $script:TeamDir "context.md"
  if (Test-Path $ctx) { Copy-Item $ctx (Join-Path $teamOut "context.md") -Force }

  $overlay = @"
# Active Team: $($script:TeamId)

This project is installed for team **$($script:TeamId)**.

1. Read ``ai-agents-rogue/active-team/TEAM.md`` and ``context.md``
2. Use **only** skills listed in ``TEAM.yaml``
3. Use **only** roles listed in ``TEAM.yaml`` (under host ``*/roles`` or catalog)
4. Default build mode: skill ``e2e-delivery`` if included in the team manifest

Global house docs: ``AGENTS.md`` still applies, scoped by the active team.
"@
  Set-Content -Path (Join-Path $TargetRoot "TEAM.md") -Value $overlay -Encoding UTF8

  # Prepend pointer into AGENTS.md copy at root if not present
  $agentsPath = Join-Path $TargetRoot "AGENTS.md"
  if (Test-Path $agentsPath) {
    $content = Get-Content $agentsPath -Raw
    if ($content -notmatch "Active Team:") {
      $banner = @"
> **Active Team:** ``$($script:TeamId)`` - see ``TEAM.md`` and ``ai-agents-rogue/active-team/``.
> Load only skills/roles from that team's ``TEAM.yaml``.

"@
      Set-Content -Path $agentsPath -Value ($banner + $content) -Encoding UTF8
    }
  }
}

function Install-CatalogShared {
  Write-Host "  Catalog shared files..."
  Copy-Item (Join-Path $CatalogRoot "AGENTS.md") (Join-Path $TargetRoot "AGENTS.md") -Force
  foreach ($f in @("LICENSE", "NOTICE", "README.md", "ATTRIBUTION.seal", "ATTRIBUTION.public.xml")) {
    $src = Join-Path $CatalogRoot $f
    if (Test-Path $src) {
      Copy-Item $src (Join-Path $TargetRoot $f) -Force
    }
  }

  $bundle = Join-Path $TargetRoot "ai-agents-rogue"
  $catalogFull = [System.IO.Path]::GetFullPath($CatalogRoot)
  $bundleFull = [System.IO.Path]::GetFullPath($bundle)

  if ($catalogFull -eq $bundleFull) {
    Write-Host "  Target already is the catalog bundle - skip self-copy of full tree."
    Write-TeamOverlay
    return
  }

  Copy-Tree (Join-Path $CatalogRoot "core") (Join-Path $bundle "core")
  Copy-Tree (Join-Path $CatalogRoot "templates") (Join-Path $bundle "templates")
  Copy-Tree (Join-Path $CatalogRoot "rules") (Join-Path $bundle "rules")
  if ($script:RolePaths.Count -eq 0) {
    Copy-Tree (Join-Path $CatalogRoot "roles") (Join-Path $bundle "roles")
  } else {
    Copy-Roles (Join-Path $bundle "roles")
  }
  Ensure-Dir (Join-Path $bundle "skills")
  foreach ($name in $script:SkillNames) {
    $src = Join-Path $CatalogRoot "skills\$name"
    if (Test-Path $src) { Copy-Tree $src (Join-Path $bundle "skills\$name") }
  }
  Copy-Item (Join-Path $CatalogRoot "README.md") (Join-Path $bundle "README.md") -Force
  Copy-Item (Join-Path $CatalogRoot "AGENTS.md") (Join-Path $bundle "AGENTS.md") -Force
  foreach ($f in @("LICENSE", "NOTICE", "ATTRIBUTION.seal", "ATTRIBUTION.public.xml")) {
    $src = Join-Path $CatalogRoot $f
    if (Test-Path $src) { Copy-Item $src (Join-Path $bundle $f) -Force }
  }
  # Keep verify tooling with the catalog copy
  $scriptsDst = Join-Path $bundle "scripts"
  Ensure-Dir $scriptsDst
  foreach ($s in @("verify-attribution.ps1", "verify-official-upstream.ps1", "check-github-entitlement.ps1", "_attribution-crypto.ps1", "stamp-attribution.ps1", "generate-attribution-seal.ps1", "install-mcp.ps1")) {
    $src = Join-Path $CatalogRoot "scripts\$s"
    if (Test-Path $src) { Copy-Item $src (Join-Path $scriptsDst $s) -Force }
  }
  Copy-Item (Join-Path $CatalogRoot "GITHUB_ENTITLEMENT.json") (Join-Path $bundle "GITHUB_ENTITLEMENT.json") -Force -ErrorAction SilentlyContinue
  Write-TeamOverlay
}

function SkillListText {
  $names = $script:SkillNames
  if ($names.Count -eq 0) { return "all catalog skills ($((Get-AllCatalogSkills).Count))" }
  if ($names.Count -gt 8) { return "$($names.Count) skills from TEAM.yaml" }
  return ($names -join ", ")
}

function Copy-Rules([string]$DestRulesRoot) {
  $src = Join-Path $CatalogRoot "rules"
  if (-not (Test-Path $src)) { return }
  Ensure-Dir $DestRulesRoot
  Get-ChildItem $src -Filter "*.md" | ForEach-Object {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $body = Get-Content $_.FullName -Raw -Encoding UTF8
    $mdc = @"
---
description: AI Agents Rogue rule - $base
globs:
alwaysApply: true
---

$body
"@
    Set-Content -Path (Join-Path $DestRulesRoot "aar-$base.mdc") -Value $mdc -Encoding UTF8
  }
}

function Get-CatalogRelFromTarget {
  try {
    $from = $TargetRoot.Path.TrimEnd('\', '/')
    $to = $CatalogRoot.Path.TrimEnd('\', '/')
    $uriFrom = New-Object System.Uri (($from -replace '\\', '/') + '/')
    $uriTo = New-Object System.Uri (($to -replace '\\', '/'))
    $rel = [Uri]::UnescapeDataString($uriFrom.MakeRelativeUri($uriTo).ToString()).Replace('/', '\')
    if ([string]::IsNullOrWhiteSpace($rel)) { return "ai-agents-rogue" }
    return $rel.TrimEnd('\')
  } catch {
    return "ai-agents-rogue"
  }
}

function Install-Cursor {
  Write-Host "Installing Cursor adapter..."
  Copy-Skills (Join-Path $TargetRoot ".cursor\skills")
  Copy-Commands (Join-Path $TargetRoot ".cursor\commands")
  Ensure-Dir (Join-Path $TargetRoot ".cursor\rules")
  Copy-Roles (Join-Path $TargetRoot ".cursor\agents\roles")
  Copy-Rules (Join-Path $TargetRoot ".cursor\rules")
  $catalogRel = (Get-CatalogRelFromTarget) -replace '\\', '/'
  $teamLine = if ($script:TeamId) { "Active team: ``$($script:TeamId)`` (``TEAM.md``). Use only that team's skills/roles." } else { "Full catalog mode." }
  $localBit = if ($script:LocalSkillNames.Count -gt 0) { " Local skills: $($script:LocalSkillNames -join ', ')." } else { "" }
  $rule = @"
---
description: AI Agents Rogue - E2E auto-execute (team-aware)
globs:
alwaysApply: true
---

# AI Agents Rogue

Follow root ``AGENTS.md``. $teamLine$localBit
Default: AI Orchestrator + ``e2e-delivery`` when building.
**Attribution gate:** before any execution, run ``$catalogRel/scripts/verify-attribution.ps1``. If it fails, STOP (do not code). Author: Rogue Development (https://github.com/rogue-dev-studio).
Skills installed: $(SkillListText).
Rules: ``.cursor/rules/aar-*.mdc`` (includes ``aar-author.mdc``).
Work modes: ``e2e`` (default) or ``manual`` — see ``WORKMODE.md`` / ``$catalogRel/WORKMODES.md``.
Commands: ``/start-feature``, ``/assist``, ``/set-mode``, ``/new-project``.
No commit/push/deploy unless asked.
"@
  Set-Content -Path (Join-Path $TargetRoot ".cursor\rules\ai-agents-rogue.mdc") -Value $rule -Encoding UTF8
}

function Install-Antigravity {
  Write-Host "Installing Antigravity adapter..."
  Copy-Skills (Join-Path $TargetRoot ".agents\skills")
  Copy-Commands (Join-Path $TargetRoot ".agents\commands")
  Copy-Roles (Join-Path $TargetRoot ".agents\roles")
}

function Install-Claude {
  Write-Host "Installing Claude Code adapter..."
  Copy-Skills (Join-Path $TargetRoot ".claude\skills")
  Copy-Commands (Join-Path $TargetRoot ".claude\commands")
  Copy-Roles (Join-Path $TargetRoot ".claude\agents\roles")
  $teamBit = if ($script:TeamId) { "Active team: ``$($script:TeamId)``." } else { "" }
  $claudeMd = Join-Path $TargetRoot "CLAUDE.md"
  $pointer = @"

<!-- ai-agents-rogue -->
# AI Agents Rogue
Follow ``AGENTS.md``. $teamBit E2E via ``e2e-delivery`` when building.
Skills: $(SkillListText).
Command: ``/start-feature``.
<!-- /ai-agents-rogue -->
"@
  if (Test-Path $claudeMd) {
    $existing = Get-Content $claudeMd -Raw
    if ($existing -notmatch "ai-agents-rogue") {
      Add-Content -Path $claudeMd -Value $pointer
    } else {
      $updated = [regex]::Replace($existing, '(?s)<!-- ai-agents-rogue -->.*?<!-- /ai-agents-rogue -->', $pointer.Trim())
      Set-Content -Path $claudeMd -Value $updated -Encoding UTF8
    }
  } else {
    Set-Content -Path $claudeMd -Value ($pointer.Trim() + "`n") -Encoding UTF8
  }
}

function Install-OpenCode {
  Write-Host "Installing OpenCode adapter..."
  Copy-Skills (Join-Path $TargetRoot ".opencode\skills")
  Copy-Commands (Join-Path $TargetRoot ".opencode\commands")
  Copy-Roles (Join-Path $TargetRoot ".opencode\agents\roles")
}

function Install-Generic {
  Write-Host "Installing generic .agents adapter..."
  Copy-Skills (Join-Path $TargetRoot ".agents\skills")
  Copy-Commands (Join-Path $TargetRoot ".agents\commands")
  Copy-Roles (Join-Path $TargetRoot ".agents\roles")
}

function Get-AllDomainPackIds {
  Get-ChildItem (Join-Path $CatalogRoot "teams") -Directory |
    Where-Object {
      $_.Name -ne "_template" -and (Test-Path (Join-Path $_.FullName "TEAM.yaml"))
    } |
    ForEach-Object { $_.Name }
}

function Map-InstallHostsToBootstrap([string[]]$InstallHosts) {
  $mapped = New-Object System.Collections.Generic.List[string]
  foreach ($h in $InstallHosts) {
    switch ($h.ToLowerInvariant()) {
      "cursor" { [void]$mapped.Add("cursor") }
      "claude" { [void]$mapped.Add("claude") }
      "opencode" { [void]$mapped.Add("opencode") }
      "generic" { [void]$mapped.Add("agents") }
      "antigravity" { [void]$mapped.Add("agents") }
    }
  }
  if ($mapped.Count -eq 0) { return "all" }
  return (($mapped | Select-Object -Unique) -join ",")
}

function Resolve-DomainPackIds([string[]]$Raw) {
  $ids = New-Object System.Collections.Generic.List[string]
  foreach ($entry in $Raw) {
    if ([string]::IsNullOrWhiteSpace($entry)) { continue }
    foreach ($part in ($entry -split '[,\s]+')) {
      $id = $part.Trim().ToLowerInvariant()
      if (-not $id) { continue }
      switch ($id) {
        "all" {
          foreach ($pack in (Get-AllDomainPackIds)) { [void]$ids.Add($pack) }
        }
        "none" {
          return @()
        }
        default {
          [void]$ids.Add($id)
        }
      }
    }
  }
  return ($ids | Select-Object -Unique)
}

function Sync-DomainPacks([string[]]$DomainIds, [string[]]$InstallHosts) {
  if ($DomainIds.Count -eq 0) { return }
  $bootstrap = Join-Path $PSScriptRoot "bootstrap-domain.ps1"
  if (-not (Test-Path -LiteralPath $bootstrap)) {
    Write-Warning "bootstrap-domain.ps1 missing; skip domain packs"
    return
  }
  $hostArg = Map-InstallHostsToBootstrap $InstallHosts
  Write-Host "Domain packs: $($DomainIds -join ', ')"
  foreach ($id in $DomainIds) {
    Write-Host "Sync domain pack: $id"
    & $bootstrap -Domain $id -Target $TargetRoot.Path -SkillHosts $hostArg -Force
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
  }
}

if ($Team) { Load-Team $Team }

$requested = $Hosts.ToLowerInvariant().Split(",") | ForEach-Object { $_.Trim() } | Where-Object { $_ }
if ($requested -contains "all") {
  $requested = @("cursor", "antigravity", "claude", "opencode", "generic")
}

$domainPackIds = @()
if (-not $Team) {
  if ($IncludeDomains.Count -eq 0) {
    $IncludeDomains = @("hr")
  }
  $domainPackIds = @(Resolve-DomainPackIds $IncludeDomains)
}

Write-Host "Catalog: $CatalogRoot"
Write-Host "Target:  $TargetRoot"
Write-Host "Hosts:   $($requested -join ', ')"
if (-not $Team) {
  if ($domainPackIds.Count -gt 0) {
    Write-Host "Domains: $($domainPackIds -join ', ') (full catalog + local packs)"
  } else {
    Write-Host "Domains: none"
  }
}

function Ensure-WorkModeFile {
  $wm = Join-Path $TargetRoot "WORKMODE.md"
  if (Test-Path -LiteralPath $wm) { return }
  $tpl = Join-Path $CatalogRoot "templates\WORKMODE.md"
  if (Test-Path -LiteralPath $tpl) {
    Copy-Item -LiteralPath $tpl -Destination $wm -Force
    Write-Host "Created WORKMODE.md (default: e2e)"
  }
}

Install-CatalogShared
Ensure-WorkModeFile

foreach ($h in $requested) {
  switch ($h) {
    "cursor" { Install-Cursor }
    "antigravity" { Install-Antigravity }
    "claude" { Install-Claude }
    "opencode" { Install-OpenCode }
    "generic" { Install-Generic }
    default { Write-Warning "Unknown host '$h' - skip" }
  }
}

Sync-DomainPacks $domainPackIds $requested

$mcpParts = @()
foreach ($s in @($Mcp)) {
  if ($null -eq $s) { continue }
  $mcpParts += @("$s".Split(",") | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}
if ($mcpParts.Count -gt 0 -and -not ($mcpParts.Count -eq 1 -and $mcpParts[0].ToLowerInvariant() -eq "none")) {
  $mcpScript = Join-Path $PSScriptRoot "install-mcp.ps1"
  if (-not (Test-Path -LiteralPath $mcpScript)) {
    Write-Warning "install-mcp.ps1 missing; skip MCP"
  } else {
    $mcpHosts = ($requested -join ",")
    & $mcpScript -Target $TargetRoot.Path -Mcp $mcpParts -Hosts $mcpHosts -CatalogRoot $CatalogRoot.Path -SkipGates
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
  }
}

Write-Host "Done."
