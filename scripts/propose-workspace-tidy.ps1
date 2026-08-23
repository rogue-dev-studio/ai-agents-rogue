<#
.SYNOPSIS
  Propose moves to tidy loose files into project/{id}/docs|artifacts categories (dry-run).
#>
param(
  [Parameter(Mandatory = $true)]
  [string]$ProjectId,
  [string]$WorkspaceRoot = "",
  [switch]$Apply
)

$ErrorActionPreference = "Stop"
if (-not $WorkspaceRoot) {
  $WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
}
$projectRoot = Join-Path $WorkspaceRoot "project\$ProjectId"
if (-not (Test-Path -LiteralPath $projectRoot)) {
  throw "Project folder not found: $projectRoot"
}

$skipDirNames = @(
  '.git', 'node_modules', 'vendor', 'dist', 'build', '.next', '__pycache__',
  'ai-agents-rogue', '.cursor', '.claude', '.agents', 'runtime'
)

function Test-SkippedPath([string]$FullPath) {
  $rel = $FullPath.Substring($WorkspaceRoot.Length).TrimStart('\', '/')
  foreach ($n in $skipDirNames) {
    if ($rel -eq $n -or $rel.StartsWith("$n\") -or $rel.StartsWith("$n/")) { return $true }
  }
  if ($rel -match '(^|[\\/])\.env($|\.)') { return $true }
  if ($rel -match 'ATTRIBUTION|\.attribution-private|LICENSE$|NOTICE$') { return $true }
  return $false
}

function Get-ArtifactCategory([string]$Name) {
  $ext = [System.IO.Path]::GetExtension($Name).ToLowerInvariant()
  switch -Regex ($ext) {
    '^\.(png|jpe?g|webp|gif|bmp|tiff?)$' { return 'images' }
    '^\.(blend|glb|gltf|fbx|obj|stl)$' { return '3d' }
    '^\.(svg|ai|fig|sketch)$' { return 'design' }
    '^\.(mp4|webm|mov|mkv|mp3|wav|aac|flac)$' { return 'media' }
    '^\.(csv|tsv|xlsx?|parquet)$' { return 'data' }
    '^\.(js|jsx|ts|tsx|py|php|go|rs|java|cs|rb)$' { return 'code' }
    '^\.(md|txt)$' { return 'docs-candidate' }
    default { return 'other' }
  }
}

$proposals = New-Object System.Collections.Generic.List[object]
$scanRoots = @(
  $WorkspaceRoot,
  $projectRoot
)

foreach ($root in $scanRoots) {
  Get-ChildItem -LiteralPath $root -File -ErrorAction SilentlyContinue | ForEach-Object {
    if (Test-SkippedPath $_.FullName) { return }
    $cat = Get-ArtifactCategory $_.Name
    $dest = $null
    if ($cat -eq 'docs-candidate') {
      if ($root -eq $WorkspaceRoot -and $_.Name -notin @('README.md', 'AGENTS.md', 'PROJECT.md', 'WORKMODE.md', 'CLAUDE.md', 'LICENSE', 'NOTICE')) {
        $dest = Join-Path $projectRoot "docs\qa\$($_.Name)"
      }
    } elseif ($root -eq $WorkspaceRoot -or ($_.DirectoryName -eq $projectRoot)) {
      $dest = Join-Path $projectRoot "artifacts\$cat\$($_.Name)"
    }
    if ($dest) {
      $proposals.Add([pscustomobject]@{
          From = $_.FullName
          To   = $dest
          Category = $cat
        })
    }
  }
}

if ($proposals.Count -eq 0) {
  Write-Host "No loose-file proposals for project '$ProjectId'."
  return
}

Write-Host "Proposed moves ($($proposals.Count)) for project/$ProjectId :"
$proposals | ForEach-Object {
  Write-Host ("  [{0}] {1}" -f $_.Category, $_.From)
  Write-Host ("       -> {0}" -f $_.To)
}

if (-not $Apply) {
  Write-Host ""
  Write-Host "Dry-run only. Re-run with -Apply to execute moves (after review)."
  return
}

foreach ($p in $proposals) {
  $dir = Split-Path -Parent $p.To
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  if (Test-Path -LiteralPath $p.To) {
    Write-Warning "Skip (target exists): $($p.To)"
    continue
  }
  Move-Item -LiteralPath $p.From -Destination $p.To
  Write-Host "Moved: $($p.From) -> $($p.To)"
}
