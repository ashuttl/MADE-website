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
              
              # Helper function to check if image is portrait
              def is_portrait?(image_path)
                # Simple heuristic: assume portrait if filename contains certain indicators
                # or if it's in a context that suggests portrait orientation
                false # For now, we'll implement proper image dimension checking later if needed
              end
              
              # Process images with more selective portrait grouping
              if winner_assets['images']
                images = winner_assets['images']
                portrait_images = []
                
                images.each_with_index do |image, index|
                  # More selective heuristic for true portrait grouping candidates
                  # Look for specific patterns that suggest actual portrait-oriented content
                  
                  # Check if this might be a portrait based on refined filename patterns
                  is_likely_portrait = (
                    # Multi-page PDF exports (p1, p2, p3, etc.) - often portrait pages
                    image.match(/-p\d+(?:-thumb)?\.jpg$/) ||
                    # Stamp-like designs (common in illustration work) 
                    image.include?('stamp') ||
                    # Book/poster series indicators
                    image.match(/-\d+-\d+(?:-thumb)?\.jpg$/) ||
                    # Multiple consecutive pages from same base file
                    (index > 0 && images[index-1].gsub(/-p?\d+/, '') == image.gsub(/-p?\d+/, ''))
                  )
                  
                  # Only group if we have strong portrait indicators AND reasonable file naming
                  should_group = is_likely_portrait && (
                    # Must be part of a numbered series (p1, p2, p3...)
                    image.match(/-p\d+/) ||
                    # Or stamp/poster series
                    image.include?('stamp') ||
                    # Or clearly sequential naming
                    image.match(/-\d+-p\d+/)
                  )
                  
                  if should_group && portrait_images.empty?
                    # Start a potential portrait group
                    portrait_images << image
                  elsif should_group && !portrait_images.empty?
                    # Continue the portrait group
                    portrait_images << image
                    
                    # Create grouped slide when we have 2-4 images, but prefer 3 for best visual balance
                    if portrait_images.length >= 2 && (
                      portrait_images.length >= 3 || # Prefer 3+ for grouping
                      index == images.length - 1 || # End of images
                      !images[index + 1]&.match(/-p\d+/) # Next image breaks the pattern
                    )
                      assets << {
                        url: portrait_images.dup,
                        type: 'image_group'
                      }
                      portrait_images.clear
                    end
                  else
                    # Not a portrait candidate or break in portrait sequence
                    # Add any accumulated portraits first (as individual images if only 1-2)
                    if portrait_images.length == 1
                      assets << {
                        url: portrait_images.first,
                        type: 'image'
                      }
                    elsif portrait_images.length == 2
                      # For only 2 images, you might prefer individual slides
                      # Change this to 'image_group' if you want to group pairs
                      portrait_images.each do |portrait_image|
                        assets << {
                          url: portrait_image,
                          type: 'image'
                        }
                      end
                    elsif portrait_images.length > 2
                      assets << {
                        url: portrait_images.dup,
                        type: 'image_group'
                      }
                    end
                    portrait_images.clear
                    
                    # Add the current image as single
                    assets << {
                      url: image,
                      type: 'image'
                    }
                  end
                end
                
                # Handle any remaining portraits at the end
                if portrait_images.length == 1
                  assets << {
                    url: portrait_images.first,
                    type: 'image'
                  }
                elsif portrait_images.length == 2
                  # For pairs at the end, keep as individual (change to 'image_group' if desired)
                  portrait_images.each do |portrait_image|
                    assets << {
                      url: portrait_image,
                      type: 'image'
                    }
                  end
                elsif portrait_images.length > 2
                  assets << {
                    url: portrait_images,
                    type: 'image_group'
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
                slideshow_data << {
                  submission_id: submission_id,
                  title: winner.data['title'],
                  name: winner.data['name'],
                  company: winner.data['company_name'],
                  school: winner.data['school_name'],
                  creative_team: winner.data['creative_team_members'],
                  category: category_info.data['title'],
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