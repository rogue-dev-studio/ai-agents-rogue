#!/usr/bin/env bash
# Install AI Agents Rogue.
# Usage: ./install.sh [target_dir] [hosts] [team_id] [mcp]
# hosts: cursor,antigravity,claude,opencode,generic,all
# team_id: optional (only if you created teams/<id>/)
# mcp: optional none|blender|all (default none)
set -euo pipefail

TARGET="${1:-.}"
HOSTS="${2:-all}"
TEAM_ID="${3:-}"
MCP="${4:-none}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CATALOG_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_ROOT="$(cd "$TARGET" && pwd)"

assert_author_integrity() {
  if command -v powershell >/dev/null 2>&1; then
    powershell -NoProfile -ExecutionPolicy Bypass -File "$CATALOG_ROOT/scripts/verify-attribution.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    powershell -NoProfile -ExecutionPolicy Bypass -File "$CATALOG_ROOT/scripts/verify-official-upstream.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    powershell -NoProfile -ExecutionPolicy Bypass -File "$CATALOG_ROOT/scripts/check-github-entitlement.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    return
  fi
  if command -v pwsh >/dev/null 2>&1; then
    pwsh -NoProfile -File "$CATALOG_ROOT/scripts/verify-attribution.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    pwsh -NoProfile -File "$CATALOG_ROOT/scripts/verify-official-upstream.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    pwsh -NoProfile -File "$CATALOG_ROOT/scripts/check-github-entitlement.ps1" -CatalogRoot "$CATALOG_ROOT" || exit 1
    return
  fi
  echo "PowerShell required for attribution + upstream pin + entitlement checks." >&2
  exit 1
}

assert_author_integrity

SKILLS=(e2e-delivery clarity agentic-flow agentic-qe)
ROLE_PATHS=()
COMMANDS=(start-feature assist set-mode new-project)
LOCAL_SKILLS=()
TEAM_DIR=""

ensure_dir() { mkdir -p "$1"; }

copy_tree() {
  local src="$1" dst="$2"
  [[ -d "$src" ]] || return 0
  ensure_dir "$dst"
  cp -R "$src/." "$dst/"
}

load_team() {
  local id="$1"
  TEAM_DIR="$CATALOG_ROOT/teams/$id"
  local yaml="$TEAM_DIR/TEAM.yaml"
  [[ -f "$yaml" ]] || { echo "Team '$id' not found: $yaml" >&2; exit 1; }

  SKILLS=()
  ROLE_PATHS=()
  COMMANDS=()
  LOCAL_SKILLS=()
  local section=""
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    if [[ "$line" =~ ^(skills|roles|commands|local_skills)[[:space:]]*: ]]; then
      section="${BASH_REMATCH[1]}"
      [[ "$line" =~ \[\s*\] ]] && section=""
      continue
    fi
    if [[ "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*: ]]; then
      section=""
      continue
    fi
    if [[ -n "$section" && "$line" =~ ^[[:space:]]*-[[:space:]]+([^[:space:]]+) ]]; then
      local val="${BASH_REMATCH[1]}"
      case "$section" in
        skills) SKILLS+=("$val") ;;
        roles) ROLE_PATHS+=("$val") ;;
        commands) COMMANDS+=("$val") ;;
        local_skills) LOCAL_SKILLS+=("$val") ;;
      esac
    fi
  done < "$yaml"

  echo "Team:    $id"
  echo "Skills:  ${SKILLS[*]}"
  echo "Roles:   ${#ROLE_PATHS[@]} selected"
}

copy_skills() {
  local dest="$1"
  ensure_dir "$dest"
  local name
  for name in "${SKILLS[@]}"; do
    ensure_dir "$dest/$name"
    cp "$CATALOG_ROOT/skills/$name/SKILL.md" "$dest/$name/SKILL.md"
  done
  if [[ -n "$TEAM_DIR" ]]; then
    for name in "${LOCAL_SKILLS[@]+"${LOCAL_SKILLS[@]}"}"; do
      [[ -z "${name:-}" ]] && continue
      ensure_dir "$dest/$name"
      cp "$TEAM_DIR/skills/$name/SKILL.md" "$dest/$name/SKILL.md"
    done
  fi
}

