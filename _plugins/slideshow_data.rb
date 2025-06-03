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
              
              next unless winner_assets
              
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
              
              # Helper function to check if image is vertical/portrait enough to group with others
              def is_groupable_vertical?(image_path)
                begin
                  # Convert relative path to absolute path
                  full_path = File.join(site.source, 'assets', 'winners', image_path)
                  
                  # Use FastImage to get dimensions without loading the full image
                  require 'fastimage'
                  dimensions = FastImage.size(full_path)
                  
                  if dimensions && dimensions.length == 2
                    width, height = dimensions
                    aspect_ratio = height.to_f / width.to_f
                    
                    # Group vertical images with aspect ratio of 1.3 or higher (height > 1.3x width)
                    # This covers social media frames (9:16 ≈ 1.78), portraits, and other vertical content
                    aspect_ratio >= 1.3
                  else
                    false
                  end
                rescue => e
                  false
                end
              end
              
              # Process images with dimension-based grouping
              if winner_assets['images']
                images = winner_assets['images']
                landscape_images = []
                vertical_images = []
                
                images.each_with_index do |image, index|
                  if is_groupable_vertical?(image)
                    # This is a vertical image - group with other vertical images
                    vertical_images << image
                    
                    # Create grouped slide when we have 2+ vertical images and hit a boundary
                    if vertical_images.length >= 2 && (
                      vertical_images.length >= 3 || # Create group at 3 images
                      index == images.length - 1 || # End of images - group what we have
                      (images[index + 1] && !is_groupable_vertical?(images[index + 1])) # Next image is not vertical - group current batch
                    )
                      assets << {
                        url: vertical_images.dup,
                        type: 'image_group'
                      }
                      vertical_images.clear
                    end
                  elsif is_landscape?(image)
                    # This is a landscape image - handle any accumulated vertical images first
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
                      index == images.length - 1 || # End of images - group what we have
                      (images[index + 1] && !is_landscape?(images[index + 1])) # Next image is not landscape - group current batch
                    )
                      assets << {
                        url: landscape_images.dup,
                        type: 'image_group'
                      }
                      landscape_images.clear
                    end
                  else
                    # This is a regular portrait image - give it its own slide
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
                    
                    # Add the portrait image as its own slide
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
              
              # Add videos
              if winner_assets['videos']
                winner_assets['videos'].each do |video|
                  assets << {
                    url: video,
                    type: 'video'
                  }
                end
              end
              
              # Only add winner if they have assets to show
              if assets.any?
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