#!/bin/bash

# Build script for Jekyll + Cloudflare Pages deployment
# This script builds the Jekyll site and prepares it for Cloudflare Pages

set -e  # Exit on any error

echo "🏗️  Building Jekyll site for Cloudflare Pages..."

# Install dependencies if needed
if [ ! -d "vendor/bundle" ]; then
    echo "📦 Installing Ruby dependencies..."
    bundle install --path vendor/bundle
fi

# Set Jekyll environment for production
export JEKYLL_ENV=production

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf _site

# Build the site
echo "🔨 Building Jekyll site..."
bundle exec jekyll build

# Copy _headers file to _site for Cloudflare Pages
if [ -f "_headers" ]; then
    echo "📋 Copying _headers file..."
    cp _headers _site/_headers
fi

# Copy any additional Cloudflare files
if [ -f "_redirects" ]; then
    echo "🔀 Copying _redirects file..."
    cp _redirects _site/_redirects
fi

echo "✅ Build complete! Site is ready in _site/ directory"
echo "📊 Site size: $(du -sh _site | cut -f1)"
echo "📁 Total files: $(find _site -type f | wc -l | tr -d ' ')"

# Optional: Show largest files
echo "📈 Largest files:"
find _site -type f -exec ls -lh {} \; | sort -k5 -hr | head -5 | awk '{print $5 " " $9}'