<#
.SYNOPSIS
  Collect standalone installers, ISO images, and installer packages (folder/archive) into one folder.
.DESCRIPTION
  - Standalone .exe/.msi/.msix/.appimage -> Installers root
  - .iso/.img -> Installers/ISO/
  - Folder/archive that ships as one installer bundle -> Installers/Packages/ (whole item, never split)
  - AppImage inside folder with siblings/subdirs -> entire folder (never split AppImage only)
  - Optional dedupe keeps newest version per app family
.EXAMPLE
  .\collect-installers.ps1 -SourcePaths 'D:\Download','D:\BrankasDigital'
  .\collect-installers.ps1 -SourcePaths 'D:\Download' -Destination 'D:\Installers' -Apply -Dedupe
#>
param(
  [Parameter(Mandatory = $true)]
  [string[]]$SourcePaths,
  [string]$Destination = 'D:\Installers',
  [switch]$Apply,
  [switch]$Dedupe
)

$ErrorActionPreference = 'Stop'

$standaloneExt = @('.exe', '.msi', '.msix', '.msp', '.appx', '.appxbundle')
$isoExt = @('.iso', '.img')
$archiveExt = @('.zip', '.rar', '.7z', '.tar', '.gz')
$setupNames = @('setup.exe', 'install.exe', 'installer.exe', 'setup.msi', 'install.msi')
$excludePatterns = @(
  '*\Windows\*', '*\Program Files\*', '*\Program Files (x86)\*', '*\ProgramData\*',
  '*\System Volume Information\*', '*$RECYCLE.BIN\*',
  '*\node_modules\*', '*\vendor\*', '*\.git\*', '*\flutter\*', '*\.gradle\*',
  '*\ai-software-house\*', '*\ZonaKreatif\*', '*\simrs\*', '*\Unity\*',
  '*\Crack\*'
)
$nonInstallerExe = @(
  'adb.exe', 'UnityCrashHandler64.exe', 'Alarm.exe', 'resume.exe', 'presensi.exe',
  'FlexCodeSDK.exe', 'iobituninstaller.exe'
)

function Test-ExcludedPath([string]$path) {
  foreach ($pat in $excludePatterns) {
    if ($path -like $pat) { return $true }
  }
  if ($path -like "*$Destination*") { return $true }
  return $false
}

function Get-UniquePath([string]$desired) {
  if (-not (Test-Path -LiteralPath $desired)) { return $desired }
  $parent = Split-Path -Parent $desired
  $leaf = Split-Path -Leaf $desired
  if (Test-Path -LiteralPath $desired -PathType Container) {
    $base = $leaf
    $ext = ''
  } else {
    $base = [IO.Path]::GetFileNameWithoutExtension($leaf)
    $ext = [IO.Path]::GetExtension($leaf)
  }
  $i = 1
  while ($true) {
    $candidate = Join-Path $parent ("{0}_{1}{2}" -f $base, $i, $ext)
    if (-not (Test-Path -LiteralPath $candidate)) { return $candidate }
    $i++
  }
}

function Test-AppImageFile([System.IO.FileInfo]$file) {
  return $file.Name -match '(?i)\.appimage(\.zsync)?$'
}

