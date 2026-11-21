# auto-populate-ignore-revs.ps1
# Auto-populate .git/info/assume-unchanged with AI-generated files

param(
    [string]$Target = ".",
    [string]$CatalogRoot = ""
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
    $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
    $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}

$TargetRoot = (Resolve-Path $Target).Path

# Ensure .git directory exists
$gitDir = Join-Path $TargetRoot ".git"
if (-not (Test-Path $gitDir)) {
    Write-Host "No .git directory found. Skipping."
    exit 0
}

# Ensure info directory exists
$infoDir = Join-Path $gitDir "info"
if (-not (Test-Path $infoDir)) {
    New-Item -ItemType Directory -Path $infoDir -Force | Out-Null
}

# List of AI-generated directories to ignore
$aiDirs = @(
    ".cursor"
    ".claude"
    ".opencode"
    ".copilot"
    ".agents"
)

# Build ignore list
$ignoreList = @()
foreach ($dir in $aiDirs) {
    $fullPath = Join-Path $TargetRoot $dir
    if (Test-Path $fullPath) {
        $ignoreList += Get-ChildItem -Path $fullPath -Recurse -File -Force |
            ForEach-Object { $_.FullName.Replace($TargetRoot, '').TrimStart('\', '/') }
    }
}

# Write ignore list
$ignoreRevsPath = Join-Path $infoDir "assume-unchanged"
Set-Content -Path $ignoreRevsPath -Value ($ignoreList -join "`n") -Encoding UTF8

Write-Host "Auto-populated assume-unchanged with $($ignoreList.Count) AI-generated files"
