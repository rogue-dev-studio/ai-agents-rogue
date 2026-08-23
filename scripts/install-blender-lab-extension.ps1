<#
.SYNOPSIS
  Download and install official Blender Lab MCP extension (Blender 5.1+).
.PARAMETER BlenderExe
  Path to blender.exe (auto-detect if omitted).
.PARAMETER RepoId
  Extension repo id for install-file fallback (default: user_default).
.PARAMETER LabRepoId
  Remote repo id for lab.blender.org (default: lab_blender_org).
.PARAMETER SkipDownload
  Reuse cached ZIP in mcp/blender-lab/downloads/.
.PARAMETER OpenBlender
  Launch Blender GUI after install (for Start MCP Server).
#>
param(
  [string]$BlenderExe = "",
  [string]$RepoId = "user_default",
  [string]$LabRepoId = "lab_blender_org",
  [switch]$SkipDownload,
  [switch]$OpenBlender
)

$ErrorActionPreference = "Stop"

$CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$PkgRoot = Join-Path $CatalogRoot "mcp\blender-lab"
$DownloadDir = Join-Path $PkgRoot "downloads"
$ReleaseApi = "https://projects.blender.org/api/v1/repos/lab/blender_mcp/releases?limit=1"
$LabRepoUrl = "https://lab.blender.org/"

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Invoke-BlenderCommand([string]$Exe, [string[]]$Args) {
  Write-Host "> `"$Exe`" $($Args -join ' ')"
  & $Exe @Args 2>&1 | ForEach-Object { Write-Host $_ }
  return $LASTEXITCODE
}

function Get-LatestMcpZipAsset {
  $json = Invoke-RestMethod -Uri $ReleaseApi -TimeoutSec 60
  $rel = @($json)[0]
  if (-not $rel) { throw "No releases found at $ReleaseApi" }
  $asset = $rel.assets | Where-Object { $_.name -like "mcp-*.zip" } | Select-Object -First 1
  if (-not $asset) { throw "Release $($rel.tag_name) has no mcp-*.zip asset" }
  return @{
    Tag      = [string]$rel.tag_name
    Name     = [string]$asset.name
    Url      = [string]$asset.browser_download_url
    LocalZip = Join-Path $DownloadDir $asset.name
  }
}

function Test-ExtensionInstalled([string]$Exe) {
  $out = & $Exe --command extension list 2>&1 | Out-String
  return ($out -match '\bmcp\b')
}

$resolveScript = Join-Path $PSScriptRoot "resolve-blender-mcp.ps1"
$resolved = & $resolveScript -CatalogRoot $CatalogRoot
if ($resolved.PackageId -ne "blender-lab") {
  throw "Blender Lab extension requires 5.1+. Detected: $($resolved.Reason). Use community addon instead."
}
if (-not $BlenderExe) {
  if ($resolved.BlenderExe) { $BlenderExe = $resolved.BlenderExe }
  else { throw "Blender executable not found. Pass -BlenderExe." }
}
if (-not (Test-Path -LiteralPath $BlenderExe)) {
  throw "Blender not found: $BlenderExe"
}

Ensure-Dir $DownloadDir
Write-Host "Blender: $($resolved.BlenderVersion) -> $BlenderExe"

if (Test-ExtensionInstalled $BlenderExe) {
  Write-Host "Extension MCP already listed in Blender. Skipping install."
}
else {
  $asset = Get-LatestMcpZipAsset
  Write-Host "Release: $($asset.Tag) -> $($asset.Name)"

  if ((-not (Test-Path -LiteralPath $asset.LocalZip)) -or -not $SkipDownload) {
    Write-Host "Downloading $($asset.Url)"
    Invoke-WebRequest -Uri $asset.Url -OutFile $asset.LocalZip -TimeoutSec 120
    Write-Host "Saved: $($asset.LocalZip)"
  }
  else {
    Write-Host "Using cached: $($asset.LocalZip)"
  }

  $zipPath = (Resolve-Path $asset.LocalZip).Path

  Write-Host "Adding Lab repository (ignore error if already exists)..."
  $null = Invoke-BlenderCommand $BlenderExe @(
    "--command", "extension", "repo-add", $LabRepoId,
    "--name", "Blender Lab",
    "--url", $LabRepoUrl
  )

  Write-Host "Trying remote install from lab.blender.org..."
  $remoteOk = $false
  $code = Invoke-BlenderCommand $BlenderExe @("--command", "extension", "install", "-s", "-e", "mcp")
  if ($code -eq 0) { $remoteOk = $true }

  if (-not $remoteOk) {
    Write-Host "Remote install failed or unavailable. Installing from disk..."
    $code = Invoke-BlenderCommand $BlenderExe @(
      "--command", "extension", "install-file",
      "-r", $RepoId,
      "-e",
      $zipPath
    )
    if ($code -ne 0) { throw "install-file failed (exit $code). Try manual: Edit > Preferences > Get Extensions > Install from Disk > $zipPath" }
  }

  if (-not (Test-ExtensionInstalled $BlenderExe)) {
    Write-Warning "Install finished but 'mcp' not visible in extension list. Verify in Blender UI."
  }
  else {
    Write-Host "Extension MCP installed and enabled."
  }
}

Write-Host ""
Write-Host "Next (manual once per session unless Auto Start is on):"
Write-Host "  1. Open Blender"
Write-Host "  2. Edit > Preferences > Extensions > MCP > Start MCP Server (port 9876)"
Write-Host "  3. Cursor MCP blender-lab should connect after host restart"
Write-Host ""
Write-Host "ZIP cache: $DownloadDir"

if ($OpenBlender) {
  Write-Host "Launching Blender..."
  Start-Process -FilePath $BlenderExe
}
