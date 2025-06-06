#!/bin/bash

# Cloudflare Pages build script for Jekyll
set -e

echo "🌐 Building for Cloudflare Pages..."

# Set encoding environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export JEKYLL_ENV=production

# Fix encoding issues before build
echo "🔧 Fixing file encodings..."
if command -v ruby >/dev/null 2>&1; then
    ruby fix_encoding.rb
else
    ./encoding_fix.sh
fi

# Install dependencies
echo "📦 Installing Ruby dependencies..."
bundle install

# Build the site with explicit encoding and production config
echo "🔨 Building Jekyll site..."
bundle exec jekyll build --config _config.yml,_config_production.yml --verbose

# Copy Cloudflare-specific files
echo "📋 Copying Cloudflare configuration files..."
if [ -f "_headers" ]; then
    cp _headers _site/_headers
fi

if [ -f "_redirects" ]; then
    cp _redirects _site/_redirects
fi

# Handle large files (Cloudflare Pages 25MB limit)
echo "🔧 Handling large files..."
./handle_large_files.sh

echo "✅ Cloudflare Pages build complete!"
echo "📊 Site size: $(du -sh _site | cut -f1)"