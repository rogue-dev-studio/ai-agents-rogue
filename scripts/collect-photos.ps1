<#
.SYNOPSIS
  Collect photos into one folder, preserving source subfolder category.
.DESCRIPTION
  Skips Installers, Anis, explore, Unity projects, coding projects, and project assets
  (Unity Assets/, Downloads/Compressed, addon/mockup/template UI, textures/icons/demo folders).
  Corrupt .jpg.rigj (no JPEG EOI) go to Photos/<kategori>/_rusak/.
.EXAMPLE
  .\collect-photos.ps1 -SourcePaths 'D:\' -Apply
#>
param(
  [Parameter(Mandatory = $true)]
  [string[]]$SourcePaths,
  [string]$Destination = 'D:\Photos',
  [string[]]$ExcludeRoots = @(
    'D:\ZonaKreatif\explore', 'D:\Anis', 'D:\Photos',
    'D:\Windows', 'D:\Program Files', 'D:\Program Files (x86)', 'D:\ProgramData',
    'D:\Installers', 'D:\UnityProjects', 'D:\Videos',
    'D:\ai-software-house', 'D:\ai-software-house-old', 'D:\simrs', 'D:\Unity',
    'D:\Workspace', 'D:\dev-prambanan2', 'D:\website-outline', 'D:\Openclaw',
    'D:\Docker', 'D:\Gemini CLI', 'D:\.pnpm-store', 'D:\.Trash-1000',
    'D:\$RECYCLE.BIN', 'D:\System Volume Information'
  ),
  [switch]$Apply
)

$ErrorActionPreference = 'Continue'
$photoExt = @('.jpg', '.jpeg', '.png', '.webp', '.gif', '.bmp', '.tif', '.tiff', '.heic', '.raw', '.cr2', '.nef', '.arw', '.dng')
$photoRigjPattern = '(?i)\.(jpe?g|png|webp|gif|bmp|tif|tiff|heic)\.rigj$'
$codingFileMarkers = @(
  'package.json', 'composer.json', 'artisan', 'go.mod', 'Cargo.toml',
  'pyproject.toml', 'manage.py', 'pom.xml', 'build.gradle', 'build.gradle.kts',
  'Gemfile', 'angular.json'
)
$projectAssetPathPattern = '(?i)(\\Assets\\|\\Downnloads\\Compressed\\|\\Download\\Compressed\\|\\Downloads\\Compressed\\|\\node_modules\\|\\vendor\\|\\\.git\\|\\Library\\|\\ProjectSettings\\|\\Packages\\|\\Prefabs?\\|\\Materials?\\|\\Sprites?\\|\\Shaders?\\|\\user_guide\\|\\static\\|\\dist\\|\\build\\|\\public\\(assets|images|img|static)\\|\\resources\\(assets|images|img)\\|\\src\\assets\\|\\(addon|addons|extension|extensions|mockup|mockups|template-previews|templates?)\\)'
$projectAssetNamePattern = '(?i)^(av\d+|demo-image|corona\d+|icon-cloud|spinner|folder|error|diffuse|normal_specular|translucency_gloss|shadow|Alpha|BaseColor|.*_(Albedo|Normal|Occlusion|Roughness|Metallic|Mixed_AO|Opacity|specular|normal|diffuse|bump|trans)_?.*)\.(png|jpe?g)$|(?i)(mockup|template|sprite|texture|free-soccer-kit)'
$genericAssetFolderPattern = '(?i)^(icons|demo|textures|sprites|logo|logos|materials|prefab|prefabs|template-previews|vendor|favicon|thumbnails?)$'