copy_commands() {
  local dest="$1"
  ensure_dir "$dest"
  local name
  for name in "${COMMANDS[@]}"; do
    [[ -f "$CATALOG_ROOT/commands/$name.md" ]] && cp "$CATALOG_ROOT/commands/$name.md" "$dest/$name.md"
  done
}

copy_roles() {
  local dest="$1"
  ensure_dir "$dest"
  if [[ ${#ROLE_PATHS[@]} -eq 0 ]]; then
    copy_tree "$CATALOG_ROOT/roles" "$dest"
    return
  fi
  local rel
  for rel in "${ROLE_PATHS[@]}"; do
    local src="$CATALOG_ROOT/roles/${rel}.md"
    [[ -f "$src" ]] || { echo "Role missing: $rel" >&2; continue; }
    ensure_dir "$dest/$(dirname "$rel")"
    cp "$src" "$dest/${rel}.md"
  done
}

write_team_overlay() {
  [[ -n "$TEAM_ID" ]] || return 0
  local out="$TARGET_ROOT/ai-agents-rogue/active-team"
  ensure_dir "$out"
  cp "$TEAM_DIR/TEAM.yaml" "$out/TEAM.yaml"
  cp "$TEAM_DIR/TEAM.md" "$out/TEAM.md"
  [[ -f "$TEAM_DIR/context.md" ]] && cp "$TEAM_DIR/context.md" "$out/context.md"
  cat > "$TARGET_ROOT/TEAM.md" <<EOF
# Active Team: $TEAM_ID

1. Read \`ai-agents-rogue/active-team/TEAM.md\` and \`context.md\`
2. Use only skills/roles in \`TEAM.yaml\`
3. Default build: \`e2e-delivery\` if listed in the team manifest
EOF
  if [[ -f "$TARGET_ROOT/AGENTS.md" ]] && ! grep -q "Active Team:" "$TARGET_ROOT/AGENTS.md"; then
    local tmp
    tmp="$(mktemp)"
    {
      echo "> **Active Team:** \`$TEAM_ID\` - see \`TEAM.md\` and \`ai-agents-rogue/active-team/\`."
      echo "> Load only skills/roles from that team's \`TEAM.yaml\`."
      echo
      cat "$TARGET_ROOT/AGENTS.md"
    } > "$tmp"
    mv "$tmp" "$TARGET_ROOT/AGENTS.md"
  fi
}

install_shared() {
  echo "  Catalog shared files..."
  cp "$CATALOG_ROOT/AGENTS.md" "$TARGET_ROOT/AGENTS.md"
  for f in LICENSE NOTICE README.md; do
    [[ -f "$CATALOG_ROOT/$f" ]] && cp "$CATALOG_ROOT/$f" "$TARGET_ROOT/$f"
  done
  local bundle="$TARGET_ROOT/ai-agents-rogue"
  if [[ "$(cd "$CATALOG_ROOT" && pwd)" == "$(mkdir -p "$bundle" && cd "$bundle" && pwd)" ]]; then
    echo "  Target already is the catalog bundle - skip full self-copy."
    write_team_overlay
    return
  fi
  copy_tree "$CATALOG_ROOT/core" "$bundle/core"
  copy_tree "$CATALOG_ROOT/templates" "$bundle/templates"
  copy_tree "$CATALOG_ROOT/rules" "$bundle/rules"
  copy_roles "$bundle/roles"
  ensure_dir "$bundle/skills"
  local name
  for name in "${SKILLS[@]}"; do
    copy_tree "$CATALOG_ROOT/skills/$name" "$bundle/skills/$name"
  done
  cp "$CATALOG_ROOT/README.md" "$bundle/README.md"
  cp "$CATALOG_ROOT/AGENTS.md" "$bundle/AGENTS.md"
  for f in LICENSE NOTICE; do
    [[ -f "$CATALOG_ROOT/$f" ]] && cp "$CATALOG_ROOT/$f" "$bundle/$f"
  done
  write_team_overlay
}

install_cursor() {
  echo "Installing Cursor adapter..."
  copy_skills "$TARGET_ROOT/.cursor/skills"
  copy_commands "$TARGET_ROOT/.cursor/commands"
  copy_roles "$TARGET_ROOT/.cursor/agents/roles"
  ensure_dir "$TARGET_ROOT/.cursor/rules"
  cat > "$TARGET_ROOT/.cursor/rules/ai-agents-rogue.mdc" <<EOF
---
description: AI Agents Rogue - E2E auto-execute (team-aware)
globs:
alwaysApply: true
---

# AI Agents Rogue

Follow root \`AGENTS.md\`. Active team: ${TEAM_ID:-none}.
Skills: ${SKILLS[*]}.
Commands: \`/start-feature\`, \`/assist\`, \`/set-mode\`, \`/new-project\`.
EOF
}

install_antigravity() {
  echo "Installing Antigravity adapter..."
  copy_skills "$TARGET_ROOT/.agents/skills"
  copy_commands "$TARGET_ROOT/.agents/commands"
  copy_roles "$TARGET_ROOT/.agents/roles"
}

install_claude() {
  echo "Installing Claude Code adapter..."
  copy_skills "$TARGET_ROOT/.claude/skills"
  copy_commands "$TARGET_ROOT/.claude/commands"
  copy_roles "$TARGET_ROOT/.claude/agents/roles"
}

install_opencode() {
  echo "Installing OpenCode adapter..."
  copy_skills "$TARGET_ROOT/.opencode/skills"
  copy_commands "$TARGET_ROOT/.opencode/commands"
  copy_roles "$TARGET_ROOT/.opencode/agents/roles"
}

install_generic() {
  echo "Installing generic .agents adapter..."
  copy_skills "$TARGET_ROOT/.agents/skills"
  copy_commands "$TARGET_ROOT/.agents/commands"
  copy_roles "$TARGET_ROOT/.agents/roles"
}

[[ -n "$TEAM_ID" ]] && load_team "$TEAM_ID"

echo "Catalog: $CATALOG_ROOT"
echo "Target:  $TARGET_ROOT"
echo "Hosts:   $HOSTS"

if [[ ! -f "$TARGET_ROOT/WORKMODE.md" && -f "$CATALOG_ROOT/templates/WORKMODE.md" ]]; then
  cp "$CATALOG_ROOT/templates/WORKMODE.md" "$TARGET_ROOT/WORKMODE.md"
  echo "Created WORKMODE.md (default: e2e)"
fi

install_shared

IFS=',' read -ra REQ <<< "$HOSTS"
if [[ "$HOSTS" == "all" ]]; then
  REQ=(cursor antigravity claude opencode generic)
fi

for h in "${REQ[@]}"; do
  h="$(echo "$h" | tr '[:upper:]' '[:lower:]' | xargs)"
  case "$h" in
    cursor) install_cursor ;;
    antigravity) install_antigravity ;;
    claude) install_claude ;;
    opencode) install_opencode ;;
    generic) install_generic ;;
    *) echo "Unknown host '$h' - skip" >&2 ;;
  esac
done

if [[ -n "${MCP}" && "${MCP}" != "none" ]]; then
  MCP_HOSTS="$HOSTS"
  if [[ "$HOSTS" == "all" ]]; then
    MCP_HOSTS="cursor,antigravity,claude,opencode,generic"
  fi
  if command -v pwsh >/dev/null 2>&1; then
    pwsh -NoProfile -File "$CATALOG_ROOT/scripts/install-mcp.ps1" -Target "$TARGET_ROOT" -Mcp "$MCP" -Hosts "$MCP_HOSTS" -CatalogRoot "$CATALOG_ROOT" -SkipGates || exit 1
  elif command -v powershell >/dev/null 2>&1; then
    powershell -NoProfile -ExecutionPolicy Bypass -File "$CATALOG_ROOT/scripts/install-mcp.ps1" -Target "$TARGET_ROOT" -Mcp "$MCP" -Hosts "$MCP_HOSTS" -CatalogRoot "$CATALOG_ROOT" -SkipGates || exit 1
  else
    echo "PowerShell required for MCP install" >&2
    exit 1
  fi
fi

echo "Done."
