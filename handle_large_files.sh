#!/bin/bash

# Handle large files for Cloudflare Pages deployment
# Cloudflare Pages has a 25 MiB file size limit

echo "🔍 Checking for files larger than 25MB..."

# Find files larger than 25MB
large_files=$(find _site -type f -size +25M 2>/dev/null)

if [ ! -z "$large_files" ]; then
    echo "⚠️  Found files larger than 25MB:"
    echo "$large_files" | while read -r file; do
        size=$(ls -lah "$file" | awk '{print $5}')
        echo "  - $file ($size)"
        
        # Create a placeholder file with link to external storage
        if [[ "$file" == *.pdf ]]; then
            # For PDFs, create a placeholder that redirects to external storage
            placeholder_content="<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>Large File Redirect</title>
    <meta http-equiv='refresh' content='0; url=https://broderson-assets.maineaddesign.com/$(basename "$file")'>
</head>
<body>
    <p>This file is too large for direct hosting. <a href='https://broderson-assets.maineaddesign.com/$(basename "$file")'>Click here to download</a>.</p>
</body>
</html>"
            
            # Replace the large file with an HTML redirect
            echo "$placeholder_content" > "$file.html"
            rm "$file"
            echo "    → Created redirect: $file.html"
        else
            # For other files, just remove them and log
            echo "    → Removed: $file"
            rm "$file"
        fi
    done
    echo "✅ Large files handled"
else
    echo "✅ No files larger than 25MB found"
fi