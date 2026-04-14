#!/usr/bin/env bash
# Runs the full CI pipeline locally

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "=== ProductMind Skills CI ==="
echo ""

echo "Step 1: Lint markdown"
if command -v npx &>/dev/null; then
    npx markdownlint-cli2 "**/*.md" --config .markdownlint.json 2>/dev/null || echo "markdownlint not installed — run: npm install -g markdownlint-cli2"
else
    echo "npx not available — skipping markdown lint"
fi

echo ""
echo "Step 2: Validate skills"
bash "$SCRIPT_DIR/validate-skills.sh"

echo ""
echo "Step 3: Check links"
bash "$SCRIPT_DIR/check-links.sh"

echo ""
echo "=== CI Complete ==="
