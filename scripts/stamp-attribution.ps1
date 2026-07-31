<#
.SYNOPSIS
  Ensure every SKILL.md has the required Attribution block (idempotent).
#>
$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..")

# Use single-quoted here-string so backticks are literal
$block = @'

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
'@

$marker = "ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE"
$files = @()
$files += Get-ChildItem (Join-Path $root "skills") -Recurse -Filter SKILL.md -File
$teams = Join-Path $root "teams"
if (Test-Path $teams) {
  $files += Get-ChildItem $teams -Recurse -Filter SKILL.md -File
}

$updated = 0
foreach ($f in $files) {
  $text = [System.IO.File]::ReadAllText($f.FullName)
  # Strip any existing Attribution section at end (with or without marker)
  $text = [regex]::Replace($text, '(?ms)\r?\n## Attribution\r?\n.*\z', '').TrimEnd()
  $new = $text + "`r`n" + $block.TrimStart("`r", "`n") + "`r`n"
  [System.IO.File]::WriteAllText($f.FullName, $new)
  $updated++
}

Write-Host "Attribution stamp refreshed on $updated skills"
