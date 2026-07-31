<#
.SYNOPSIS
  Shared attribution integrity for AI Agents Rogue.
  Visible credit stays plaintext. Seal is RSA-SHA256 signed (private key not distributed).
#>

$script:AttributionMarker = "ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE"

function Get-FileSha256Hex([string]$Path) {
  # Hash UTF-8 text with LF newlines only so Windows/Linux verify the same way.
  # (Raw byte hash breaks when Git checks out CRLF vs LF.)
  $raw = [System.IO.File]::ReadAllBytes($Path)
  $text = [System.Text.Encoding]::UTF8.GetString($raw)
  if ($text.Length -gt 0 -and [int][char]$text[0] -eq 0xFEFF) {
    $text = $text.Substring(1)
  }
  $normalized = ($text -replace "`r`n", "`n") -replace "`r", "`n"
  $data = [System.Text.Encoding]::UTF8.GetBytes($normalized)
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    $hash = $sha.ComputeHash($data)
    return ([BitConverter]::ToString($hash) -replace '-', '').ToLowerInvariant()
  } finally { $sha.Dispose() }
}

function Get-AttributionFileMap([string]$CatalogRoot) {
  $list = New-Object System.Collections.Generic.List[object]
  $fixed = @(
    "LICENSE",
    "NOTICE",
    "README.md",
    "INDEX.md",
    "INSTALL.md",
    "WORKMODES.md",
    "AGENTS.md",
    "rules\author.md",
    "rules\global.md",
    "templates\WORKMODE.md",
    "ATTRIBUTION.public.xml",
    "GITHUB_ENTITLEMENT.json",
    ".gitattributes",
    "scripts\verify-official-upstream.ps1",
    "scripts\check-github-entitlement.ps1",
    "scripts\verify-attribution.ps1",
    "scripts\_attribution-crypto.ps1",
    "scripts\install.ps1",
    "scripts\install.sh",
    "scripts\stamp-attribution.ps1",
    "scripts\generate-attribution-seal.ps1",
    "scripts\generate-attribution-keys.ps1",
    "scripts\install-mcp.ps1",
    "mcp\README.md",
    "mcp\CATALOG.md"
  )
  foreach ($rel in $fixed) {
    $p = Join-Path $CatalogRoot $rel
    if (Test-Path -LiteralPath $p) {
      $list.Add([pscustomobject]@{ Rel = ($rel -replace '\\', '/'); Path = $p })
    }
  }
  foreach ($rootName in @("skills", "teams")) {
    $dir = Join-Path $CatalogRoot $rootName
    if (-not (Test-Path $dir)) { continue }
    Get-ChildItem $dir -Recurse -Filter SKILL.md -File | ForEach-Object {
      $rel = $_.FullName.Substring($CatalogRoot.Length).TrimStart('\', '/').Replace('\', '/')
      $list.Add([pscustomobject]@{ Rel = $rel; Path = $_.FullName })
    }
  }
  $mcpDir = Join-Path $CatalogRoot "mcp"
  if (Test-Path $mcpDir) {
    Get-ChildItem $mcpDir -Recurse -File | Where-Object {
      ($_.Name -in @('package.json','README.md','CATALOG.md','cursor.mcp.fragment.json','cursor.mcp.fragment.node.json','server.js')) -or
      (($_.Extension -eq '.py') -and ($_.DirectoryName -match '[\\/]addon$'))
    } | ForEach-Object {
      $rel = $_.FullName.Substring($CatalogRoot.Length).TrimStart('\', '/').Replace('\', '/')
      $list.Add([pscustomobject]@{ Rel = $rel; Path = $_.FullName })
    }
  }
  $seen = @{}
  $unique = New-Object System.Collections.Generic.List[object]
  foreach ($e in $list) {
    if ($seen.ContainsKey($e.Rel)) { continue }
    $seen[$e.Rel] = $true
    $unique.Add($e)
  }
  return $unique
}

function New-AttributionRsa {
  # Prefer RSACng / RSA.Create when available; fallback CSP for Windows PowerShell 5.1
  try {
    return [System.Security.Cryptography.RSA]::Create(3072)
  } catch {
    $csp = New-Object System.Security.Cryptography.CspParameters
    $csp.KeyContainerName = "AIAgentsRogueAttributionTemp"
    $csp.Flags = [System.Security.Cryptography.CspProviderFlags]::UseMachineKeyStore
    $rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider(3072, $csp)
    $rsa.PersistKeyInCsp = $false
    return $rsa
  }
}

function Import-AttributionPublicKey([string]$CatalogRoot) {
  $xmlPath = Join-Path $CatalogRoot "ATTRIBUTION.public.xml"
  if (-not (Test-Path -LiteralPath $xmlPath)) { throw "ATTRIBUTION.public.xml missing" }
  $xml = [System.IO.File]::ReadAllText($xmlPath)
  $rsa = New-AttributionRsa
  $rsa.FromXmlString($xml)
  return $rsa
}

function Import-AttributionPrivateKey([string]$PrivateKeyPath) {
  if (-not (Test-Path -LiteralPath $PrivateKeyPath)) { throw "Private key not found: $PrivateKeyPath" }
  $xml = [System.IO.File]::ReadAllText($PrivateKeyPath)
  $rsa = New-AttributionRsa
  $rsa.FromXmlString($xml)
  return $rsa
}

function Write-SignedAttributionSeal([string]$PlainJson, [string]$OutFile, [string]$PrivateKeyPath) {
  $rsa = Import-AttributionPrivateKey -PrivateKeyPath $PrivateKeyPath
  try {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($PlainJson)
    if ($rsa -is [System.Security.Cryptography.RSACryptoServiceProvider]) {
      $sha = [System.Security.Cryptography.SHA256]::Create()
      try {
        $hash = $sha.ComputeHash($bytes)
        $sig = $rsa.SignHash($hash, [System.Security.Cryptography.CryptoConfig]::MapNameToOID("SHA256"))
      } finally { $sha.Dispose() }
    } else {
      $sig = $rsa.SignData($bytes, [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)
    }
    $payloadB64 = [Convert]::ToBase64String($bytes)
    $sigB64 = [Convert]::ToBase64String($sig)
    $out = @(
      "# AI Agents Rogue ATTRIBUTION.seal - RSA-SHA256 signed integrity payload"
      "# Author: Rogue Development | https://github.com/rogue-dev-studio"
      "# Public verify key: ATTRIBUTION.public.xml"
      "# Private key is NOT distributed. Unsigned/re-signed forks are unofficial."
      "AAR2.$payloadB64"
      "SIG2.$sigB64"
    ) -join "`n"
    [System.IO.File]::WriteAllText($OutFile, $out + "`n")
  } finally { $rsa.Dispose() }
}

function Read-VerifiedAttributionSeal([string]$SealFile, [string]$CatalogRoot) {
  if (-not (Test-Path -LiteralPath $SealFile)) { throw "ATTRIBUTION.seal missing" }
  $raw = [System.IO.File]::ReadAllText($SealFile)
  $lines = $raw -split "`n" | ForEach-Object { $_.Trim() }
  $payloadLine = $lines | Where-Object { $_.StartsWith("AAR2.") } | Select-Object -First 1
  $sigLine = $lines | Where-Object { $_.StartsWith("SIG2.") } | Select-Object -First 1
  if (-not $payloadLine -or -not $sigLine) {
    throw "ATTRIBUTION.seal invalid (need AAR2 + SIG2 RSA signature). Re-seal with official private key."
  }
  $payload = [Convert]::FromBase64String($payloadLine.Substring(5))
  $sig = [Convert]::FromBase64String($sigLine.Substring(5))
  $rsa = Import-AttributionPublicKey -CatalogRoot $CatalogRoot
  try {
    if ($rsa -is [System.Security.Cryptography.RSACryptoServiceProvider]) {
      $sha = [System.Security.Cryptography.SHA256]::Create()
      try {
        $hash = $sha.ComputeHash($payload)
        $ok = $rsa.VerifyHash($hash, [System.Security.Cryptography.CryptoConfig]::MapNameToOID("SHA256"), $sig)
      } finally { $sha.Dispose() }
    } else {
      $ok = $rsa.VerifyData($payload, $sig, [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)
    }
    if (-not $ok) { throw "ATTRIBUTION.seal signature INVALID (tampered or unofficial re-seal)" }
  } finally { $rsa.Dispose() }
  return [System.Text.Encoding]::UTF8.GetString($payload)
}

function Test-AttributionMarkers([string]$CatalogRoot) {
  $failed = New-Object System.Collections.Generic.List[string]
  $checks = @(
    @{ Rel = "LICENSE"; Needle = "Rogue Development" },
    @{ Rel = "NOTICE"; Needle = "github.com/rogue-dev-studio" },
    @{ Rel = "README.md"; Needle = "github.com/rogue-dev-studio" },
    @{ Rel = "INSTALL.md"; Needle = "Star + Fork" },
    @{ Rel = "INSTALL.md"; Needle = "install.ps1" },
    @{ Rel = "WORKMODES.md"; Needle = "manual" },
    @{ Rel = "WORKMODES.md"; Needle = "e2e" },
    @{ Rel = "AGENTS.md"; Needle = "Rogue Development" },
    @{ Rel = "rules\global.md"; Needle = "WORKMODE.md" },
    @{ Rel = "rules\author.md"; Needle = "Rogue Development" },
    @{ Rel = "rules\author.md"; Needle = "verify-attribution.ps1" },
    @{ Rel = "rules\author.md"; Needle = "verify-official-upstream.ps1" },
    @{ Rel = "rules\author.md"; Needle = "check-github-entitlement.ps1" },
    @{ Rel = "rules\author.md"; Needle = "STOP" },
    @{ Rel = "ATTRIBUTION.public.xml"; Needle = "<RSAKeyValue>" },
    @{ Rel = "ATTRIBUTION.seal"; Needle = "SIG2." },
    @{ Rel = "scripts\verify-official-upstream.ps1"; Needle = "OfficialPublicKeySha256" },
    @{ Rel = "scripts\install.ps1"; Needle = "Assert-OfficialUpstream" },
    @{ Rel = "GITHUB_ENTITLEMENT.json"; Needle = "requireFork" },
    @{ Rel = "scripts\check-github-entitlement.ps1"; Needle = "GITHUB ENTITLEMENT FAILED" },
    @{ Rel = "scripts\install.ps1"; Needle = "Assert-GitHubEntitlement" },
    @{ Rel = "scripts\verify-attribution.ps1"; Needle = "AI MUST STOP" },
    @{ Rel = "scripts\install.ps1"; Needle = "verify-attribution.ps1" },
    @{ Rel = "scripts\install.ps1"; Needle = "install-mcp.ps1" },
    @{ Rel = "mcp\CATALOG.md"; Needle = "blender" },
    @{ Rel = "mcp\blender\package.json"; Needle = "blender" },
    @{ Rel = "skills\e2e-delivery\SKILL.md"; Needle = "Gate 0" }
  )
  foreach ($c in $checks) {
    $p = Join-Path $CatalogRoot $c.Rel
    if (-not (Test-Path -LiteralPath $p)) { $failed.Add("missing: $($c.Rel)"); continue }
    $t = [System.IO.File]::ReadAllText($p)
    if ($t.IndexOf($c.Needle, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
      $failed.Add("required instruction/marker missing (removed/bypassed?): $($c.Rel) :: $($c.Needle)")
    }
  }
  $skillFiles = @()
  foreach ($rootName in @("skills", "teams")) {
    $dir = Join-Path $CatalogRoot $rootName
    if (Test-Path $dir) {
      $skillFiles += Get-ChildItem $dir -Recurse -Filter SKILL.md -File
    }
  }
  foreach ($sf in $skillFiles) {
    $t = [System.IO.File]::ReadAllText($sf.FullName)
    if ($t.IndexOf($script:AttributionMarker, [StringComparison]::Ordinal) -lt 0) {
      $rel = $sf.FullName.Substring($CatalogRoot.Length).TrimStart('\', '/')
      $failed.Add("skill marker missing: $rel")
    }
    if ($t -notmatch '(?m)^## Attribution\s*$') {
      $rel = $sf.FullName.Substring($CatalogRoot.Length).TrimStart('\', '/')
      $failed.Add("skill ## Attribution missing: $rel")
    }
  }
  return @{ Failed = $failed; SkillCount = $skillFiles.Count }
}
