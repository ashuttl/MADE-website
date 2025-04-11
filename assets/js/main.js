// Initialize expandable sections
document.addEventListener('DOMContentLoaded', function() {
  const expanders = document.querySelectorAll('.expander');
  
  expanders.forEach(expander => {
    const toggle = expander.querySelector('.expander-toggle');
    
    toggle.addEventListener('click', () => {
      expander.classList.toggle('is-open');
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