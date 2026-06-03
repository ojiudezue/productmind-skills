#!/usr/bin/env bash
# Validates all skills in the skills/ directory
# Checks: SKILL.md exists, has required sections, follows naming conventions
#
# Shared contract with BuildingRocketships' TS validator at
# BuildingRocketships/scripts/validate-skills.ts. Both must enforce:
#   1. YAML frontmatter with `name:` and `description:` keys
#   2. An H1 title (# Heading)
#   3. Substantive content (>= 10 lines)
# Drift between the two = portable-skill import failures. If you change the
# contract here, mirror it in BR. See ADR 0004 (dual distribution) and B1.5 in
# BuildingRocketships/docs/strategy/skills-and-agent-plan-v2.md.

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

    # Frontmatter contract (must match BR's TS validator)
    if head -20 "$skill_file" | grep -q "^name:"; then
        log_pass "Frontmatter has name:"
    else
        log_fail "Frontmatter missing required 'name:' key (BR contract)"
    fi

    if head -20 "$skill_file" | grep -q "^description:"; then
        log_pass "Frontmatter has description:"
    else
        log_fail "Frontmatter missing required 'description:' key (BR contract)"
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
