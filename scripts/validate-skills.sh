#!/usr/bin/env bash
# Validates all skills in the skills/ directory
# Checks: SKILL.md exists, has required sections, follows naming conventions

set -euo pipefail

SKILLS_DIR="skills"
ERRORS=0
CHECKED=0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_pass() { echo -e "  ${GREEN}✓${NC} $1"; }
log_fail() { echo -e "  ${RED}✗${NC} $1"; ERRORS=$((ERRORS + 1)); }
log_warn() { echo -e "  ${YELLOW}!${NC} $1"; }

if [ ! -d "$SKILLS_DIR" ]; then
    echo "No skills/ directory found."
    exit 1
fi

for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue

    skill_name=$(basename "$skill_dir")
    CHECKED=$((CHECKED + 1))
    echo ""
    echo "Checking: $skill_name"

    # Check directory naming (lowercase-kebab-case)
    if [[ "$skill_name" =~ ^[a-z][a-z0-9-]*$ ]]; then
        log_pass "Directory name is kebab-case"
    else
        log_fail "Directory name must be lowercase-kebab-case: $skill_name"
    fi

    # Check SKILL.md exists
    skill_file="$skill_dir/SKILL.md"
    if [ -f "$skill_file" ]; then
        log_pass "SKILL.md exists"
    else
        log_fail "Missing SKILL.md"
        continue
    fi

    # Check required sections
    if grep -q "^#" "$skill_file"; then
        log_pass "Has a title heading"
    else
        log_fail "Missing title heading (# Title)"
    fi

    # Check file is not empty / too short
    line_count=$(wc -l < "$skill_file" | tr -d ' ')
    if [ "$line_count" -ge 10 ]; then
        log_pass "Skill has substantive content ($line_count lines)"
    else
        log_fail "Skill is too short ($line_count lines) — likely incomplete"
    fi

    # Check for product-engineering blend signals
    has_product_signal=false
    for keyword in "product" "user" "problem" "value" "outcome" "viability" "market" "brief"; do
        if grep -qi "$keyword" "$skill_file"; then
            has_product_signal=true
            break
        fi
    done

    if $has_product_signal; then
        log_pass "Contains product-thinking signals"
    else
        log_warn "No product-thinking keywords found — verify this skill blends product + engineering"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checked: $CHECKED skills"
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}All checks passed.${NC}"
    exit 0
else
    echo -e "${RED}$ERRORS error(s) found.${NC}"
    exit 1
fi
