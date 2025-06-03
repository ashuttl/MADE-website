module Jekyll
  class WinnersAssetsGenerator < Generator
    safe true
    priority :high

    def generate(site)
      # Create a hash to store asset data for each winner
      site.data['winner_assets'] = {}
      
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
            
            # Initialize the winner's asset data
            site.data['winner_assets'][submission_id] = {
              'level' => level,
              'images' => [],
              'thumbnails' => [],
              'videos' => [],
              'pdfs' => [],
              'audio' => []
            }
            
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
                site.data['winner_assets'][submission_id]['videos'] << relative_path
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