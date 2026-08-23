<#
.SYNOPSIS
  Organize a personal folder by file type; coding projects move as whole folders.
.EXAMPLE
  .\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Downloads" -Mode by-type
  .\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Downloads" -Mode by-type -Apply
#>
param(
  [Parameter(Mandatory = $true)]
  [string]$Path,
  [ValidateSet('by-type', 'by-extension', 'by-face')]
  [string]$Mode = 'by-type',
  [switch]$Recurse,
  [switch]$Apply
)

$ErrorActionPreference = "Stop"

if ($Mode -eq 'by-face') {
  $py = Join-Path $PSScriptRoot 'organize-by-face.py'
  if (-not (Test-Path -LiteralPath $py)) { throw "Missing: $py" }
  $argv = @($py, '--path', $Path)
  if ($Recurse) { $argv += '--recurse' }
  if ($Apply) { $argv += '--apply' }
  $python = Get-Command python -ErrorAction SilentlyContinue
  if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }
  if (-not $python) { throw "Python not found. Install Python 3 and re-run." }
  & $python.Source @argv
  exit $LASTEXITCODE
}

function Test-ForbiddenPath([string]$p) {
  $full = [System.IO.Path]::GetFullPath($p)
  $norm = $full.TrimEnd('\', '/')
  if ($norm -match '^[A-Za-z]:$') { return $true }
  if ($norm -match '(?i)^[A-Za-z]:\\Windows($|\\)') { return $true }
  if ($norm -match '(?i)^[A-Za-z]:\\Program Files( \(x86\))?($|\\)') { return $true }
  return $false
}

function Get-TypeCategory([string]$Name) {
  $ext = [System.IO.Path]::GetExtension($Name).ToLowerInvariant()
  switch -Regex ($ext) {
    '^\.(png|jpe?g|webp|gif|bmp|tiff?|heic|svg|ico)$' { return 'Images' }
    '^\.(mp4|mkv|mov|webm|avi|wmv|m4v)$' { return 'Videos' }
    '^\.(mp3|wav|flac|aac|m4a|ogg|wma)$' { return 'Audio' }
    '^\.(pdf|docx?|xlsx?|pptx?|txt|rtf|odt|csv|md)$' { return 'Documents' }
    '^\.(zip|rar|7z|tar|gz|bz2)$' { return 'Archives' }
    '^\.(iso|img)$' { return 'Installers' }
    '^\.(exe|msi|msix|dmg|apk)$' { return 'Installers' }
    '^\.(js|jsx|ts|tsx|py|java|cs|go|rs|php|html|css|json|xml|ya?ml)$' { return 'Code' }
    default { return 'Other' }
  }
}

function Get-CodingProjectKind([string]$DirPath) {
  $has = {
    param($name)
    Test-Path -LiteralPath (Join-Path $DirPath $name)
  }
  if ((& $has 'artisan') -and (& $has 'composer.json')) { return 'Laravel' }
  if ((& $has 'manage.py') -and ((& $has 'settings.py') -or (Get-ChildItem -LiteralPath $DirPath -Filter 'settings.py' -Recurse -Depth 2 -File -ErrorAction SilentlyContinue | Select-Object -First 1))) { return 'Django' }
  if ((& $has 'composer.json') -and -not (& $has 'artisan')) { return 'PHP' }
  if ((& $has 'package.json') -and ((& $has 'next.config.js') -or (& $has 'next.config.mjs') -or (& $has 'next.config.ts'))) { return 'NextJS' }
  if ((& $has 'package.json') -and ((& $has 'angular.json'))) { return 'Angular' }
  if ((& $has 'package.json') -and ((& $has 'vue.config.js') -or (& $has 'nuxt.config.js') -or (& $has 'nuxt.config.ts'))) { return 'Vue' }
  if (& $has 'package.json') { return 'Node' }
  if (& $has 'go.mod') { return 'Go' }
  if (& $has 'Cargo.toml') { return 'Rust' }
  if (& $has 'pyproject.toml') { return 'Python' }
  if ((& $has 'requirements.txt') -and ((& $has 'setup.py') -or (& $has 'main.py') -or (& $has 'app.py'))) { return 'Python' }
  $sln = Get-ChildItem -LiteralPath $DirPath -Filter '*.sln' -File -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($sln) { return 'DotNet' }
  $csproj = Get-ChildItem -LiteralPath $DirPath -Filter '*.csproj' -File -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($csproj) { return 'DotNet' }
  if ((& $has 'pom.xml') -or (& $has 'build.gradle') -or (& $has 'build.gradle.kts')) { return 'JVM' }
  if ((& $has 'Gemfile') -and (& $has 'config') -and (Test-Path -LiteralPath (Join-Path $DirPath 'config\application.rb'))) { return 'Rails' }
  if ((& $has '.git') -and ((& $has 'src') -or (& $has 'lib') -or (& $has 'app'))) { return 'GitProject' }
  return $null
}

function Get-UniquePath([string]$DesiredPath) {
  if (-not (Test-Path -LiteralPath $DesiredPath)) { return $DesiredPath }
  $parent = Split-Path -Parent $DesiredPath
  $name = Split-Path -Leaf $DesiredPath
  $base = $name
  $ext = ''
  if (Test-Path -LiteralPath $DesiredPath -PathType Leaf) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($name)
    $ext = [System.IO.Path]::GetExtension($name)
  }
  $i = 1
  while ($true) {
    $candidate = Join-Path $parent ("{0}_{1}{2}" -f $base, $i, $ext)
    if (-not (Test-Path -LiteralPath $candidate)) { return $candidate }
    $i++
  }
}

