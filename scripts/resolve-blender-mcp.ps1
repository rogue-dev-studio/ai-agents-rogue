<#
.SYNOPSIS
  Detect installed Blender version and choose MCP package (blender-lab vs blender).
.OUTPUTS
  Writes object: PackageId, BlenderVersion, Reason
#>
param(
  [string]$CatalogRoot = ""
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
  $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
  $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}

function Parse-BlenderVersion([string]$Text) {
  if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
  if ($Text -match 'Blender\s+(\d+\.\d+(?:\.\d+)?)') {
    try { return [version]$Matches[1] } catch { return $null }
  }
  return $null
}

function Get-BlenderExeCandidates {
  $list = New-Object System.Collections.Generic.List[string]
  $names = @("blender.exe", "blender")
  foreach ($n in $names) {
    try {
      $cmd = Get-Command $n -ErrorAction SilentlyContinue
      if ($cmd -and $cmd.Source) { [void]$list.Add($cmd.Source) }
    } catch {}
  }
  $roots = @(
    ${env:ProgramFiles},
    ${env:ProgramFiles(x86)},
    (Join-Path ${env:LOCALAPPDATA} "Programs")
  ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }
  foreach ($root in $roots) {
    $pattern = Join-Path $root "Blender Foundation\Blender*\blender.exe"
    Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | ForEach-Object {
      [void]$list.Add($_.FullName)
    }
  }
  return $list | Select-Object -Unique
}

function Get-BlenderVersionFromExe([string]$ExePath) {
  if (-not (Test-Path -LiteralPath $ExePath)) { return $null }
  try {
    $out = & $ExePath --version 2>&1 | Out-String
    return Parse-BlenderVersion $out
  } catch {
    return $null
  }
}

function Get-HighestBlenderVersion {
  $best = $null
  $bestPath = $null
  foreach ($exe in (Get-BlenderExeCandidates)) {
    $ver = Get-BlenderVersionFromExe $exe
    if (-not $ver) { continue }
    if (-not $best -or $ver -gt $best) {
      $best = $ver
      $bestPath = $exe
    }
  }
  if (-not $best) {
    $cfg = Join-Path $env:APPDATA "Blender Foundation\Blender"
    if (Test-Path -LiteralPath $cfg) {
      Get-ChildItem -Path $cfg -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $name = $_.Name
        if ($name -match '^(\d+\.\d+(?:\.\d+)?)$') {
          try {
            $v = [version]$Matches[1]
            if (-not $best -or $v -gt $best) { $best = $v; $bestPath = $null }
          } catch {}
        }
      }
    }
  }
  return @{ Version = $best; Exe = $bestPath }
}

$info = Get-HighestBlenderVersion
$ver = $info.Version
$labMin = [version]"5.1.0"

if ($ver -and $ver -ge $labMin) {
  $pkg = "blender-lab"
  $reason = "Blender $($ver.ToString()) >= 5.1 -> official Lab MCP"
} else {
  $pkg = "blender"
  if ($ver) {
    $reason = "Blender $($ver.ToString()) < 5.1 -> community MCP (addon in mcp/blender)"
  } else {
    $reason = "Blender not detected -> default community MCP (install addon manually)"
  }
}

$result = [pscustomobject]@{
  PackageId       = $pkg
  BlenderVersion  = if ($ver) { $ver.ToString() } else { $null }
  BlenderExe      = $info.Exe
  Reason          = $reason
  AlternateRemove = if ($pkg -eq "blender-lab") { @("blender") } else { @("blender-lab") }
  LabMinVersion   = "5.1.0"
}

$result
