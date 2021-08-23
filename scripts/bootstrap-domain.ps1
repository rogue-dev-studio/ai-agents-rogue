<#
.SYNOPSIS
  Prompt-first domain bootstrap: sync pack skills/roles/rules to host without install -Team.
.PARAMETER Domain
  Pack id: simrs, hr, or custom teams/<id>.
.PARAMETER Prompt
  Optional user text - infer Domain if -Domain omitted (simrs / hr keywords).
.PARAMETER Target
  Repo root (default: parent of ai-agents-rogue if project/ exists, else cwd).
.PARAMETER SkillHosts
  cursor, claude, agents, opencode, all (default all).
.PARAMETER ProjectId
  If set, run new-project.ps1 after bootstrap (skip if project exists).
.PARAMETER ProjectName
  Display name for new project.
.PARAMETER CreatePackIfMissing
  Scaffold teams/<id> from teams/_template when pack missing.
.PARAMETER Force
  Overwrite host skill/role/rule copies even when present.
.PARAMETER DryRun
  Report actions only.
#>
param(
  [string]$Domain = "",
  [string]$Prompt = "",
  [string]$Target = "",
  [string]$SkillHosts = "all",
  [string]$ProjectId = "",
  [string]$ProjectName = "",
  [switch]$CreatePackIfMissing,
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    if ($DryRun) { Write-Host "[dry-run] mkdir $Path" }
    else { New-Item -ItemType Directory -Path $Path -Force | Out-Null }
  }
}

function Resolve-TargetRoot {
  if ($Target) { return (Resolve-Path $Target).Path }
  $parent = Split-Path $CatalogRoot -Parent
  if (Test-Path (Join-Path $parent "project")) { return $parent }
  return (Get-Location).Path
}

function Get-DomainAliases {
  return @{
    simrs = @("simrs", "rumah-sakit", "rumah sakit", "hospital", "rekam medis", "rawat jalan", "rawat inap", "igd", "bpjs", "sep", "satusehat")
    hr    = @("hr", "cv", "resume", "recruitment", "onboarding", "karyawan", "people ops", "lamaran", "screening", "ats", "talent")
  }
}

function Infer-DomainFromPrompt([string]$Text) {
  if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
  $lower = $Text.ToLowerInvariant()
  $aliases = Get-DomainAliases
  $scores = @{}
  foreach ($id in $aliases.Keys) {
    $score = 0
    foreach ($kw in $aliases[$id]) {
      if ($lower.Contains($kw)) { $score++ }
    }
    if ($score -gt 0) { $scores[$id] = $score }
  }
  if ($scores.Count -eq 0) { return $null }
  return ($scores.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 1).Name
}

function Read-TeamLocalSkills([string]$TeamDir) {
  $yaml = Join-Path $TeamDir "TEAM.yaml"
  if (-not (Test-Path -LiteralPath $yaml)) { return @() }
  $skills = New-Object System.Collections.Generic.List[string]
  $inLocal = $false
  foreach ($line in Get-Content $yaml) {
    if ($line -match '^\s*#') { continue }
    if ($line -match '^local_skills\s*:') { $inLocal = $true; if ($line -match '\[\s*\]') { return @() }; continue }
    if ($inLocal -and $line -match '^[a-zA-Z_][a-zA-Z0-9_]*\s*:') { break }
    if ($inLocal -and $line -match '^\s*-\s+(\S+)') { [void]$skills.Add($Matches[1].Trim()) }
  }
  return $skills.ToArray()
}

function Get-RoleDestSubdir([string]$Id) {
  switch ($Id) {
    "hr" { return "people-ops" }
    "simrs" { return "clinical" }
    default { return $Id }
  }
}

function Get-RuleMap([string]$Id) {
  switch ($Id) {
    "hr" {
      return @(
        @{ Source = "people-data.md"; Dest = "hr-people-data.mdc"; Description = "HR people data, CV, recruitment, onboarding, leave, employee PII, screening bias" }
      )
    }
    "simrs" {
      return @(
        @{ Source = "patient-health-data.md"; Dest = "simrs-patient-health-data.mdc"; Description = "SIMRS patient health data, RM, NIK, diagnosa, resep, lab, billing identity, BPJS SEP, audit trail" }
        @{ Source = "hospital-regulatory-id.md"; Dest = "simrs-hospital-regulatory-id.mdc"; Description = "SIMRS Indonesian hospital regulations, UU Kesehatan, PDP, rekam medis, Permenkes, informed consent, BPJS, SATUSEHAT, SPO RS" }
        @{ Source = "data-mapping.md"; Dest = "simrs-data-mapping.mdc"; Description = "SIMRS map regulatory data elements to application tables, APIs, UI, PDP class, RBAC, audit" }
      )
    }
    default { return @() }
  }
}

