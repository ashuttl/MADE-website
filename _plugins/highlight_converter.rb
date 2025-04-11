module Jekyll
  module Converters
    class Markdown
      alias old_convert convert
      
      def convert(content)
        # Replace ==highlighted text== with <mark>highlighted text</mark>
        content = content.gsub(/==(.+?)==/, '<mark>\1</mark>')
        
        # Call the original convert method
        old_convert(content)
      end
    end
  end
end