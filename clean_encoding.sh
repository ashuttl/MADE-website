#!/bin/bash

# Clean encoding issues in markdown files
echo "🧹 Cleaning encoding issues in markdown files..."

# Find all markdown files and clean them
find _winners -name "*.md" -type f | while read -r file; do
    echo "Cleaning: $file"
    # Remove null bytes and other binary characters, then ensure UTF-8
    sed -i '' 's/\x00//g' "$file" 2>/dev/null || true
    sed -i '' 's/\x01//g' "$file" 2>/dev/null || true
    sed -i '' 's/\x02//g' "$file" 2>/dev/null || true
    sed -i '' 's/\x03//g' "$file" 2>/dev/null || true
    sed -i '' 's/\x04//g' "$file" 2>/dev/null || true
    sed -i '' 's/\x05//g' "$file" 2>/dev/null || true
    
    # Convert to UTF-8 if needed
    if ! file "$file" | grep -q "UTF-8"; then
        iconv -f utf-8 -t utf-8 -c "$file" > "${file}.tmp" 2>/dev/null && mv "${file}.tmp" "$file" || rm -f "${file}.tmp"
    fi
done

echo "✅ Encoding cleanup complete!"