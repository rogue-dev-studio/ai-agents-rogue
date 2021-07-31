<#
.SYNOPSIS
  Harden attribution: pin official public-key fingerprint and match GitHub upstream.
  Replacing ATTRIBUTION.public.xml / re-sealing with another key fails this check.
#>
param(
  [string]$CatalogRoot = ""
)

$ErrorActionPreference = "Stop"

# SHA-256 of official ATTRIBUTION.public.xml (file bytes). Rotate only with new Rogue keypair + re-seal.
$OfficialPublicKeySha256 = "567ed3522d44b689bbe4f64aa85ffe6a7a1e78ecbab2f1ee36ef2c48e98044cb"
$Owner = "rogue-dev-studio"
$Repo = "ai-agents-rogue"

if (-not $CatalogRoot) {
  $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
  $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}

function Get-Sha256File([string]$Path) {
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    $fs = [System.IO.File]::OpenRead($Path)
    try {
      return ([BitConverter]::ToString($sha.ComputeHash($fs)) -replace '-', '').ToLowerInvariant()
    } finally { $fs.Dispose() }
  } finally { $sha.Dispose() }
}

$failed = New-Object System.Collections.Generic.List[string]
$pubPath = Join-Path $CatalogRoot "ATTRIBUTION.public.xml"
if (-not (Test-Path -LiteralPath $pubPath)) {
  Write-Host "OFFICIAL KEY PIN FAILED - missing ATTRIBUTION.public.xml" -ForegroundColor Red
  exit 1
}

$localFp = Get-Sha256File -Path $pubPath
if ($localFp -ne $OfficialPublicKeySha256) {
  $failed.Add("Public key was replaced/unofficial. expected=$OfficialPublicKeySha256 actual=$localFp")
}

$configPath = Join-Path $CatalogRoot "GITHUB_ENTITLEMENT.json"
if (Test-Path $configPath) {
  $cfg = Get-Content $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
  if ($cfg.officialOwner) { $Owner = [string]$cfg.officialOwner }
  if ($cfg.officialRepo) { $Repo = [string]$cfg.officialRepo }
  if ($cfg.officialPublicKeySha256 -and ([string]$cfg.officialPublicKeySha256).ToLowerInvariant() -ne $OfficialPublicKeySha256) {
    $failed.Add("GITHUB_ENTITLEMENT.json officialPublicKeySha256 does not match hardcoded pin")
  }
}

$token = $null
if ($env:GITHUB_TOKEN) { $token = $env:GITHUB_TOKEN.Trim() }
elseif ($env:GH_TOKEN) { $token = $env:GH_TOKEN.Trim() }
elseif (Get-Command gh -ErrorAction SilentlyContinue) {
  try { $t = & gh auth token 2>$null; if ($LASTEXITCODE -eq 0 -and $t) { $token = $t.Trim() } } catch {}
}

function Fetch-UpstreamPublicKey {
  $uris = @(
    "https://raw.githubusercontent.com/$Owner/$Repo/main/ATTRIBUTION.public.xml",
    "https://raw.githubusercontent.com/$Owner/$Repo/master/ATTRIBUTION.public.xml"
  )
  $headers = @{ "User-Agent" = "ai-agents-rogue-official-pin" }
  if ($token) { $headers["Authorization"] = "Bearer $token" }
  foreach ($uri in $uris) {
    try {
      $resp = Invoke-WebRequest -Uri $uri -Headers $headers -UseBasicParsing
      if ([int]$resp.StatusCode -eq 200 -and $resp.Content) {
        return [string]$resp.Content
      }
    } catch { }
  }
  # API contents fallback
  try {
    $api = "https://api.github.com/repos/$Owner/$Repo/contents/ATTRIBUTION.public.xml?ref=main"
    $h = @{
      "User-Agent"           = "ai-agents-rogue-official-pin"
      "Accept"               = "application/vnd.github.raw"
      "X-GitHub-Api-Version" = "2022-11-28"
    }
    if ($token) { $h["Authorization"] = "Bearer $token" }
    $resp = Invoke-WebRequest -Uri $api -Headers $h -UseBasicParsing
    if ([int]$resp.StatusCode -eq 200 -and $resp.Content) { return [string]$resp.Content }
  } catch { }
  return $null
}

$remote = Fetch-UpstreamPublicKey
if ($null -eq $remote) {
  if ($env:AAR_OFFLINE_DEV -eq "1") {
    Write-Host "WARNING: GitHub upstream key not reachable; offline pin-only (AAR_OFFLINE_DEV=1)." -ForegroundColor Yellow
  } else {
    $failed.Add("Cannot fetch official ATTRIBUTION.public.xml from GitHub $Owner/$Repo. Publish the repo and ensure network access. (Rogue packaging only: AAR_OFFLINE_DEV=1)")
  }
} else {
  $tmp = Join-Path $env:TEMP ("aar-official-pub-" + [guid]::NewGuid().ToString("n") + ".xml")
  [System.IO.File]::WriteAllText($tmp, $remote)
  $remoteFp = Get-Sha256File -Path $tmp
  Remove-Item $tmp -Force -ErrorAction SilentlyContinue
  if ($remoteFp -ne $OfficialPublicKeySha256) {
    $failed.Add("GitHub upstream public key fingerprint is not the Rogue official pin")
  }
  $localText = ([System.IO.File]::ReadAllText($pubPath)).Trim()
  $remoteText = $remote.Trim()
  if ($localText -ne $remoteText) {
    $failed.Add("Local ATTRIBUTION.public.xml does not match GitHub official file (unofficial key substitution)")
  }
}

# git origin must reference official repo or a fork named ai-agents-rogue
$probeRoots = @($CatalogRoot, (Split-Path $CatalogRoot -Parent))
foreach ($root in $probeRoots) {
  if (-not (Test-Path (Join-Path $root ".git"))) { continue }
  try {
    $origin = (& git -C $root remote get-url origin 2>$null)
    if ($LASTEXITCODE -ne 0 -or -not $origin) { break }
    $origin = $origin.Trim()
    $looksOfficial = $origin -match [regex]::Escape("$Owner/$Repo")
    $looksForkName = $origin -match ("[/:]" + [regex]::Escape($Repo) + "(\.git)?\s*$")
    if (-not ($looksOfficial -or $looksForkName)) {
      $failed.Add("git origin is not official/fork of $Owner/$Repo (origin=$origin)")
    } else {
      Write-Host "git origin OK: $origin"
    }
  } catch { }
  break
}

if ($failed.Count -gt 0) {
  Write-Host "OFFICIAL UPSTREAM PIN FAILED - AI MUST STOP.

$($failed -join "`n")

Official: https://github.com/$Owner/$Repo
Author: Rogue Development
" -ForegroundColor Red
  exit 1
}

Write-Host "OFFICIAL KEY PIN OK - Rogue Development (fingerprint + GitHub upstream)"
exit 0
