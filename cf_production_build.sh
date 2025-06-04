#!/bin/bash

# Simplified Cloudflare Pages build script
set -e

echo "🌐 Building for Cloudflare Pages (production)..."

# Set encoding environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export JEKYLL_ENV=production

# Install dependencies
echo "📦 Installing Ruby dependencies..."
bundle install

# Build the site with just the main config (avoiding strict mode issues)
echo "🔨 Building Jekyll site..."
bundle exec jekyll build --verbose

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