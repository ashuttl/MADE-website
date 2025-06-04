module Jekyll
  class SlideshowDataGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Create slideshow data based on categories and winners
      slideshow_data = []
      
      # Get ordered sections and categories (same order as the awards ceremony)
      sections = [
        {
          title: "Freelance, in-house, & branding",
          categories: [
            "freelance-illustration",
            "freelance-logos-and-marks", 
            "freelance-photography",
            "in-house-creative",
            "corporate-or-brand-identity",
            "self-promotion"
          ]
        },
        {
          title: "All things on screen",
          categories: [
            "tv-campaign-spot-or-video-long-form",
            "tv-campaign-spot-or-video-short-form",
            "animation",
            "digital-advertising-and-rich-media",
            "social-media-campaigns",
            "web-design"
          ]
        },
        {
          title: "Campaign components & student work",
          categories: [
            "audio-podcast-audio-design",
            "ai-and-emergingtechnology",
            "outdoor-advertising-signage-posters-etc",
            "package-design",
            "annual-reports-brochures-corporate-collateral-corporate-event-design",
            "student-work"
          ]
        },
        {
          title: "Campaigns",
          categories: [
            "integrated-marketing-campaign-above-50-000",
            "integrated-marketing-campaign-below-50-000",
            "cause-driven-campaign-asset",
            "the-cumberland-award",
            "pitched-but-ditched"
          ]
        }
      ]
      
      # Level ordering for within each category
      level_order = ['Gold', 'Silver', 'Bronze', 'Student']
      
      # Build slideshow data in presentation order
      sections.each do |section|
        section[:categories].each do |category_slug|
          # Find category info from the categories collection
          category_info = site.collections['categories'].docs.find { |cat| cat.data['slug'] == category_slug }
          next unless category_info
          
          # Get winners for this category
          category_winners = site.collections['winners'].docs.select { |winner| winner.data['category'] == category_slug }
          
          # Sort by level
          level_order.each do |level|
            level_winners = category_winners.select { |winner| winner.data['winning_level'] == level }
            
            level_winners.each do |winner|
              submission_id = winner.data['submission_id']
              winner_assets = site.data['winner_assets'] && site.data['winner_assets'][submission_id]
              
              # Collect all assets for this winner with portrait grouping
              assets = []
              
              # Helper function to check if image is landscape (wider than tall)
              def is_landscape?(image_path)
                begin
                  # Convert relative path to absolute path
                  full_path = File.join(site.source, 'assets', 'winners', image_path)
                  
                  # Use FastImage to get dimensions without loading the full image
                  require 'fastimage'
                  dimensions = FastImage.size(full_path)
                  
                  if dimensions && dimensions.length == 2
                    width, height = dimensions
                    # Consider landscape if width is significantly greater than height
                    width > height * 1.1  # At least 10% wider than tall
                  else
                    false  # Default to not landscape if we can't determine
                  end
                rescue => e
                  # If we can't read the image, default to not landscape
                  false
                end
              end
              
              # Helper function to check if image should be grouped with others
              def is_groupable?(image_path)
                begin
                  # Convert relative path to absolute path
                  full_path = File.join(site.source, 'assets', 'winners', image_path)
                  
                  # Use FastImage to get dimensions without loading the full image
                  require 'fastimage'
                  dimensions = FastImage.size(full_path)
                  
                  if dimensions && dimensions.length == 2
                    width, height = dimensions
                    aspect_ratio = height.to_f / width.to_f
                    
                    # Group images that are NOT clearly landscape
                    # This includes: vertical (>1.0), square (~1.0), and slightly wide but not clearly landscape
                    # Only exclude clearly landscape images (width > 1.5x height)
                    aspect_ratio >= 0.67  # Don't group very wide landscape images (width > 1.5x height)
                  else
                    false
                  end
                rescue => e
                  false
                end
              end
              
              # Helper function to get video duration in milliseconds
              def get_video_duration(video_path)
                # For remote videos, we can't easily get duration without downloading
                # Use the default duration for all videos
                if video_path.start_with?('http')
                  return nil # Fall back to default duration
                end
                
                begin
                  # Convert relative path to absolute path
                  full_path = File.join(site.source, 'assets', 'winners', video_path)
                  
                  # Use ffprobe to get video duration
                  require 'open3'
                  output, error, status = Open3.capture3("ffprobe -v quiet -print_format json -show_format \"#{full_path}\"")
                  
                  if status.success?
                    require 'json'
                    data = JSON.parse(output)
                    duration_seconds = data.dig('format', 'duration')&.to_f
                    
                    if duration_seconds && duration_seconds > 0
                      (duration_seconds * 1000).round # Convert to milliseconds
                    else
                      nil
                    end
                  else
                    nil
                  end
                rescue => e
                  # If ffprobe fails, we'll fall back to the default duration
                  nil
                end
              end
              
              # Process images with dimension-based grouping (if we have assets)
              if winner_assets && winner_assets['images']
                images = winner_assets['images']
                
                # Filter out frame images if we have a corresponding video
                videos = winner_assets['videos'] || []
                filtered_images = images.reject do |image|
                  # Check if this image is a frame from a video we have
                  # Pattern: if video is "xyz-1.mp4", skip images like "xyz-1-f1.jpg", "xyz-1-f2.jpg", etc.
                  should_skip = videos.any? do |video|
                    # Handle both new object format and legacy string format
                    video_url = video.is_a?(Hash) ? video['url'] : video
                    
                    # Handle both local and remote video paths
                    video_filename = video_url.start_with?('http') ? File.basename(video_url) : File.basename(video_url)
                    video_base = File.basename(video_filename, File.extname(video_filename)) # "xyz-1" from "xyz-1.mp4"
                    image_base = File.basename(image, File.extname(image)) # "xyz-1-f1" from "xyz-1-f1.jpg"
                    
                    # Skip if image looks like a frame from this video
                    image_base.match(/^#{Regexp.escape(video_base)}-f\d+(-thumb)?$/)
                  end
                  
                  if should_skip
                    puts "  Skipping frame image #{image} (video exists)"
                  end
                  
                  should_skip
                end
                
                if images.length != filtered_images.length
                  puts "#{submission_id}: Filtered #{images.length - filtered_images.length} frame images (#{videos.length} videos available)"
                end
                
                landscape_images = []
                vertical_images = []
                
                filtered_images.each_with_index do |image, index|
                  if is_groupable?(image)
                    # This is a groupable image - group with other groupable images
                    vertical_images << image
                    
                    # Create grouped slide when we have 2+ groupable images and hit a boundary
                    if vertical_images.length >= 2 && (
                      vertical_images.length >= 3 || # Create group at 3 images
                      index == filtered_images.length - 1 || # End of images - group what we have
                      (filtered_images[index + 1] && !is_groupable?(filtered_images[index + 1])) # Next image is not groupable - group current batch
                    )
                      assets << {
                        url: vertical_images.dup,
                        type: 'image_group'
                      }
                      vertical_images.clear
                    end
                  elsif is_landscape?(image)
                    # This is a landscape image - handle any accumulated groupable images first
                    if vertical_images.length == 1
                      assets << {
                        url: vertical_images.first,
                        type: 'image'
                      }
                    elsif vertical_images.length >= 2
                      assets << {
                        url: vertical_images.dup,
                        type: 'image_group'
                      }
                    end
                    vertical_images.clear
                    
                    # Add to landscape group
                    landscape_images << image
                    
                    # Create grouped slide when we have 2+ landscape images and hit a boundary
                    if landscape_images.length >= 2 && (
                      landscape_images.length >= 3 || # Create group at 3 images
                      index == filtered_images.length - 1 || # End of images - group what we have
                      (filtered_images[index + 1] && !is_landscape?(filtered_images[index + 1])) # Next image is not landscape - group current batch
                    )
                      assets << {
                        url: landscape_images.dup,
                        type: 'image_group'
                      }
                      landscape_images.clear
                    end
                  else
                    # This is a non-groupable image - give it its own slide
                    # First, handle any accumulated groups
                    if vertical_images.length == 1
                      assets << {
                        url: vertical_images.first,
                        type: 'image'
                      }
                    elsif vertical_images.length >= 2
                      assets << {
                        url: vertical_images.dup,
                        type: 'image_group'
                      }
                    end
                    vertical_images.clear
                    
                    if landscape_images.length == 1
                      assets << {
                        url: landscape_images.first,
                        type: 'image'
                      }
                    elsif landscape_images.length >= 2
                      assets << {
                        url: landscape_images.dup,
                        type: 'image_group'
                      }
                    end
                    landscape_images.clear
                    
                    # Add this image as its own slide
                    assets << {
                      url: image,
                      type: 'image'
                    }
                  end
                end
                
                # Handle any remaining grouped images at the end
                if vertical_images.length >= 2
                  # Group any remaining vertical images (2 or more)
                  assets << {
                    url: vertical_images,
                    type: 'image_group'
                  }
                elsif vertical_images.length == 1
                  # Single vertical image gets its own slide
                  assets << {
                    url: vertical_images.first,
                    type: 'image'
                  }
                end
                
                if landscape_images.length >= 2
                  # Group any remaining landscape images (2 or more)
                  assets << {
                    url: landscape_images,
                    type: 'image_group'
                  }
                elsif landscape_images.length == 1
                  # Single landscape image gets its own slide
                  assets << {
                    url: landscape_images.first,
                    type: 'image'
                  }
                end
              end
              
              # Add videos with their actual duration (if we have assets)
              if winner_assets && winner_assets['videos']
                winner_assets['videos'].each do |video|
                  if video.is_a?(Hash)
                    # New format: video is an object with url and duration
                    video_duration = video['duration'] || 30000 # fallback to 30s if no duration specified
                    video_url = video['url']
                  else
                    # Legacy format: video is just a URL string
                    video_url = video
                    video_duration = get_video_duration(video) || 30000 # fallback to 30s
                  end
                  
                  assets << {
                    url: video_url,
                    type: 'video',
                    duration: video_duration
                  }
                end
              end
              
              # Always add winner to slideshow (they'll at least get an interstitial slide)
              # Process text through markdown for proper typography
              title = winner.data['title'] ? site.find_converter_instance(Jekyll::Converters::Markdown).convert(winner.data['title']).strip.gsub(/<\/?p>/, '') : nil
              name = winner.data['name'] ? site.find_converter_instance(Jekyll::Converters::Markdown).convert(winner.data['name']).strip.gsub(/<\/?p>/, '') : nil
              company = winner.data['company_name'] ? site.find_converter_instance(Jekyll::Converters::Markdown).convert(winner.data['company_name']).strip.gsub(/<\/?p>/, '') : nil
              school = winner.data['school_name'] ? site.find_converter_instance(Jekyll::Converters::Markdown).convert(winner.data['school_name']).strip.gsub(/<\/?p>/, '') : nil
              category_title = category_info.data['title'] ? site.find_converter_instance(Jekyll::Converters::Markdown).convert(category_info.data['title']).strip.gsub(/<\/?p>/, '') : nil
              
              slideshow_data << {
                submission_id: submission_id,
                title: title,
                name: name,
                company: company,
                school: school,
                creative_team: winner.data['creative_team_members'],
                category: category_title,
                level: winner.data['winning_level'].downcase,
                assets: assets
              }
              
              # Log when winners have no assets
              if assets.empty?
                puts "#{submission_id}: Winner has no assets, will show interstitial only"
              end
            end
          end
        end
      end
      
      # Store in site data for use in templates
      site.data['slideshow_data'] = slideshow_data
    end
  end
end