# setup-hide-ai-authors.ps1
# Setup script to configure AI author hiding in Copilot

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

# Copy hide-ai-authors files
$samplesSrc = Join-Path $CatalogRoot "samples\hide-ai-authors"
if (Test-Path $samplesSrc) {
    $samplesDst = Join-Path $TargetRoot "samples\hide-ai-authors"
    Ensure-Dir $samplesDst
    Copy-Item -Path (Join-Path $samplesSrc "*") -Destination $samplesDst -Recurse -Force
}

Write-Host "AI author hiding setup complete."
Write-Host "  Files: samples\hide-ai-authors\"