function Test-UnderRoot([string]$path, [string]$root) {
  if (-not $root) { return $false }
  if (-not (Test-Path -LiteralPath $root)) { return $false }
  $full = [IO.Path]::GetFullPath($path)
  $r = [IO.Path]::GetFullPath($root).TrimEnd('\')
  return ($full -eq $r -or $full.StartsWith($r + '\', [StringComparison]::OrdinalIgnoreCase))
}

function Test-ExcludedRoot([string]$path) {
  foreach ($root in $ExcludeRoots) {
    if (Test-UnderRoot $path $root) { return $true }
  }
  $full = [IO.Path]::GetFullPath($path)
  if ($full -match '(?i)\\node_modules\\|\\vendor\\|\\\.git\\|\\Library\\|\\Temp\\|\\__pycache__\\') { return $true }
  if ($full -match '(?i)\\Installers\\|\\Packages\\|\\ISO\\|\\WinRAR|\\RUFUS\\|\\Crack\\') { return $true }
  return $false
}

function Test-UnityProjectDir([string]$dirPath) {
  return (Test-Path -LiteralPath (Join-Path $dirPath 'Assets') -PathType Container) -and
    (Test-Path -LiteralPath (Join-Path $dirPath 'ProjectSettings') -PathType Container)
}

function Test-CodingProjectDir([string]$dirPath) {
  foreach ($m in $codingFileMarkers) {
    if (Test-Path -LiteralPath (Join-Path $dirPath $m)) { return $true }
  }
  if (Get-ChildItem -LiteralPath $dirPath -Filter '*.sln' -File -ErrorAction SilentlyContinue | Select-Object -First 1) { return $true }
  if (Get-ChildItem -LiteralPath $dirPath -Filter '*.csproj' -File -ErrorAction SilentlyContinue | Select-Object -First 1) { return $true }
  return $false
}

function Test-UnityAssetsDir([string]$dirPath) {
  if ((Split-Path $dirPath -Leaf) -ne 'Assets') { return $false }
  $markers = @('Scenes', 'Scripts', 'Prefabs', 'Materials', 'Resources', 'Plugins', 'Models', 'Textures')
  foreach ($m in $markers) {
    if (Test-Path -LiteralPath (Join-Path $dirPath $m) -PathType Container) { return $true }
  }
  return [bool](Get-ChildItem -LiteralPath $dirPath -Filter '*.meta' -File -ErrorAction SilentlyContinue | Select-Object -First 1)
}

function Test-ProjectAssetPhotoPath([string]$filePath) {
  $full = [IO.Path]::GetFullPath($filePath)
  if ($full -match $projectAssetPathPattern) { return $true }
  if (Test-Path -LiteralPath ($full + '.meta')) { return $true }

  $parent = Split-Path $filePath -Parent
  $leaf = Split-Path $parent -Leaf
  $name = [IO.Path]::GetFileName($filePath)
  if ($name -match $projectAssetNamePattern) { return $true }

  if ($leaf -match $genericAssetFolderPattern) {
    if ($full -match '(?i)\\BrankasDigital\\|\\Download\\|\\Downnloads\\|\\UnityProjects\\') { return $true }
    if (Get-ChildItem -LiteralPath $parent -File -ErrorAction SilentlyContinue |
      Where-Object { $_.Extension -match '^\.(?i)(psd|ai|eps|blend|fbx|obj|url|md|txt|meta|html|css|js|json)$' } |
      Select-Object -First 1) {
      return $true
    }
  }
  return $false
}

function Test-SkipPhotoDirectory([string]$dirPath) {
  if (Test-ExcludedRoot $dirPath) { return $true }
  if (Test-UnityProjectDir $dirPath) { return $true }
  if (Test-CodingProjectDir $dirPath) { return $true }
  if (Test-UnityAssetsDir $dirPath) { return $true }
  $full = [IO.Path]::GetFullPath($dirPath)
  if ($full -match '(?i)\\Downnloads\\Compressed|\\Download\\Compressed|\\Downloads\\Compressed') { return $true }
  return $false
}

function Test-ValidJpeg([string]$path) {
  try {
    $fs = [System.IO.File]::OpenRead($path)
    try {
      if ($fs.Length -lt 4) { return $false }
      $start = New-Object byte[] 3
      [void]$fs.Read($start, 0, 3)
      if (-not ($start[0] -eq 0xFF -and $start[1] -eq 0xD8 -and $start[2] -eq 0xFF)) { return $false }
      $fs.Seek(-2, [System.IO.SeekOrigin]::End) | Out-Null
      $end = New-Object byte[] 2
      [void]$fs.Read($end, 0, 2)
      return ($end[0] -eq 0xFF -and $end[1] -eq 0xD9)
    } finally { $fs.Dispose() }
  } catch { return $false }
}

$script:ReservedDest = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)

function Get-UniquePath([string]$desired) {
  $candidate = $desired
  $parent = Split-Path -Parent $desired
  $base = [IO.Path]::GetFileNameWithoutExtension($desired)
  $ext = [IO.Path]::GetExtension($desired)
  $i = 0
  while ($true) {
    if ($i -gt 0) {
      $candidate = Join-Path $parent ("{0}_{1}{2}" -f $base, $i, $ext)
    }
    if (-not (Test-Path -LiteralPath $candidate) -and $script:ReservedDest.Add($candidate)) {
      return $candidate
    }
    $i++
  }
}

function Get-SourceCategory([string]$filePath) {
  $leaf = Split-Path (Split-Path $filePath -Parent) -Leaf
  if ([string]::IsNullOrWhiteSpace($leaf) -or $leaf -match '^[A-Za-z]:$') { return 'Other' }
  return ($leaf -replace '[\\/:*?"<>|]', '-')
}

function Collect-FromDir([string]$dir, [System.Collections.Generic.List[object]]$plans, [string]$destination) {
  if (Test-SkipPhotoDirectory $dir) { return }

  Get-ChildItem -LiteralPath $dir -File -ErrorAction SilentlyContinue | ForEach-Object {
    $file = $_
    $ext = $file.Extension.ToLowerInvariant()
    $isPhoto = ($ext -in $photoExt) -or ($file.Name -match $photoRigjPattern)
    if (-not $isPhoto) { return }
    if ($file.Length -lt 1KB) { return }
    if (Test-ProjectAssetPhotoPath $file.FullName) { return }

    $category = Get-SourceCategory $file.FullName
    $destDir = Join-Path $destination $category
    $destName = $file.Name
    $isCorrupt = $false
    if ($file.Name -match $photoRigjPattern) {
      if (Test-ValidJpeg $file.FullName) {
        $destName = $file.Name -replace '(?i)\.rigj$', ''
      } else {
        $destDir = Join-Path $destDir '_rusak'
        $isCorrupt = $true
      }
    }
    $plans.Add([pscustomobject]@{
        From     = $file.FullName
        To       = Get-UniquePath (Join-Path $destDir $destName)
        Category = $category
        Size     = $file.Length
        Corrupt  = $isCorrupt
      }) | Out-Null
  }

  Get-ChildItem -LiteralPath $dir -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    Collect-FromDir $_.FullName $plans $destination
  }
}

$plans = New-Object System.Collections.Generic.List[object]
$destFull = [IO.Path]::GetFullPath($Destination)

foreach ($source in $SourcePaths) {
  if (-not (Test-Path -LiteralPath $source)) { continue }
  if (Test-Path -LiteralPath $source -PathType Leaf) {
    Write-Host "Skip leaf path; use folder: $source"
    continue
  }
  if (Test-UnderRoot $source $Destination) { continue }
  Collect-FromDir ([IO.Path]::GetFullPath($source)) $plans $Destination
}

# drop anything already under destination
$plans = [System.Collections.Generic.List[object]]@($plans | Where-Object {
  -not $_.From.StartsWith($destFull + '\', [StringComparison]::OrdinalIgnoreCase)
})

Write-Host ("Plan -> {0}" -f $Destination)
$plans | Group-Object Category | Sort-Object Count -Descending | Select-Object -First 40 | ForEach-Object {
  Write-Host ("  {0}: {1}" -f $_.Name, $_.Count)
}
$rest = ($plans | Group-Object Category).Count - 40
if ($rest -gt 0) { Write-Host ("  ... and {0} more categories" -f $rest) }
$corruptCount = @($plans | Where-Object Corrupt).Count
Write-Host ("  corrupt(.rigj): {0}" -f $corruptCount)
Write-Host ("  total files: {0}" -f $plans.Count)
Write-Host ("  total size: {0} GB" -f [math]::Round((@($plans) | Measure-Object Size -Sum).Sum / 1GB, 2))

if (-not $Apply) {
  Write-Host 'Dry-run only. Re-run with -Apply.'
  return
}

$moved = 0
foreach ($p in $plans) {
  $dir = Split-Path -Parent $p.To
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  try {
    Move-Item -LiteralPath $p.From -Destination $p.To -ErrorAction Stop
    $moved++
    if ($moved % 100 -eq 0) { Write-Host "Moved $moved..." }
  } catch {
    Write-Host ("FAIL: {0} :: {1}" -f $p.From, $_.Exception.Message)
  }
}
Write-Host ("Done. Moved {0}/{1} photo(s) ({2} corrupt to _rusak)." -f $moved, $plans.Count, $corruptCount)
