# Copy-CopilotSkill.ps1
# Helper script to copy a single skill to Copilot's skills directory

param(
    [string]$SkillName,
    [string]$CatalogRoot = "",
    [string]$TargetRoot = "."
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
    $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
    $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}

$TargetRoot = (Resolve-Path $TargetRoot).Path

function Ensure-Dir([string]$Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Copy skill to Copilot
$src = Join-Path $CatalogRoot "skills\$SkillName"
if (-not (Test-Path (Join-Path $src "SKILL.md"))) {
    Write-Error "Skill not found: $SkillName"
    exit 1
}

$dst = Join-Path $TargetRoot ".github\skills\$SkillName"
Ensure-Dir $dst
Copy-Item -Path (Join-Path $src "*") -Destination $dst -Recurse -Force

Write-Host "Copied skill '$SkillName' to Copilot"