function Test-UnderPackageRoot([string]$filePath, [System.Collections.Generic.HashSet[string]]$roots) {
  $full = [IO.Path]::GetFullPath($filePath)
  foreach ($root in $roots) {
    $r = [IO.Path]::GetFullPath($root).TrimEnd('\', '/')
    if ($full.Equals($r, [StringComparison]::OrdinalIgnoreCase)) { return $true }
    if ($full.StartsWith($r + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { return $true }
  }
  return $false
}

function Get-AppImagePackageRoot([System.IO.FileInfo]$file) {
  $dir = $file.Directory
  if (-not $dir) { return $null }
  $entries = @(Get-ChildItem -LiteralPath $dir.FullName -ErrorAction SilentlyContinue)
  $fileCount = @($entries | Where-Object { -not $_.PSIsContainer }).Count
  $dirCount = @($entries | Where-Object { $_.PSIsContainer }).Count
  if ($fileCount -gt 1 -or $dirCount -gt 0) { return $dir.FullName }
  return $null
}

function Add-PackageFolderPlan(
  [System.Collections.Generic.List[object]]$plans,
  [System.Collections.Generic.HashSet[string]]$packageRoots,
  [string]$pkgPath,
  [string]$destPackages
) {
  if ($packageRoots.Contains($pkgPath)) { return }
  [void]$packageRoots.Add($pkgPath)
  $pkgName = Split-Path -Leaf $pkgPath
  $size = (Get-ChildItem -LiteralPath $pkgPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
  $plans.Add([pscustomobject]@{
      Kind = 'package-folder'
      From = $pkgPath
      To   = Get-UniquePath (Join-Path $destPackages $pkgName)
      Size = $size
      Name = $pkgName
    }) | Out-Null
}

function Test-InstallerArchive([System.IO.FileInfo]$file) {
  $name = $file.Name
  if ($file.Extension.ToLowerInvariant() -notin $archiveExt) { return $false }
  if ($file.Length -lt 5MB) { return $false }
  return $name -match '(?i)(setup|install|installer|portable|offline|windows|win64|x64|amd64|desktop|community|stable|pro|studio|collection|ubuntu|flutter|java|openjdk|obs|git-cola|makehuman|substance|reallusion|iclone|winrar|rufus|capcut|adobe|postgresql|xampp|android-studio|vscode|cursor|docker|node-v|python-|\.iso\.|\.img\.)'
}

function Test-InstallerBundleFolder([string]$dirPath) {
  if (Test-ExcludedPath $dirPath) { return $false }
  $leaf = Split-Path $dirPath -Leaf
  if ($leaf -match '(?i)^(Projects|node_modules|vendor|Library|Temp|obj|bin)$') { return $false }
  $children = @(Get-ChildItem -LiteralPath $dirPath -ErrorAction SilentlyContinue)
  if ($children.Count -eq 0) { return $false }
  $hasInstallReadme = @($children | Where-Object { -not $_.PSIsContainer -and $_.Name -match '(?i)readme.*install|how to install|car[aá] instal' }).Count -gt 0
  $hasCrackDir = @($children | Where-Object { $_.PSIsContainer -and $_.Name -match '(?i)^crack$' }).Count -gt 0
  $hasBlockHost = @($children | Where-Object { -not $_.PSIsContainer -and $_.Name -match '(?i)blockhost' }).Count -gt 0
  $hasSetup = @($children | Where-Object { -not $_.PSIsContainer -and ($setupNames -contains $_.Name.ToLowerInvariant()) }).Count -gt 0
  $hasPortableExe = @($children | Where-Object { -not $_.PSIsContainer -and $_.Name -match '(?i)(rufus|portable|winrar).*\.exe$' }).Count -gt 0
  $hasLargeRar = @($children | Where-Object { -not $_.PSIsContainer -and $_.Extension -match '^\.rar$' -and $_.Length -gt 50MB }).Count -gt 0
  $nameMatch = $leaf -match '(?i)^(winrar|rufus|iobit|adobe|capcut|substance|nesabamedia|master\.collection|mster\.coll|uninstaller)'
  if ($nameMatch) { return $true }
  if ($hasSetup -and ($hasCrackDir -or $hasInstallReadme -or $hasBlockHost -or $children.Count -gt 1)) { return $true }
  if ($hasInstallReadme -and ($hasCrackDir -or $hasBlockHost)) { return $true }
  if ($hasPortableExe -and $leaf -match '(?i)rufus') { return $true }
  if ($hasLargeRar -and $leaf -match '(?i)adobe') { return $true }
  return $false
}

function Test-UnderOtherBundle([string]$dirPath, [string[]]$bundlePaths) {
  $full = [IO.Path]::GetFullPath($dirPath)
  foreach ($other in $bundlePaths) {
    if ($other.Equals($dirPath, [StringComparison]::OrdinalIgnoreCase)) { continue }
    $o = [IO.Path]::GetFullPath($other).TrimEnd('\', '/')
    if ($full.StartsWith($o + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { return $true }
  }
  return $false
}

function Get-PackageRoot([System.IO.FileInfo]$setupFile) {
  $dir = $setupFile.Directory
  $setupCount = @(Get-ChildItem -LiteralPath $dir.FullName -File -ErrorAction SilentlyContinue |
    Where-Object { $setupNames -contains $_.Name.ToLowerInvariant() }).Count
  $allFiles = @(Get-ChildItem -LiteralPath $dir.FullName -File -ErrorAction SilentlyContinue)
  $allDirs = @(Get-ChildItem -LiteralPath $dir.FullName -Directory -ErrorAction SilentlyContinue)
  if ($allFiles.Count -le 2 -and $allDirs.Count -eq 1 -and $setupCount -ge 1) {
    return $allDirs[0].FullName
  }
  if ($allFiles.Count -gt 1 -or $allDirs.Count -gt 0) {
    return $dir.FullName
  }
  return $null
}

function Get-AppKey([string]$name) {
  $n = [IO.Path]::GetFileNameWithoutExtension($name).ToLowerInvariant()
  $n = $n -replace '\(\d+\)$', ''
  $n = $n -replace '_\d+$', ''
  $n = $n -replace '(?i)(setup|install|installer|windows|portable|offline|nesabamedia|kuyhaa|pesktop\.com|\[.*?\]|\(.*?\))', ''
  $n = $n -replace '[^a-z0-9]+', '-'
  $n = $n.Trim('-')
  if ([string]::IsNullOrWhiteSpace($n)) { return $name.ToLowerInvariant() }
  return $n
}

function Get-VersionScore([string]$name) {
  $scoreText = $null
  if ($name -match '(?i)(\d{4})[\.\-_](\d+)[\.\-_](\d+)') {
    $scoreText = "$($matches[1]).$($matches[2]).$($matches[3])"
  } elseif ($name -match '(?i)(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)') {
    $scoreText = "$($matches['major']).$($matches['minor']).$($matches['patch'])"
  } elseif ($name -match '(?i)(?<major>\d+)\.(?<minor>\d+)') {
    $scoreText = "$($matches['major']).$($matches['minor'])"
  }
  if ([string]::IsNullOrWhiteSpace($scoreText)) { return 0.0 }
  try {
    return [double]::Parse($scoreText, [System.Globalization.CultureInfo]::InvariantCulture)
  } catch {
    return 0.0
  }
}

$destRoot = [IO.Path]::GetFullPath($Destination)
$destIso = Join-Path $destRoot 'ISO'
$destPackages = Join-Path $destRoot 'Packages'
$plans = New-Object System.Collections.Generic.List[object]
$packageRoots = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)

foreach ($source in $SourcePaths) {
  if (-not (Test-Path -LiteralPath $source -PathType Container)) { continue }
  if ($source -match '(?i)^[A-Za-z]:\\Windows($|\\)|^[A-Za-z]:\\Program Files') { continue }

  Get-ChildItem -LiteralPath $source -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $file = $_
    if (Test-ExcludedPath $file.FullName) { return }
    if (Test-AppImageFile $file) {
      $pkg = Get-AppImagePackageRoot $file
      if ($pkg) { Add-PackageFolderPlan $plans $packageRoots $pkg $destPackages }
      return
    }
    $ext = $file.Extension.ToLowerInvariant()
    if ($ext -in $standaloneExt -and ($setupNames -contains $file.Name.ToLowerInvariant())) {
      $pkg = Get-PackageRoot $file
      if ($pkg) { Add-PackageFolderPlan $plans $packageRoots $pkg $destPackages }
    }
  }
}

foreach ($source in $SourcePaths) {
  if (-not (Test-Path -LiteralPath $source -PathType Container)) { continue }
  if ($source -match '(?i)^[A-Za-z]:\\Windows($|\\)|^[A-Za-z]:\\Program Files') { continue }

  $bundleDirs = New-Object System.Collections.Generic.List[string]
  Get-ChildItem -LiteralPath $source -Directory -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    if (Test-InstallerBundleFolder $_.FullName) {
      $bundleDirs.Add($_.FullName) | Out-Null
    }
  }
  foreach ($dir in ($bundleDirs | Sort-Object { $_.Length } -Descending)) {
    if (Test-UnderPackageRoot $dir $packageRoots) { continue }
    if (Test-UnderOtherBundle $dir $bundleDirs.ToArray()) { continue }
    Add-PackageFolderPlan $plans $packageRoots $dir $destPackages
  }
}

foreach ($source in $SourcePaths) {
  if (-not (Test-Path -LiteralPath $source -PathType Container)) { continue }
  if ($source -match '(?i)^[A-Za-z]:\\Windows($|\\)|^[A-Za-z]:\\Program Files') { continue }

  Get-ChildItem -LiteralPath $source -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $file = $_
    if (Test-ExcludedPath $file.FullName) { return }
    if (Test-UnderPackageRoot $file.FullName $packageRoots) { return }
    $ext = $file.Extension.ToLowerInvariant()

    if ($ext -in $isoExt -and $file.Length -ge 1MB) {
      $plans.Add([pscustomobject]@{
          Kind = 'iso'
          From = $file.FullName
          To   = Get-UniquePath (Join-Path $destIso $file.Name)
          Size = $file.Length
          Name = $file.Name
        }) | Out-Null
      return
    }

    if (Test-InstallerArchive $file) {
      $plans.Add([pscustomobject]@{
          Kind = 'package-archive'
          From = $file.FullName
          To   = Get-UniquePath (Join-Path $destPackages $file.Name)
          Size = $file.Length
          Name = $file.Name
        }) | Out-Null
      return
    }

    if ($ext -in $standaloneExt -and $file.Length -ge 1MB -and ($nonInstallerExe -notcontains $file.Name)) {
      $isSetup = $setupNames -contains $file.Name.ToLowerInvariant()
      if ($isSetup) { return }
      $plans.Add([pscustomobject]@{
          Kind = 'standalone'
          From = $file.FullName
          To   = Get-UniquePath (Join-Path $destRoot $file.Name)
          Size = $file.Length
          Name = $file.Name
        }) | Out-Null
      return
    }

    if (Test-AppImageFile $file -and $file.Length -ge 1MB) {
      $plans.Add([pscustomobject]@{
          Kind = 'standalone'
          From = $file.FullName
          To   = Get-UniquePath (Join-Path $destRoot $file.Name)
          Size = $file.Length
          Name = $file.Name
        }) | Out-Null
    }
  }
}

if ($Dedupe -and $plans.Count -gt 0) {
  $keep = New-Object System.Collections.Generic.List[object]
  $groups = $plans | Group-Object { Get-AppKey $_.Name }
  foreach ($g in $groups) {
    $best = $g.Group | Sort-Object @{ Expression = { Get-VersionScore $_.Name }; Descending = $true }, Size -Descending | Select-Object -First 1
    $keep.Add($best) | Out-Null
  }
  $plans = $keep
}

Write-Host ("Plan -> {0}" -f $destRoot)
Write-Host ("  standalone : {0}" -f @($plans | Where-Object Kind -eq 'standalone').Count)
Write-Host ("  iso        : {0}" -f @($plans | Where-Object Kind -eq 'iso').Count)
Write-Host ("  packages   : {0}" -f @($plans | Where-Object { $_.Kind -like 'package-*' }).Count)
Write-Host ("  total size : {0} GB" -f [math]::Round(($plans | Measure-Object Size -Sum).Sum / 1GB, 2))
Write-Host ''
$plans | Sort-Object Kind, Name | ForEach-Object {
  Write-Host ("[{0}] {1}" -f $_.Kind, $_.From)
  Write-Host ("       -> {0}" -f $_.To)
}

if (-not $Apply) {
  Write-Host ''
  Write-Host 'Dry-run only. Re-run with -Apply to move.'
  return
}

foreach ($dir in @($destRoot, $destIso, $destPackages)) {
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$moved = 0
foreach ($p in $plans) {
  $parent = Split-Path -Parent $p.To
  if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }
  Move-Item -LiteralPath $p.From -Destination $p.To
  Write-Host ("Moved: {0}" -f $p.From)
  $moved++
}
Write-Host ("Done. Moved {0} item(s)." -f $moved)
