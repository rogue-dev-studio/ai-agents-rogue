# Copilot Setup Guide

This guide explains how to set up AI Agents Rogue with GitHub Copilot.

## Prerequisites

- GitHub Copilot enabled in your IDE
- PowerShell 7+ (for setup scripts)
- Git

## Installation

### Quick Install

Run the following command from your project root:

```powershell
.\scripts\install.ps1 -Hosts copilot
```

This will install AI Agents Rogue for Copilot only.

### Full Install

To install for all supported hosts:

```powershell
.\scripts\install.ps1 -Hosts all
```

## What Gets Installed

The Copilot adapter installs:

- **Skills** (`\.copilot\skills\`) - All catalog skills for Copilot
- **Commands** (`\.copilot\commands\`) - Supported commands like `/start-feature`
- **Roles** (`\.copilot\agents\roles\`) - AI agent role definitions

## Configuration

Copilot reads AI Agents Rogue configuration from:

- Root `AGENTS.md` - Main agent instructions
- `GPT.md` - Copilot-specific adapter pointer (auto-generated)
- `WORKMODE.md` - Work mode (e2e/manual)
- `LANGMODE.md` - Chat language preference

## Usage

### Starting a Feature

Use the `/start-feature` command to begin a new feature with full E2E delivery:

```
/start-feature
```

### Manual Mode

For plan-only mode, use `/assist`:

```
/assist
```

### Setting Work Mode

To set persistent work mode:

```
/set-mode e2e
# or
/set-mode manual
```

## Troubleshooting

### Skills Not Loading

If skills aren't loading in Copilot:

1. Run `.\scripts\install.ps1 -Hosts copilot` again
2. Check `.copilot\skills\` contains SKILL.md files
3. Restart Copilot

### Attribution Errors

If you see attribution errors:

```powershell
.\scripts\verify-attribution.ps1
```

### Reset Installation

To reset and reinstall:

```powershell
Remove-Item -Recurse -Force .copilot
.\scripts\install.ps1 -Hosts copilot
```

## Advanced Setup

### Custom Skills

To add custom skills:

1. Create `skills\<skillname>\SKILL.md`
2. Run `.\scripts\install.ps1 -Hosts copilot`

### Team-Specific Skills

For team-specific skills:

1. Create `teams\<teamid>\TEAM.yaml`
2. List skills under `skills:` section
3. Install with `-Team <teamid>`

## Related Scripts

- `scripts\install.ps1` - Main installation script
- `scripts\Copy-CopilotSkill.ps1` - Copy individual skills
- `scripts\setup-copilot.ps1` - Setup Copilot adapter
- `scripts\verify-attribution.ps1` - Verify authorship
- `scripts\auto-populate-ignore-revs.ps1` - Ignore AI-generated files

## See Also

- [AGENTS.md](../AGENTS.md) - AI Agents Rogue overview
- [INSTALL.md](../INSTALL.md) - Full installation guide
- [WORKMODES.md](../WORKMODES.md) - Work modes documentation