function New-DomainPackFromTemplate([string]$Id, [string]$Name) {
  $src = Join-Path $CatalogRoot "teams\_template"
  $dst = Join-Path $CatalogRoot "teams\$Id"
  if (Test-Path -LiteralPath $dst) { return $dst }
  if (-not $CreatePackIfMissing) {
    throw "Pack teams/$Id not found. Re-run with -CreatePackIfMissing or create from teams/_template."
  }
  Write-Host "Scaffold pack: teams/$Id (from _template)"
  if ($DryRun) { return $dst }
  Copy-Item -Path $src -Destination $dst -Recurse -Force
  $teamMd = Join-Path $dst "TEAM.md"
  $text = Get-Content $teamMd -Raw -Encoding UTF8
  $text = $text.Replace("{{ID}}", $Id).Replace("{{NAME}}", $Name)
  Set-Content -Path $teamMd -Value $text -Encoding UTF8
  $yamlPath = Join-Path $dst "TEAM.yaml"
  $yaml = Get-Content $yamlPath -Raw -Encoding UTF8
  $yaml = $yaml -replace '(?m)^id:\s*.+$', "id: $Id"
  $yaml = $yaml -replace '(?m)^name:\s*.+$', "name: $Name"
  $yaml = $yaml -replace '(?m)^description:\s*.+$', "description: Pack lokal prompt-first ($Name)"
  Set-Content -Path $yamlPath -Value $yaml -Encoding UTF8
  $readme = "# Pack ``$Id`` (local) - prompt-first`n`nScaffold otomatis via bootstrap-domain.ps1. Lengkapi skill di skills/, rule di rules/, role di roles/.`n`nRouting runtime = deskripsi skill + prompt user. Jangan install.ps1 -Team $Id di full-catalog.`n"
  Set-Content -Path (Join-Path $dst "README.md") -Value $readme -Encoding UTF8
  return $dst
}

function Copy-SkillFolder([string]$SrcDir, [string]$DstDir) {
  if (-not (Test-Path -LiteralPath $SrcDir)) {
    Write-Warning "Skill source missing: $SrcDir"
    return $false
  }
  $skillFile = Join-Path $SrcDir "SKILL.md"
  if (-not (Test-Path -LiteralPath $skillFile)) {
    Write-Warning "No SKILL.md in $SrcDir"
    return $false
  }
  if ((Test-Path -LiteralPath $DstDir) -and -not $Force) {
    Write-Host "  skip skill (exists): $(Split-Path $DstDir -Leaf)"
    return $true
  }
  if ($DryRun) {
    Write-Host "[dry-run] copy skill $(Split-Path $DstDir -Leaf) -> $DstDir"
    return $true
  }
  Ensure-Dir (Split-Path $DstDir -Parent)
  if (Test-Path -LiteralPath $DstDir) { Remove-Item -LiteralPath $DstDir -Recurse -Force }
  Copy-Item -Path $SrcDir -Destination $DstDir -Recurse -Force
  Write-Host "  synced skill: $(Split-Path $DstDir -Leaf)"
  return $true
}

function Copy-RoleFile([string]$Src, [string]$Dst) {
  if (-not (Test-Path -LiteralPath $Src)) { return }
  if ((Test-Path -LiteralPath $Dst) -and -not $Force) {
    Write-Host "  skip role (exists): $(Split-Path $Dst -Leaf)"
    return
  }
  if ($DryRun) {
    Write-Host "[dry-run] copy role -> $Dst"
    return
  }
  Ensure-Dir (Split-Path $Dst -Parent)
  Copy-Item -Path $Src -Destination $Dst -Force
  Write-Host "  synced role: $(Split-Path $Dst -Leaf)"
}

function Write-RuleMdc([string]$RuleMd, [string]$DestMdc, [string]$Description, [string]$PackRel) {
  if ((Test-Path -LiteralPath $DestMdc) -and -not $Force) {
    Write-Host "  skip rule (exists): $(Split-Path $DestMdc -Leaf)"
    return
  }
  if (-not (Test-Path -LiteralPath $RuleMd)) {
    Write-Warning "Rule source missing: $RuleMd"
    return
  }
  $body = Get-Content $RuleMd -Raw -Encoding UTF8
  $body = $body -replace '(?m)^# .+\r?\n\r?\n', ''
  $mdc = ("---`n" + "description: {0}`n" + "alwaysApply: false`n" + "---`n`n" + "{1}`n`n" + "Sumber pack: ``{2}``.`n") -f $Description, $body.TrimEnd(), $PackRel
  if ($DryRun) {
    Write-Host "[dry-run] write rule $(Split-Path $DestMdc -Leaf)"
    return
  }
  Ensure-Dir (Split-Path $DestMdc -Parent)
  Set-Content -Path $DestMdc -Value $mdc -Encoding UTF8
  Write-Host "  synced rule: $(Split-Path $DestMdc -Leaf)"
}

function Get-HostSkillRoots([string]$TargetRoot, [string]$HostsArg) {
  $all = @{
    cursor  = Join-Path $TargetRoot ".cursor\skills"
    claude  = Join-Path $TargetRoot ".claude\skills"
    agents  = Join-Path $TargetRoot ".agents\skills"
    opencode = Join-Path $TargetRoot ".opencode\skills"
  }
  if ($HostsArg -eq "all") { return $all.Values }
  $list = New-Object System.Collections.Generic.List[string]
  foreach ($h in ($HostsArg -split '[,\s]+')) {
    $key = $h.Trim().ToLowerInvariant()
    if ($all.ContainsKey($key)) { [void]$list.Add($all[$key]) }
  }
  if ($list.Count -eq 0) { throw "No valid hosts in: $HostsArg" }
  return $list.ToArray()
}

