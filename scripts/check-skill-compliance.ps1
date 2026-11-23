<#
.SYNOPSIS
  Validates SKILL.md files for mandatory attribution and structure.
#>
param(
  [string]$CatalogRoot = ".."
)

$ErrorActionPreference = "Stop"
$CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot $CatalogRoot)).Path
$skillFiles = Get-ChildItem -Path (Join-Path $CatalogRoot "skills") -Recurse -Filter "SKILL.md" -File

$failed = $false
foreach ($sf in $skillFiles) {
  $content = [System.IO.File]::ReadAllText($sf.FullName)
  if ($content -notmatch "## Attribution") {
    Write-Host "Missing Attribution section: $($sf.FullName)" -ForegroundColor Red
    $failed = $true
  }
  if ($content -notmatch "DO-NOT-REMOVE") {
    Write-Host "Missing DO-NOT-REMOVE marker: $($sf.FullName)" -ForegroundColor Red
    $failed = $true
  }
}

if ($failed) { exit 1 }
Write-Host "All SKILL.md files are compliant."
exit 0
