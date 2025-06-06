module Jekyll
  class WinnersAssetsGenerator < Generator
    safe true
    priority :high

    def generate(site)
      # Create a hash to store asset data for each winner
      site.data['winner_assets'] = {}
      
      # First, process all winners to get their submission IDs and remote videos
      site.collections['winners'].docs.each do |winner|
        submission_id = winner.data['submission_id']
        next unless submission_id
        
        # Initialize the winner's asset data
        site.data['winner_assets'][submission_id] = {
          'level' => winner.data['winning_level']&.downcase,
          'images' => [],
          'thumbnails' => [],
          'videos' => [],
          'pdfs' => [],
          'audio' => []
        }
        
        # Add remote videos from frontmatter if they exist
        if winner.data['remote_videos'] && winner.data['remote_videos'].is_a?(Array)
          winner.data['remote_videos'].each do |video_data|
            if video_data.is_a?(Hash) && video_data['url']
              site.data['winner_assets'][submission_id]['videos'] << {
                'url' => video_data['url'],
                'duration' => video_data['duration'] # duration in milliseconds
              }
            elsif video_data.is_a?(String)
              # Backward compatibility: if it's just a string URL
              site.data['winner_assets'][submission_id]['videos'] << {
                'url' => video_data,
                'duration' => nil
              }
            end
          end
        end
      end
      
      # Get the assets directory path
      assets_path = File.join(site.source, 'assets', 'winners')
      
      return unless Dir.exist?(assets_path)
      
      # Iterate through category directories
      Dir.glob(File.join(assets_path, '*')).each do |category_dir|
        next unless File.directory?(category_dir)
        
        # Iterate through winner directories within each category
        Dir.glob(File.join(category_dir, '*')).each do |winner_dir|
          next unless File.directory?(winner_dir)
          
          # Extract submission_id and level from directory name (e.g., "abc-0006-gold")
          dir_name = File.basename(winner_dir)
          if dir_name =~ /^([a-z]+-\d+)-(gold|silver|bronze|student)$/i
            submission_id = $1.upcase
            level = $2.downcase
            
            # Make sure we have an entry for this winner (in case they don't have a markdown file)
            unless site.data['winner_assets'][submission_id]
              site.data['winner_assets'][submission_id] = {
                'level' => level,
                'images' => [],
                'thumbnails' => [],
                'videos' => [],
                'pdfs' => [],
                'audio' => []
              }
            end
            
            # Scan files in the winner directory
            Dir.glob(File.join(winner_dir, '*')).each do |file_path|
              next unless File.file?(file_path)
              
              file_name = File.basename(file_path)
              relative_path = file_path.sub(site.source, '')
              
              # Categorize files by type
              case File.extname(file_name).downcase
              when '.jpg', '.jpeg', '.png', '.gif', '.webp'
                if file_name.include?('-thumb')
                  site.data['winner_assets'][submission_id]['thumbnails'] << relative_path
                else
                  site.data['winner_assets'][submission_id]['images'] << relative_path
                end
              when '.mp4', '.mov', '.avi', '.webm'
                # Skip local video files - we're using remote videos from Cloudflare R2
                # site.data['winner_assets'][submission_id]['videos'] << relative_path
              when '.pdf'
                site.data['winner_assets'][submission_id]['pdfs'] << relative_path
              when '.mp3', '.wav', '.m4a'
                site.data['winner_assets'][submission_id]['audio'] << relative_path
              end
            end
          end
        end
      end
    end
  end
end