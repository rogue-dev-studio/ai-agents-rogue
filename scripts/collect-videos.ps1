<#
.SYNOPSIS
  Collect videos on a drive into one folder, preserving source subfolder category.
.EXAMPLE
  .\collect-videos.ps1 -SourcePaths 'D:\' -ExcludeRoots 'D:\ZonaKreatif\explore','D:\Anis'
  .\collect-videos.ps1 -SourcePaths 'D:\BrankasDigital','D:\Download' -Destination 'D:\Videos' -Apply
#>
param(
  [Parameter(Mandatory = $true)]
  [string[]]$SourcePaths,
  [string]$Destination = 'D:\Videos',
  [string[]]$ExcludeRoots = @(
    'D:\ZonaKreatif\explore', 'D:\Anis', 'D:\Videos',
    'D:\Windows', 'D:\Program Files', 'D:\Program Files (x86)', 'D:\ProgramData',
    'D:\Installers', 'D:\UnityProjects', 'D:\$RECYCLE.BIN', 'D:\System Volume Information'
  ),
  [switch]$Apply
)

$ErrorActionPreference = 'Stop'
$videoExt = @('.mp4', '.mkv', '.mov', '.webm', '.avi', '.wmv', '.m4v', '.flv', '.mpeg', '.mpg', '.3gp')
$skipLeafNames = @('Assets', 'ProjectSettings', 'Library', 'Temp', 'node_modules', 'vendor', '.git')

function Test-Excluded([string]$path) {
  $full = [IO.Path]::GetFullPath($path)
  foreach ($root in $ExcludeRoots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    $r = [IO.Path]::GetFullPath($root).TrimEnd('\')
    if ($full -eq $r -or $full.StartsWith($r + '\', [StringComparison]::OrdinalIgnoreCase)) { return $true }
  }
  if ($full -match '(?i)\\node_modules\\|\\vendor\\|\\\.git\\|\\Library\\|\\Temp\\') { return $true }
  return $false
}

function Test-UnityProjectAncestor([string]$filePath) {
  $dir = Split-Path $filePath -Parent
  while ($dir -and $dir -match '^[A-Za-z]:\\') {
    if ((Test-Path (Join-Path $dir 'Assets')) -and (Test-Path (Join-Path $dir 'ProjectSettings'))) { return $true }
    $parent = Split-Path $dir -Parent
    if ($parent -eq $dir) { break }
    $dir = $parent
  }
  return $false
}

function Get-UniquePath([string]$desired) {
  if (-not (Test-Path -LiteralPath $desired)) { return $desired }
  $parent = Split-Path -Parent $desired
  $base = [IO.Path]::GetFileNameWithoutExtension($desired)
  $ext = [IO.Path]::GetExtension($desired)
  $i = 1
  while ($true) {
    $candidate = Join-Path $parent ("{0}_{1}{2}" -f $base, $i, $ext)
    if (-not (Test-Path -LiteralPath $candidate)) { return $candidate }
    $i++
  }
}

function Get-SourceCategory([string]$filePath) {
  $dir = Split-Path $filePath -Parent
  $leaf = Split-Path $dir -Leaf
  if ($skipLeafNames -contains $leaf) {
    $dir = Split-Path $dir -Parent
    $leaf = Split-Path $dir -Leaf
  }
  if ([string]::IsNullOrWhiteSpace($leaf) -or $leaf -match '^[A-Za-z]:$') { return 'Other' }
  $leaf = $leaf -replace '[\\/:*?"<>|]', '-'
  return $leaf
}

function Get-HeuristicCategory([string]$fileName) {
  if ($fileName -match '(?i)^Screen Recording|^Recording 20') { return 'Screen Recordings' }
  if ($fileName -match '^VID_') { return 'Camera' }
  if ($fileName -match '(?i)blender|sculpting') { return 'Blender' }
  if ($fileName -match '(?i)instagram') { return 'Instagram' }
  if ($fileName -match '(?i)backsound') { return 'Backsound' }
  if ($fileName -match '^\d{4}-\d{2}-\d{2}') { return 'RIGJ Videos' }
  if ($fileName -match '(?i)pembahasan') { return 'Video Pembahasan' }
  if ($fileName -match '(?i)YouTube\.(mkv|mp4|webm)$| - YouTube\.') { return 'VIDEO' }
  if ($fileName -match '(?i)^\d+_\d+\.(mp4|webm|mkv)$') { return 'Telegram Video' }
  if ($fileName -match '(?i)^\d+_\d+\.(mp4|webm)$') { return 'Telegram Video' }
  if ($fileName -match '(?i)^[a-f0-9]{16,}\.(mp4|webm)$') { return 'Telegram Video' }
  if ($fileName -match '(?i)^1080_30_|^1440_30_') { return 'Telegram Video' }
  if ($fileName -match '(?i)NCS|Gaming Music|Artistic Music|Amazing Mix') { return 'VIDEO' }
  return $null
}

$plans = New-Object System.Collections.Generic.List[object]

foreach ($source in $SourcePaths) {
  if (-not (Test-Path -LiteralPath $source)) { continue }
  $files = if (Test-Path -LiteralPath $source -PathType Leaf) { @((Get-Item -LiteralPath $source)) }
  else { Get-ChildItem -LiteralPath $source -File -Recurse -ErrorAction SilentlyContinue }
  foreach ($file in $files) {
    if ($file.Extension.ToLowerInvariant() -notin $videoExt) { continue }
    if ($file.Length -lt 100KB) { continue }
    if (Test-Excluded $file.FullName) { continue }
    if (Test-UnityProjectAncestor $file.FullName) { continue }
    $category = Get-SourceCategory $file.FullName
    if ($category -eq 'Other') {
      $hint = Get-HeuristicCategory $file.Name
      if ($hint) { $category = $hint }
    }
    $destDir = Join-Path $Destination $category
    $plans.Add([pscustomobject]@{
        From     = $file.FullName
        To       = Get-UniquePath (Join-Path $destDir $file.Name)
        Category = $category
        Size     = $file.Length
      }) | Out-Null
  }
}

Write-Host ("Plan -> {0}" -f $Destination)
$plans | Group-Object Category | Sort-Object Name | ForEach-Object {
  Write-Host ("  {0}: {1}" -f $_.Name, $_.Count)
}
Write-Host ("  total: {0} GB" -f [math]::Round(($plans | Measure-Object Size -Sum).Sum / 1GB, 2))

if (-not $Apply) {
  Write-Host 'Dry-run only. Re-run with -Apply.'
  return
}

foreach ($p in $plans) {
  $dir = Split-Path -Parent $p.To
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  if ($p.From -ne $p.To) {
    Move-Item -LiteralPath $p.From -Destination $p.To
  }
}
Write-Host ("Done. Organized {0} video(s)." -f $plans.Count)
