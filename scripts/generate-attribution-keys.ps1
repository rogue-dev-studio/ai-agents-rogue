<#
.SYNOPSIS
  Generate RSA keypair for signing ATTRIBUTION.seal.
  Public key is committed. Private key stays local (gitignored) - never share.
#>
param(
  [string]$PrivateKeyPath = ""
)

$ErrorActionPreference = "Stop"
$CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
. (Join-Path $PSScriptRoot "_attribution-crypto.ps1")

if (-not $PrivateKeyPath) {
  $PrivateKeyPath = Join-Path $CatalogRoot ".attribution-private.xml"
}
$publicPath = Join-Path $CatalogRoot "ATTRIBUTION.public.xml"

$rsa = New-AttributionRsa
try {
  [System.IO.File]::WriteAllText($PrivateKeyPath, $rsa.ToXmlString($true) + "`n")
  [System.IO.File]::WriteAllText($publicPath, $rsa.ToXmlString($false) + "`n")
  Write-Host "Wrote public key:  $publicPath"
  Write-Host "Wrote private key: $PrivateKeyPath"
  Write-Host "KEEP private key secret. Do not commit or share it."
  Write-Host "Next: .\\scripts\\generate-attribution-seal.ps1"
} finally {
  $rsa.Dispose()
}