function Write-ActiveDomainManifest([string]$TargetRoot, [string]$Id, [string]$TeamDir, [string[]]$Skills, [string]$Project) {
  $outDir = Join-Path $TargetRoot "ai-agents-rogue\active-domain"
  if ($DryRun) {
    Write-Host "[dry-run] write manifest ai-agents-rogue/active-domain/$Id.json"
    return
  }
  Ensure-Dir $outDir
  $manifest = @{
    domain       = $Id
    mode         = "prompt-first"
    packPath     = "ai-agents-rogue/teams/$Id"
    bootstrapped = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssK")
    skills       = $Skills
    projectId    = if ($Project) { $Project } else { $null }
    note         = "Full catalog remains available. Do not install.ps1 -Team on full-catalog workspace."
  }
  $jsonPath = Join-Path $outDir "$Id.json"
  $manifest | ConvertTo-Json -Depth 4 | Set-Content -Path $jsonPath -Encoding UTF8
  Write-Host "Manifest: $jsonPath"
}

# --- main ---

if (-not $Domain -and $Prompt) { $Domain = Infer-DomainFromPrompt $Prompt }
if (-not $Domain) {
  throw "Specify -Domain (simrs|hr|<id>) or -Prompt with domain keywords."
}
$Domain = $Domain.Trim().ToLowerInvariant()
$TargetRoot = Resolve-TargetRoot
$displayName = if ($Domain -eq "simrs") { "SIMRS / Hospital Operations" } elseif ($Domain -eq "hr") { "People Operations / HR" } else { $Domain }

$TeamDir = Join-Path $CatalogRoot "teams\$Domain"
if (-not (Test-Path -LiteralPath $TeamDir)) {
  $TeamDir = New-DomainPackFromTemplate -Id $Domain -Name $displayName
}

$localSkills = Read-TeamLocalSkills $TeamDir
if ($localSkills.Count -eq 0) {
  Write-Warning "Pack teams/$Domain has no local_skills in TEAM.yaml - only manifest/rules/roles will sync."
}

Write-Host "Bootstrap domain: $Domain"
Write-Host "Target:         $TargetRoot"
Write-Host "Pack:           $TeamDir"
Write-Host "Skills:         $($localSkills -join ', ')"

$skillRoots = Get-HostSkillRoots $TargetRoot $SkillHosts
foreach ($root in $skillRoots) {
  Write-Host "Host skills: $root"
  foreach ($name in $localSkills) {
    $src = Join-Path $TeamDir "skills\$name"
    $dst = Join-Path $root $name
    Copy-SkillFolder $src $dst | Out-Null
  }
}

$roleSub = Get-RoleDestSubdir $Domain
$rolesSrc = Join-Path $TeamDir "roles"
if (Test-Path -LiteralPath $rolesSrc) {
  Write-Host "Host roles: .cursor/agents/roles/$roleSub"
  $roleDstRoot = Join-Path $TargetRoot ".cursor\agents\roles\$roleSub"
  Get-ChildItem -Path $rolesSrc -Filter "*.md" | ForEach-Object {
    Copy-RoleFile $_.FullName (Join-Path $roleDstRoot $_.Name)
  }
}

$rulesSrc = Join-Path $TeamDir "rules"
$rulesDst = Join-Path $TargetRoot ".cursor\rules"
foreach ($map in (Get-RuleMap $Domain)) {
  $srcRule = Join-Path $rulesSrc $map.Source
  $dstRule = Join-Path $rulesDst $map.Dest
  $packRel = "ai-agents-rogue/teams/$Domain/rules/$($map.Source)"
  Write-RuleMdc $srcRule $dstRule $map.Description $packRel
}

Write-ActiveDomainManifest $TargetRoot $Domain $TeamDir $localSkills $ProjectId

if ($ProjectId) {
  $projDir = Join-Path $TargetRoot "project\$ProjectId"
  if (Test-Path -LiteralPath $projDir) {
    Write-Host "Project exists, skip new-project: $projDir"
  }
  elseif ($DryRun) {
    Write-Host "[dry-run] new-project.ps1 -Id $ProjectId"
  }
  else {
    $np = Join-Path $PSScriptRoot "new-project.ps1"
    $npArgs = @{
      Id     = $ProjectId
      Target = $TargetRoot
      Team   = $Domain
    }
    if ($ProjectName) { $npArgs.Name = $ProjectName }
    & $np @npArgs
  }
}

Write-Host ""
Write-Host "Done. Prompt-first - use skills from chat; no install -Team required."
Write-Host "Next: /start-feature (E2E) or continue prompt (e.g. review CV / design SIMRS module)."
if ($localSkills.Count -eq 0) {
  Write-Host "Gap: add skills under teams/$Domain/skills/ and list in TEAM.yaml local_skills, then re-run bootstrap."
}
