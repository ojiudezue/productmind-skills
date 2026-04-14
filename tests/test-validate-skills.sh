#!/usr/bin/env bash
# Integration tests for the skill validation script
# Verifies that validate-skills.sh correctly catches common issues

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VALIDATE="$PROJECT_DIR/scripts/validate-skills.sh"
TEST_DIR=$(mktemp -d)

trap 'rm -rf "$TEST_DIR"' EXIT

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

PASS=0
FAIL=0

assert_pass() {
    local test_name="$1"
    if (cd "$TEST_DIR" && bash "$VALIDATE") &>/dev/null; then
        echo -e "${GREEN}✓${NC} $test_name"
        PASS=$((PASS + 1))
    else
        echo -e "${RED}✗${NC} $test_name (expected pass, got fail)"
        FAIL=$((FAIL + 1))
    fi
}

assert_fail() {
    local test_name="$1"
    if (cd "$TEST_DIR" && bash "$VALIDATE") &>/dev/null; then
        echo -e "${RED}✗${NC} $test_name (expected fail, got pass)"
        FAIL=$((FAIL + 1))
    else
        echo -e "${GREEN}✓${NC} $test_name"
        PASS=$((PASS + 1))
    fi
}

reset_test_dir() {
    rm -rf "$TEST_DIR/skills"
    mkdir -p "$TEST_DIR/skills"
}

echo "=== Skill Validation Tests ==="
echo ""

# Test 1: Valid skill passes
reset_test_dir
mkdir -p "$TEST_DIR/skills/valid-skill"
cat > "$TEST_DIR/skills/valid-skill/SKILL.md" << 'EOF'
# Valid Skill

This skill helps the user build better products by integrating
product thinking into the engineering workflow.

It validates that the problem is real, the user is defined,
and the value proposition is clear.

## Steps
1. Do the thing
2. Check the outcome
EOF
assert_pass "Valid skill passes validation"

# Test 2: Missing SKILL.md fails
reset_test_dir
mkdir -p "$TEST_DIR/skills/no-skill-file"
assert_fail "Missing SKILL.md is caught"

# Test 3: Non-kebab-case directory fails
reset_test_dir
mkdir -p "$TEST_DIR/skills/BadName"
cat > "$TEST_DIR/skills/BadName/SKILL.md" << 'EOF'
# Bad Name Skill
This skill helps the user understand product value.
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
EOF
assert_fail "Non-kebab-case directory name is caught"

# Test 4: Too-short skill fails
reset_test_dir
mkdir -p "$TEST_DIR/skills/short-skill"
cat > "$TEST_DIR/skills/short-skill/SKILL.md" << 'EOF'
# Short
Too brief.
EOF
assert_fail "Too-short skill is caught"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Passed: $PASS  Failed: $FAIL"
[ $FAIL -eq 0 ] && exit 0 || exit 1
