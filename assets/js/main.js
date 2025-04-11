// Initialize expandable sections
document.addEventListener('DOMContentLoaded', function() {
  const expanders = document.querySelectorAll('.expander');
  
  // Apply the init class to body after a small delay to allow transitions to work correctly
  setTimeout(() => {
    document.body.classList.add('js-expanders-ready');
  }, 50);
  
  // Special handling for award categories expander
  const awardCategoriesExpander = document.getElementById('award-categories');
  
  expanders.forEach(expander => {
    const toggle = expander.querySelector('.expander-toggle');
    const content = expander.querySelector('.expander-content');
    const isAwardCategories = expander.id === 'award-categories';
    
    // Calculate real content height with extra padding for smoother animation
    function calculateHeight() {
      // Check if this expander contains tables
      const hasTables = expander.querySelectorAll('table').length > 0;
      
      // Special handling for award categories with multi-column layout
      if (isAwardCategories) {
        // Force columns to be calculated properly by giving it more space
        content.style.visibility = 'hidden';
        content.style.position = 'absolute';
        content.style.maxHeight = 'none';
        content.style.height = 'auto';
        content.style.width = 'auto';
        content.style.display = 'block';
        content.style.padding = '1.5rem';
        content.style.paddingTop = '0';
        content.style.opacity = '0';
        
        // Add extra padding for columns
        const height = content.scrollHeight + 50;
        
        // Reset styles
        content.style.visibility = '';
        content.style.position = '';
        content.style.maxHeight = '';
        content.style.height = '';
        content.style.width = '';
        content.style.display = '';
        content.style.padding = '';
        content.style.paddingTop = '';
        content.style.opacity = '';
        
        return height + 'px';
      } 
      // Special handling for expanders with tables
      else if (hasTables) {
        // Make sure tables have room to display properly
        content.style.visibility = 'hidden';
        content.style.position = 'absolute';
        content.style.maxHeight = 'none';
        content.style.padding = '1.5rem';
        content.style.paddingTop = '0';
        content.style.width = '100%';
        
        // Check table widths and ensure they have enough room
        const tables = content.querySelectorAll('table');
        tables.forEach(table => {
          // Ensure tables are set up for scrolling
          table.style.display = 'block';
          table.style.width = '100%';
          table.style.overflowX = 'auto';
        });
        
        // Add extra space for tables
        const height = content.scrollHeight + 30;
        
        // Reset styles
        content.style.visibility = '';
        content.style.position = '';
        content.style.maxHeight = '';
        content.style.padding = '';
        content.style.paddingTop = '';
        content.style.width = '';
        
        return height + 'px';
      }
      // Standard handling for other expanders
      else {
        content.style.visibility = 'hidden';
        content.style.position = 'absolute';
        content.style.maxHeight = 'none';
        content.style.padding = '1.5rem';
        content.style.paddingTop = '0';
        
        // Add a little extra space to ensure no cut-off during animation
        const height = content.scrollHeight + 20;
        
        // Reset styles
        content.style.visibility = '';
        content.style.position = '';
        content.style.maxHeight = '';
        content.style.padding = '';
        content.style.paddingTop = '';
        
        return height + 'px';
      }
    }
    
    // Set initial height value
    expander.style.setProperty('--content-height', calculateHeight());
    
    // Handle window resize to recalculate heights for responsive layouts
    // Using debounce to not spam calculations during resize
    let resizeTimer;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        expander.style.setProperty('--content-height', calculateHeight());
      }, 100);
    });
    
    // Use a separate handler for column layout changes which can affect height
    const mediaQueryList = [
      window.matchMedia('(min-width: 48em)'),
      window.matchMedia('(min-width: 64em)')
    ];
    
    mediaQueryList.forEach(mql => {
      mql.addEventListener('change', () => {
        // Wait a brief moment for layout to update
        setTimeout(() => {
          expander.style.setProperty('--content-height', calculateHeight());
        }, 50);
      });
    });
    
    toggle.addEventListener('click', () => {
      // Toggle the open state
      const isCurrentlyOpen = expander.classList.contains('is-open');
      
      if (!isCurrentlyOpen) {
        // First set height to 0 and add a class to prepare for animation
        content.style.maxHeight = '0px';
        
        // Special handling for award categories
        if (isAwardCategories) {
          // Pre-calculate the height and add extra padding
          expander.style.setProperty('--content-height', calculateHeight());
          
          // Force a reflow to ensure the browser registers the starting state
          void content.offsetHeight;
          
          // Add the open class to start the transition
          expander.classList.add('is-open');
          
          // Add a second calculation after animation starts to ensure proper height
          // This helps with the column layout rendering
          setTimeout(() => {
            expander.style.setProperty('--content-height', calculateHeight());
          }, 50);
        } else {
          // Set the content-height property for standard expanders
          expander.style.setProperty('--content-height', calculateHeight());
          
          // Force a reflow to ensure the browser registers the starting state
          void content.offsetHeight;
          
          // Add the open class to start the transition
          expander.classList.add('is-open');
        }
      } else {
        // When closing, just toggle the class
        expander.classList.remove('is-open');
      }
    });
  });
});

// Make sure external links open in a new tab
document.addEventListener('DOMContentLoaded', function() {
  const externalLinks = document.querySelectorAll('a.external:not([target])');
  
  externalLinks.forEach(link => {
    link.setAttribute('target', '_blank');
    link.setAttribute('rel', 'noopener noreferrer');
  });
});