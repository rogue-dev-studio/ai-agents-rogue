<#
.SYNOPSIS
  Scaffold a new project under project/{id}/ with development docs tree.
.PARAMETER Id
  Folder id, e.g. my-app (lowercase, hyphens).
.PARAMETER Name
  Display name.
.PARAMETER Team
  Optional team id (only if teams/<id>/ exists).
.PARAMETER Target
  Repo root containing project/ (default: parent of ai-agents-rogue, or .).
.PARAMETER Activate
  Write root PROJECT.md as active project (default: true).
#>
param(
  [Parameter(Mandatory = $true)][string]$Id,
  [string]$Name = "",
  [string]$Team = "",
  [string]$Target = "",
  [bool]$Activate = $true
)

$ErrorActionPreference = "Stop"

if ($Id -notmatch '^[a-z0-9]+([a-z0-9-]*[a-z0-9])?$') {
  throw "Id must be lowercase alphanumeric with hyphens (e.g. my-app)."
}

$CatalogRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
if (-not $Target) {
  $parent = Split-Path $CatalogRoot -Parent
  if (Test-Path (Join-Path $parent "project")) {
    $Target = $parent
  } else {
    $Target = (Get-Location).Path
  }
}
$TargetRoot = Resolve-Path $Target
$Template = Join-Path $CatalogRoot "project-template"
$ProjectDir = Join-Path $TargetRoot "project\$Id"

if (Test-Path $ProjectDir) {
  throw "Project already exists: $ProjectDir"
}
if (-not $Name) { $Name = $Id }
$Date = Get-Date -Format "yyyy-MM-dd"
if (-not $Team) { $Team = "none" }

New-Item -ItemType Directory -Path $ProjectDir -Force | Out-Null
Copy-Item -Path (Join-Path $Template "*") -Destination $ProjectDir -Recurse -Force

function Replace-Tokens([string]$Path) {
  $text = Get-Content $Path -Raw -Encoding UTF8
  $text = $text.Replace("__PROJECT_ID__", $Id)
  $text = $text.Replace("__PROJECT_NAME__", $Name)
  $text = $text.Replace("__TEAM_ID__", $Team)
  $text = $text.Replace("__DATE__", $Date)
  Set-Content -Path $Path -Value $text -Encoding UTF8
}

Replace-Tokens (Join-Path $ProjectDir "PROJECT.yaml")
Replace-Tokens (Join-Path $ProjectDir "README.md")
$artReadme = Join-Path $ProjectDir "artifacts\README.md"
if (Test-Path -LiteralPath $artReadme) { Replace-Tokens $artReadme }

# Seed starter docs from house templates
$tpl = Join-Path $CatalogRoot "templates"
if (Test-Path (Join-Path $tpl "srs-template.md")) {
  Copy-Item (Join-Path $tpl "srs-template.md") (Join-Path $ProjectDir "docs\srs\_template.md") -Force
}
if (Test-Path (Join-Path $tpl "planning-template.md")) {
  Copy-Item (Join-Path $tpl "planning-template.md") (Join-Path $ProjectDir "docs\planning\_template.md") -Force
}
if (Test-Path (Join-Path $tpl "task-template.md")) {
  Copy-Item (Join-Path $tpl "task-template.md") (Join-Path $ProjectDir "docs\tasks\_template.md") -Force
}

if ($Activate) {
  $active = @"
# Active Project: $Id

- Path: ``project/$Id/``
- Name: $Name
- Team: $Team
- Docs: ``project/$Id/docs/``

AI harus menulis dokumentasi pengembangan ke folder docs project ini.
E2E: skill ``e2e-delivery`` + ``AGENTS.md`` + team (jika ada).
"@
  Set-Content -Path (Join-Path $TargetRoot "PROJECT.md") -Value $active -Encoding UTF8
}

Write-Host "Created: $ProjectDir"
if ($Activate) { Write-Host "Active:  $TargetRoot\PROJECT.md" }
Write-Host "Next: install team if needed, then /start-feature"
if ($Team -and $Team -ne "none") {
  Write-Host "  .\ai-agents-rogue\scripts\install.ps1 -Target `"$TargetRoot`" -Hosts all -Team $Team"
}
