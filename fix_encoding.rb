#!/usr/bin/env ruby
# encoding: utf-8

# Encoding fix script for Jekyll build
# This script ensures all markdown files have proper UTF-8 encoding

require 'fileutils'
require 'find'

puts "🔧 Fixing file encodings for Jekyll build..."

# Find all markdown files
markdown_files = []
Find.find('.') do |path|
  next unless File.file?(path)
  next unless path.match?(/\.(md|markdown)$/)
  next if path.include?('/.git/')
  next if path.include?('/_site/')
  next if path.include?('/node_modules/')
  
  markdown_files << path
end

puts "📝 Found #{markdown_files.length} markdown files to check"

fixed_count = 0

markdown_files.each do |file_path|
  begin
    # Read the file and detect encoding issues
    content = File.read(file_path, encoding: 'UTF-8')
    
    # Force UTF-8 encoding and replace invalid characters
    content = content.encode('UTF-8', 'UTF-8', invalid: :replace, undef: :replace, replace: '')
    
    # Clean up any remaining problematic characters
    content = content.gsub(/\x00/, '') # Remove null bytes
    content = content.gsub(/[\x01-\x08\x0B\x0C\x0E-\x1F\x7F]/, '') # Remove other control characters
    
    # Normalize line endings
    content = content.gsub(/\r\n|\r/, "\n")
    
    # Write back with explicit UTF-8 encoding
    File.write(file_path, content, encoding: 'UTF-8')
    
  rescue => e
    puts "⚠️  Error processing #{file_path}: #{e.message}"
    
    # Try to read with different encoding and convert
    begin
      content = File.read(file_path, encoding: 'BINARY')
      content = content.force_encoding('UTF-8')
      content = content.encode('UTF-8', 'UTF-8', invalid: :replace, undef: :replace, replace: '')
      content = content.gsub(/\x00/, '')
      content = content.gsub(/[\x01-\x08\x0B\x0C\x0E-\x1F\x7F]/, '')
      content = content.gsub(/\r\n|\r/, "\n")
      
      File.write(file_path, content, encoding: 'UTF-8')
      fixed_count += 1
      puts "✅ Fixed encoding for #{file_path}"
    rescue => e2
      puts "❌ Failed to fix #{file_path}: #{e2.message}"
    end
  end
end

puts "✅ Encoding fix complete!"
puts "📊 Fixed #{fixed_count} files with encoding issues" if fixed_count > 0