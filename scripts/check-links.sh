#!/usr/bin/env bash
# Checks for broken internal links in markdown files

set -euo pipefail

ERRORS=0
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "Checking internal links in markdown files..."

while IFS= read -r -d '' file; do
    # Extract markdown links: [text](path)
    while IFS= read -r link; do
        # Skip external links, anchors, empty links, and template paths
        [[ "$link" =~ ^https?:// ]] && continue
        [[ "$link" =~ ^# ]] && continue
        [[ -z "$link" ]] && continue
        # Skip template-variable paths like users/{username}/... — these are
        # documentation placeholders, not real file references.
        [[ "$link" =~ \{[^}]+\} ]] && continue
        # Skip mailto: and other URI schemes
        [[ "$link" =~ ^[a-z]+: ]] && continue

        # Strip anchor from link
        link_path="${link%%#*}"
        [[ -z "$link_path" ]] && continue

        # Resolve relative to the file's directory
        file_dir=$(dirname "$file")
        resolved="$file_dir/$link_path"

        if [ ! -e "$resolved" ]; then
            echo -e "${RED}✗${NC} Broken link in $file: $link"
            ERRORS=$((ERRORS + 1))
        fi
    done < <(grep -oP '\[.*?\]\(\K[^)]+' "$file" 2>/dev/null || true)
done < <(find . -name "*.md" -not -path "./.git/*" -print0)

echo ""
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}All internal links valid.${NC}"
    exit 0
else
    echo -e "${RED}$ERRORS broken link(s) found.${NC}"
    exit 1
fi
