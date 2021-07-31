<#
.SYNOPSIS
  Build RSA-signed ATTRIBUTION.seal (requires Rogue private key).
#>
param(
  [string]$PrivateKeyPath = ""
)

$ErrorActionPreference = "Stop"
$CatalogRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
. (Join-Path $PSScriptRoot "_attribution-crypto.ps1")

if (-not $PrivateKeyPath) {
  $PrivateKeyPath = Join-Path $CatalogRoot.Path ".attribution-private.xml"
}
if (-not (Test-Path -LiteralPath $PrivateKeyPath)) {
  Write-Error @"
Private key not found: $PrivateKeyPath

Attribution seals must be signed by Rogue Development.
Run once: .\\scripts\\generate-attribution-keys.ps1
Then:     .\\scripts\\generate-attribution-seal.ps1
Never distribute the private key.
"@
  exit 1
}

$pub = Join-Path $CatalogRoot.Path "ATTRIBUTION.public.xml"
if (-not (Test-Path -LiteralPath $pub)) {
  Write-Error "ATTRIBUTION.public.xml missing. Run generate-attribution-keys.ps1 first."
  exit 1
}

$entries = Get-AttributionFileMap -CatalogRoot $CatalogRoot.Path
$files = @{}
foreach ($e in $entries) {
  # Do not hash the seal itself
  if ($e.Rel -eq "ATTRIBUTION.seal") { continue }
  $files[$e.Rel] = (Get-FileSha256Hex -Path $e.Path)
}

$payload = [ordered]@{
  version = 2
  author  = "Rogue Development"
  github  = "https://github.com/rogue-dev-studio"
  marker  = $script:AttributionMarker
  created = (Get-Date).ToUniversalTime().ToString("o")
  files   = $files
}
$json = ($payload | ConvertTo-Json -Depth 8 -Compress)
$sealPath = Join-Path $CatalogRoot.Path "ATTRIBUTION.seal"
Write-SignedAttributionSeal -PlainJson $json -OutFile $sealPath -PrivateKeyPath $PrivateKeyPath
Write-Host "Wrote RSA-signed seal: $sealPath ($($files.Count) files)"
Write-Host "Verify: .\\scripts\\verify-attribution.ps1"
