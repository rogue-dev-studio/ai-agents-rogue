<#
.SYNOPSIS
  Rejects assistant or bot attribution in public Git metadata.
#>
param(
  [string]$Repository = ".",
  [string]$Message = "",
  [string]$MessageFile = "",
  [string]$RevisionRange = ""
)

$ErrorActionPreference = "Stop"

$trailerPatterns = @(
  '(?im)^\s*co-authored-by\s*:\s*.*(?:ai|copilot|bot|assistant|agent|openai|anthropic|gemini|claude)',
  '(?im)^\s*(?:generated|assisted|authored|written|created|committed)-by\s*:',
  '(?im)^\s*(?:ai-generated-by|ai-assisted-by|assistant-by)\s*:',
  '(?im)^\s*signed-off-by\s*:\s*.*(?:ai|copilot|bot|assistant|agent|openai|anthropic|gemini|claude)'
)
$identityPattern = '(?i)(?:\bai\b|copilot|\[bot\]|\bbot\b|assistant|agent|openai|anthropic|gemini|claude)'

$inputs = New-Object System.Collections.Generic.List[object]
$identityRecords = New-Object System.Collections.Generic.List[object]

if ($Message) {
  $inputs.Add([pscustomobject]@{ Source = "message argument"; Text = $Message })
}

if ($MessageFile) {
  $resolvedMessageFile = (Resolve-Path -LiteralPath $MessageFile).Path
  $inputs.Add([pscustomobject]@{
    Source = $resolvedMessageFile
    Text = [System.IO.File]::ReadAllText($resolvedMessageFile)
  })
}

if ($RevisionRange) {
  $repositoryPath = (Resolve-Path -LiteralPath $Repository).Path
  $records = & git -C $repositoryPath log --format="%H%x1f%an%x1f%ae%x1f%cn%x1f%ce%x1f%B%x1e" $RevisionRange 2>&1
  if ($LASTEXITCODE -ne 0) {
    throw "Unable to read Git history for '$RevisionRange': $records"
  }
  $recordText = $records -join "`n"
  foreach ($record in ($recordText -split [char]0x1e)) {
    if ([string]::IsNullOrWhiteSpace($record)) { continue }
    $fields = $record.Trim() -split [char]0x1f, 6
    if ($fields.Count -lt 6) { continue }
    $identityRecords.Add([pscustomobject]@{
      Source = "commit $($fields[0])"
      Author = "$($fields[1]) <$($fields[2])>"
      Committer = "$($fields[3]) <$($fields[4])>"
    })
    $inputs.Add([pscustomobject]@{
      Source = "commit $($fields[0]) message"
      Text = $fields[5]
    })
  }
}

if ($inputs.Count -eq 0) {
  throw "Provide -Message, -MessageFile, or -RevisionRange."
}

$findings = New-Object System.Collections.Generic.List[string]
foreach ($inputItem in $inputs) {
  foreach ($pattern in $trailerPatterns) {
    foreach ($match in [regex]::Matches($inputItem.Text, $pattern)) {
      $findings.Add("$($inputItem.Source): $($match.Value.Trim())")
    }
  }
}
foreach ($identityRecord in $identityRecords) {
  if ($identityRecord.Author -match $identityPattern) {
    $findings.Add("$($identityRecord.Source) author: $($identityRecord.Author)")
  }
  if ($identityRecord.Committer -match $identityPattern) {
    $findings.Add("$($identityRecord.Source) committer: $($identityRecord.Committer)")
  }
}

if ($findings.Count -gt 0) {
  Write-Host "PUBLIC IDENTITY CHECK FAILED" -ForegroundColor Red
  $findings | Select-Object -Unique | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
  Write-Host "Remove assistant or bot attribution before publishing." -ForegroundColor Red
  exit 1
}

Write-Host "PUBLIC IDENTITY CHECK OK"
exit 0
