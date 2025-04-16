// Initialize expandable sections
document.addEventListener('DOMContentLoaded', function() {
  const expanders = document.querySelectorAll('.expander');
  
  // Apply the init class to body after layout is ready
  document.body.classList.add('js-expanders-ready');
  
  expanders.forEach(expander => {
    const toggle = expander.querySelector('.expander-toggle');
    const content = expander.querySelector('.expander-content');
    const isAwardCategories = expander.id === 'award-categories';
    const hasTables = expander.querySelectorAll('table').length > 0;
    const hasColumns = content.classList.contains('award-categories');
    
    // Calculate real content height with extra padding for smoother animation
    function calculateHeight() {
      // Create a temporary wrapper with the exact same width as the content container
      const wrapper = document.createElement('div');
      wrapper.style.position = 'absolute';
      wrapper.style.visibility = 'hidden';
      wrapper.style.left = '-9999px';
      wrapper.style.width = getComputedStyle(expander).width;
      wrapper.style.padding = '0';
      wrapper.style.overflow = 'visible';
      wrapper.style.height = 'auto';
      
      // Create a cloned element to measure true height
      const clone = content.cloneNode(true);
      
      // Set the clone styles for accurate measurement
      clone.style.position = 'static';
      clone.style.visibility = 'visible';
      clone.style.maxHeight = 'none';
      clone.style.height = 'auto';
      clone.style.width = '100%';
      clone.style.display = 'block';
      clone.style.padding = '1.5rem';
      clone.style.paddingTop = '0';
      clone.style.overflow = 'visible';
      clone.style.opacity = '1';
      clone.style.transition = 'none';
      
      // Add clone to wrapper, and wrapper to DOM
      wrapper.appendChild(clone);
      document.body.appendChild(wrapper);
      
      // Force a reflow to make sure everything is calculated
      void wrapper.offsetHeight;
      
      // Measure the true height
      let height = clone.scrollHeight;
      
      // Add extra padding based on content type
      if (hasColumns) {
        height += 200; // Much more padding for multi-column layouts
      } else if (hasTables) {
        height += 100; // Extra padding for tables
      } else {
        height += 50; // Standard padding
      }
      
      // Remove the wrapper from DOM
      document.body.removeChild(wrapper);
      
      // Return a large value for special cases
      if (height < 100) {
        return '2000px'; // Fallback for very small content
      }
      
      // Add some buffer to the height
      return Math.ceil(height * 1.1) + 'px';
    }
    
    // Set initial height value
    expander.style.setProperty('--content-height', calculateHeight());
    
    // Handle window resize to recalculate heights for responsive layouts
    let resizeTimer;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        if (expander.classList.contains('is-open')) {
          expander.style.setProperty('--content-height', calculateHeight());
        }
      }, 100);
    });
    
    // Special handling for media query changes (column layouts)
    if (hasColumns) {
      const mediaQueryList = [
        window.matchMedia('(min-width: 48em)'),
        window.matchMedia('(min-width: 64em)')
      ];
      
      mediaQueryList.forEach(mql => {
        mql.addEventListener('change', () => {
          if (expander.classList.contains('is-open')) {
            // Wait for layout to update before measuring again
            setTimeout(() => {
              expander.style.setProperty('--content-height', calculateHeight());
            }, 100);
          }
        });
      });
    }
    
    toggle.addEventListener('click', () => {
      // Toggle the open state
      const isCurrentlyOpen = expander.classList.contains('is-open');
      
      if (!isCurrentlyOpen) {
        // First calculate the height before making any changes
        const heightValue = calculateHeight();
        console.log('Calculated height for ' + expander.id + ': ' + heightValue);
        expander.style.setProperty('--content-height', heightValue);
        
        // For complex layouts, add a special debug class
        if (hasColumns) {
          expander.classList.add('is-column-layout');
        }
        if (hasTables) {
          expander.classList.add('has-tables');
        }
        
        // Add the open class to start the transition
        expander.classList.add('is-open');
        
        // For all expanders, recalculate after a short delay to ensure accuracy
        setTimeout(() => {
          const updatedHeight = calculateHeight();
          console.log('Recalculated height for ' + expander.id + ': ' + updatedHeight);
          expander.style.setProperty('--content-height', updatedHeight);
          
          // For column layouts, check again after layout settles
          if (hasColumns) {
            setTimeout(() => {
              const finalHeight = calculateHeight();
              console.log('Final height for ' + expander.id + ': ' + finalHeight);
              expander.style.setProperty('--content-height', finalHeight);
            }, 300);
          }
        }, 50);
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

// Handle events carousel
document.addEventListener('DOMContentLoaded', function() {
  const eventContainers = document.querySelectorAll('.events-carousel');
  
  eventContainers.forEach(container => {
    const scrollOuter = container.querySelector('.events-scroll-outer');
    const scroll = container.querySelector('.events-scroll');
    const leftButton = container.querySelector('.scroll-button.scroll-left');
    const rightButton = container.querySelector('.scroll-button.scroll-right');
    
    if (!scrollOuter || !scroll) return;
    
    // Function to check for overflow
    function checkOverflow() {
      // Add a small buffer to account for rounding errors
      const buffer = 5;
      if (scroll.scrollWidth > scrollOuter.clientWidth + buffer) {
        scrollOuter.classList.add('has-overflow');
        
        // Make sure parent also knows about overflow
        container.classList.add('has-overflow');
        
        // Force the scroll container to stay within bounds
        scrollOuter.style.boxSizing = 'border-box';
        
        console.log('Overflow detected: scrollWidth=', scroll.scrollWidth, 'clientWidth=', scrollOuter.clientWidth);
      } else {
        scrollOuter.classList.remove('has-overflow');
        container.classList.remove('has-overflow');
      }
      
      // Update button visibility
      updateButtonVisibility();
    }
    
    // Function to update button visibility based on scroll position
    function updateButtonVisibility() {
      if (!leftButton || !rightButton) return;
      
      // Initial state - hide left button at start
      if (scrollOuter.scrollLeft === 0) {
        leftButton.style.opacity = '0';
      } else {
        leftButton.style.opacity = '1';
      }
      
      // At the end, hide right button
      const maxScroll = scroll.scrollWidth - scrollOuter.clientWidth;
      if (scrollOuter.scrollLeft >= maxScroll - 5) {
        rightButton.style.opacity = '0';
      } else {
        rightButton.style.opacity = '1';
      }
    }
    
    // Initial check
    // Wait a bit for layout to settle
    setTimeout(checkOverflow, 100);
    
    // Check again on window resize
    let resizeTimer;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(checkOverflow, 100);
    });
    
    // Handle scroll button clicks
    if (leftButton && rightButton) {
      const scrollAmount = 340; // Roughly the width of a card plus gap
      
      leftButton.addEventListener('click', () => {
        scrollOuter.scrollBy({
          left: -scrollAmount,
          behavior: 'smooth'
        });
      });
      
      rightButton.addEventListener('click', () => {
        scrollOuter.scrollBy({
          left: scrollAmount,
          behavior: 'smooth'
        });
      });
      
      // Update button visibility when scrolling
      scrollOuter.addEventListener('scroll', updateButtonVisibility);
      
      // Make sure buttons are positioned correctly relative to container
      container.style.position = 'relative';
    }
  });
});