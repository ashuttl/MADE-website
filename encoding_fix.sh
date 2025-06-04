#!/bin/bash

# Simple bash-based encoding fix for Cloudflare Pages
echo "🔧 Fixing file encodings for CF Pages build..."

# Set locale
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# Find and fix markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./node_modules/*" -not -path "./.git/*" | while read -r file; do
    if [ -f "$file" ]; then
        # Remove null bytes and other problematic characters
        sed -i.bak 's/\x00//g' "$file" 2>/dev/null || true
        sed -i.bak 's/\x01//g' "$file" 2>/dev/null || true
        sed -i.bak 's/\x02//g' "$file" 2>/dev/null || true
        sed -i.bak 's/\x03//g' "$file" 2>/dev/null || true
        sed -i.bak 's/\x04//g' "$file" 2>/dev/null || true
        sed -i.bak 's/\x05//g' "$file" 2>/dev/null || true
        
        # Clean up backup files
        rm -f "${file}.bak" 2>/dev/null || true
        
        # Ensure UTF-8 encoding if iconv is available
        if command -v iconv >/dev/null 2>&1; then
            iconv -f UTF-8 -t UTF-8//IGNORE "$file" > "${file}.tmp" 2>/dev/null && mv "${file}.tmp" "$file" || rm -f "${file}.tmp"
        fi
    fi
done

echo "✅ Encoding fix complete!"