function Test-UnderAny([string]$FullPath, [string[]]$Roots) {
  $full = [System.IO.Path]::GetFullPath($FullPath)
  foreach ($r in $Roots) {
    $rr = [System.IO.Path]::GetFullPath($r).TrimEnd('\', '/')
    if ($full.Equals($rr, [StringComparison]::OrdinalIgnoreCase)) { return $true }
    if ($full.StartsWith($rr + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { return $true }
  }
  return $false
}

if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
  throw "Folder not found: $Path"
}
if (Test-ForbiddenPath $Path) {
  throw "Refusing to organize system/forbidden path: $Path"
}

$bucketNames = @('Images', 'Videos', 'Audio', 'Documents', 'Archives', 'Installers', 'Code', 'Other', 'Projects')
$proposals = New-Object System.Collections.Generic.List[object]
$projectRoots = New-Object System.Collections.Generic.List[string]

# 1) Immediate child folders that are coding projects → move whole folder
$childDirs = Get-ChildItem -LiteralPath $Path -Directory -ErrorAction SilentlyContinue
foreach ($d in $childDirs) {
  if ($bucketNames -contains $d.Name) { continue }
  if ($d.FullName -match '(?i)\\Projects\\') { continue }
  $kind = Get-CodingProjectKind $d.FullName
  if (-not $kind) { continue }
  $destDir = Join-Path $Path (Join-Path 'Projects' $kind)
  $dest = Get-UniquePath (Join-Path $destDir $d.Name)
  # already under Projects/<kind>/
  $expectedParent = Join-Path (Join-Path $Path 'Projects') $kind
  if ($d.Parent.FullName -eq $expectedParent) { continue }
  $projectRoots.Add($d.FullName) | Out-Null
  $proposals.Add([pscustomobject]@{
      Kind     = 'project'
      From     = $d.FullName
      To       = $dest
      Category = "Projects/$kind"
    })
}

# 2) Loose files — never from inside a detected project
function Get-CandidateFiles {
  if ($Recurse) {
    return Get-ChildItem -LiteralPath $Path -File -Recurse | Where-Object {
      $parentName = Split-Path -Leaf $_.DirectoryName
      if ($bucketNames -contains $parentName) { return $false }
      if (Test-UnderAny $_.FullName $projectRoots.ToArray()) { return $false }
      # skip anything already under Projects/
      if ($_.DirectoryName -match '(?i)[\\/]Projects([\\/]|$)') { return $false }
      # if file lives inside some coding project deeper than immediate child, skip
      $walk = $_.Directory
      while ($walk -and ($walk.FullName.Length -ge $Path.Length)) {
        if ((Get-CodingProjectKind $walk.FullName)) { return $false }
        if ($walk.FullName -eq [IO.Path]::GetFullPath($Path)) { break }
        $walk = $walk.Parent
      }
      return $true
    }
  }
  return Get-ChildItem -LiteralPath $Path -File
}

$files = @(Get-CandidateFiles)
foreach ($f in $files) {
  if (Test-UnderAny $f.FullName $projectRoots.ToArray()) { continue }
  $folderName = if ($Mode -eq 'by-extension') {
    $e = [System.IO.Path]::GetExtension($f.Name).TrimStart('.').ToLowerInvariant()
    if ([string]::IsNullOrWhiteSpace($e)) { 'Other' } else { $e }
  } else {
    Get-TypeCategory $f.Name
  }
  $destDir = Join-Path $Path $folderName
  if ($f.DirectoryName -eq $destDir) { continue }
  $dest = Get-UniquePath (Join-Path $destDir $f.Name)
  $proposals.Add([pscustomobject]@{
      Kind     = 'file'
      From     = $f.FullName
      To       = $dest
      Category = $folderName
    })
}

if ($proposals.Count -eq 0) {
  Write-Host "Nothing to move under: $Path (mode=$Mode)"
  return
}

$projCount = @($proposals | Where-Object { $_.Kind -eq 'project' }).Count
$fileCount = @($proposals | Where-Object { $_.Kind -eq 'file' }).Count
Write-Host ("Plan under {0} [mode={1}]: {2} project folder(s), {3} loose file(s)" -f $Path, $Mode, $projCount, $fileCount)
Write-Host "Note: coding projects move as a whole — contents are NOT re-categorized."
$proposals | Group-Object Category | Sort-Object Name | ForEach-Object {
  Write-Host ("  {0}: {1}" -f $_.Name, $_.Count)
}
Write-Host ""
$proposals | Select-Object -First 40 | ForEach-Object {
  $tag = if ($_.Kind -eq 'project') { '[project]' } else { '[file]' }
  Write-Host ("  {0} {1}" -f $tag, $_.From)
  Write-Host ("       -> {0}" -f $_.To)
}
if ($proposals.Count -gt 40) {
  Write-Host ("  ... and {0} more" -f ($proposals.Count - 40))
}

if (-not $Apply) {
  Write-Host ""
  Write-Host "Dry-run only. Re-run with -Apply after review."
  return
}

foreach ($p in $proposals) {
  $dir = Split-Path -Parent $p.To
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  Move-Item -LiteralPath $p.From -Destination $p.To
}
Write-Host ("Done. Moved {0} item(s) ({1} projects, {2} files)." -f $proposals.Count, $projCount, $fileCount)
