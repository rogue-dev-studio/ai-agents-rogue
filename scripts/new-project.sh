#!/usr/bin/env bash
# Usage: ./new-project.sh <id> [name] [team] [target_dir]
set -euo pipefail

ID="${1:-}"
NAME="${2:-}"
TEAM="${3:-none}"
TARGET="${4:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CATALOG_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

[[ -n "$ID" ]] || { echo "Usage: $0 <id> [name] [team] [target]" >&2; exit 1; }
[[ "$ID" =~ ^[a-z0-9]+([a-z0-9-]*[a-z0-9])?$ ]] || { echo "Invalid id" >&2; exit 1; }

if [[ -z "$TARGET" ]]; then
  PARENT="$(dirname "$CATALOG_ROOT")"
  if [[ -d "$PARENT/project" ]]; then TARGET="$PARENT"; else TARGET="$(pwd)"; fi
fi
TARGET_ROOT="$(cd "$TARGET" && pwd)"
TEMPLATE="$CATALOG_ROOT/project-template"
PROJECT_DIR="$TARGET_ROOT/project/$ID"
DATE="$(date +%F)"
[[ -n "$NAME" ]] || NAME="$ID"

[[ ! -e "$PROJECT_DIR" ]] || { echo "Exists: $PROJECT_DIR" >&2; exit 1; }

mkdir -p "$PROJECT_DIR"
cp -R "$TEMPLATE/." "$PROJECT_DIR/"

replace() {
  local f="$1"
  sed -i.bak \
    -e "s/__PROJECT_ID__/$ID/g" \
    -e "s/__PROJECT_NAME__/$NAME/g" \
    -e "s/__TEAM_ID__/$TEAM/g" \
    -e "s/__DATE__/$DATE/g" \
    "$f" && rm -f "$f.bak"
}

replace "$PROJECT_DIR/PROJECT.yaml"
replace "$PROJECT_DIR/README.md"

cp "$CATALOG_ROOT/templates/srs-template.md" "$PROJECT_DIR/docs/srs/_template.md" 2>/dev/null || true
cp "$CATALOG_ROOT/templates/planning-template.md" "$PROJECT_DIR/docs/planning/_template.md" 2>/dev/null || true
cp "$CATALOG_ROOT/templates/task-template.md" "$PROJECT_DIR/docs/tasks/_template.md" 2>/dev/null || true

cat > "$TARGET_ROOT/PROJECT.md" <<EOF
# Active Project: $ID

- Path: \`project/$ID/\`
- Name: $NAME
- Team: $TEAM
- Docs: \`project/$ID/docs/\`

AI harus menulis dokumentasi pengembangan ke folder docs project ini.
EOF

echo "Created: $PROJECT_DIR"
echo "Active:  $TARGET_ROOT/PROJECT.md"
