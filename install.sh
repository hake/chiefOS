#!/usr/bin/env bash
set -euo pipefail

# chiefOS installer
# Usage: ./install.sh [target-directory]
# Example: ./install.sh ~/chiefOS

VERSION="0.2.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- helpers ----------

info()  { printf "\033[1;34m→\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m✓\033[0m %s\n" "$1"; }
warn()  { printf "\033[1;33m!\033[0m %s\n" "$1"; }
fail()  { printf "\033[1;31m✗\033[0m %s\n" "$1" >&2; exit 1; }

# ---------- detect platform ----------

PLATFORM="claude-code"
if [[ -d "$HOME/.claude/projects" ]] && [[ -f "$HOME/.claude/claude_desktop_config.json" || -d "/tmp/claude-desktop" ]]; then
  PLATFORM="cowork"
fi

# ---------- resolve target ----------

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
  echo ""
  echo "  chiefOS installer v${VERSION}"
  echo ""
  echo "  Usage: $0 <target-directory>"
  echo ""
  echo "  Examples:"
  echo "    $0 ~/chiefOS"
  echo "    $0 /path/to/my-chief-of-staff"
  echo ""
  exit 1
fi

# Expand ~ if present
TARGET="${TARGET/#\~/$HOME}"
TARGET="$(cd "$(dirname "$TARGET")" 2>/dev/null && pwd)/$(basename "$TARGET")" || TARGET="$TARGET"

echo ""
echo "  ┌─────────────────────────────────────┐"
echo "  │  chiefOS installer v${VERSION}          │"
echo "  │  AI Chief of Staff for any manager  │"
echo "  └─────────────────────────────────────┘"
echo ""

# ---------- check source ----------

if [[ ! -d "$SCRIPT_DIR/core" ]]; then
  fail "Cannot find chiefOS source files. Run this script from the chiefOS repo root."
fi

# ---------- create or update ----------

if [[ -d "$TARGET" && -f "$TARGET/.chiefos-version" ]]; then
  EXISTING_VERSION="$(cat "$TARGET/.chiefos-version")"
  warn "Existing chiefOS installation found (v${EXISTING_VERSION})."
  info "Updating framework files (your config/ and memory/ are preserved)."
  MODE="update"
else
  info "Installing chiefOS to: $TARGET"
  mkdir -p "$TARGET"
  MODE="install"
fi

# ---------- copy framework files ----------

# Plugin manifest (always overwritten)
info "Copying plugin manifest..."
mkdir -p "$TARGET/.claude-plugin"
cp "$SCRIPT_DIR/.claude-plugin/plugin.json" "$TARGET/.claude-plugin/plugin.json"
ok ".claude-plugin/plugin.json installed"

# Core modules (always overwritten)
info "Copying core/ framework modules..."
rm -rf "$TARGET/core"
cp -R "$SCRIPT_DIR/core" "$TARGET/core"
ok "core/ installed"

# Sub-agents (always overwritten)
info "Copying agents/..."
rm -rf "$TARGET/agents"
cp -R "$SCRIPT_DIR/agents" "$TARGET/agents"
ok "agents/ installed ($(ls "$TARGET/agents/"*.md | wc -l | tr -d ' ') agents)"

# Skills (always overwritten)
info "Copying skills/..."
rm -rf "$TARGET/skills"
cp -R "$SCRIPT_DIR/skills" "$TARGET/skills"
SKILL_COUNT="$(find "$TARGET/skills" -name "SKILL.md" | wc -l | tr -d ' ')"
ok "skills/ installed (${SKILL_COUNT} skills)"

# Templates (always overwritten)
info "Copying templates/..."
rm -rf "$TARGET/templates"
cp -R "$SCRIPT_DIR/templates" "$TARGET/templates"
ok "templates/ installed"

# Memory templates (always overwritten)
info "Copying memory-templates/..."
rm -rf "$TARGET/memory-templates"
cp -R "$SCRIPT_DIR/memory-templates" "$TARGET/memory-templates"
ok "memory-templates/ installed"

# ---------- user data (only on fresh install) ----------

if [[ "$MODE" == "install" ]]; then
  # Config directory with example and template files
  info "Creating config/ with example files..."
  mkdir -p "$TARGET/config"
  for example in "$SCRIPT_DIR/config/"*.example.md; do
    if [[ -f "$example" ]]; then
      cp "$example" "$TARGET/config/"
    fi
  done
  for template in "$SCRIPT_DIR/config/"*.template.md; do
    if [[ -f "$template" ]]; then
      cp "$template" "$TARGET/config/"
    fi
  done
  ok "config/ created with example and template files"

  # Empty memory directory
  info "Creating memory/ directory..."
  mkdir -p "$TARGET/memory"
  ok "memory/ created (will be seeded by /setup)"

  # .gitignore
  info "Creating .gitignore..."
  cat > "$TARGET/.gitignore" << 'GITIGNORE'
# User-specific — do not distribute
config/profile.md
config/team.md
config/domain.md
config/integrations.md
memory/*.md
CLAUDE.md

# Keep example configs
!config/*.example.md

# OS files
.DS_Store
GITIGNORE
  ok ".gitignore created"

else
  # Update mode — preserve user data
  info "Preserving config/, memory/, and CLAUDE.md (user data)"
fi

# ---------- version stamp ----------

echo "$VERSION" > "$TARGET/.chiefos-version"

# ---------- README ----------

info "Copying README.md..."
cp "$SCRIPT_DIR/README.md" "$TARGET/README.md"
ok "README.md installed"

# ---------- done ----------

echo ""
echo "  ┌─────────────────────────────────────┐"
if [[ "$MODE" == "install" ]]; then
  echo "  │  Installation complete!             │"
  echo "  └─────────────────────────────────────┘"
  echo ""
  if [[ "$PLATFORM" == "cowork" ]]; then
    echo "  Detected: Claude Cowork"
    echo ""
    echo "  Next steps:"
    echo ""
    echo "    1. Fill in your config files:"
    echo "       cp config/profile.template.md config/profile.md"
    echo "       cp config/team.template.md config/team.md"
    echo "       cp config/domain.template.md config/domain.md"
    echo "       cp config/integrations.template.md config/integrations.md"
    echo ""
    echo "    2. Edit each config file with your details"
    echo ""
    echo "    3. Run: /setup auto"
    echo ""
  else
    echo "  Next steps:"
    echo ""
    echo "    cd $TARGET"
    echo "    # Open Claude Code in this directory"
    echo "    /setup"
    echo ""
    echo "  The /setup wizard will ask about your"
    echo "  team, role, and tools — then generate"
    echo "  your personalised CLAUDE.md."
  fi
else
  echo "  │  Update complete! (v${VERSION})        │"
  echo "  └─────────────────────────────────────┘"
  echo ""
  echo "  Your config/ and memory/ were preserved."
  echo "  Run /setup regenerate to rebuild CLAUDE.md"
  echo "  with the updated framework."
fi
echo ""
