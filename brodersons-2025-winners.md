---
layout: page
title: "2025 Broderson Award Winners"
class: broderson-page winners-page
permalink: /brodersons/2025/winners/
---

<div class="brodersons-stripes"></div>

<div class="brodersons-art">
  <div class="art-inner">
    <img src="/assets/images/brodersons/Brodersons fall.svg" alt="Brodersons fall art">
    <img src="/assets/images/brodersons/Brodersons hot.svg" alt="Brodersons hot art">
    <img src="/assets/images/brodersons/Brodersons spring.svg" alt="Brodersons spring art">
    <img src="/assets/images/brodersons/Brodersons summer.svg" alt="Brodersons summer art">
    <img src="/assets/images/brodersons/Brodersons warm.svg" alt="Brodersons warm art">
    <img src="/assets/images/brodersons/Brodersons fall.svg" alt="Brodersons fall art">
    <img src="/assets/images/brodersons/Brodersons hot.svg" alt="Brodersons hot art">
    <img src="/assets/images/brodersons/Brodersons spring.svg" alt="Brodersons spring art">
    <img src="/assets/images/brodersons/Brodersons summer.svg" alt="Brodersons summer art">
    <img src="/assets/images/brodersons/Brodersons warm.svg" alt="Brodersons warm art">
    <img src="/assets/images/brodersons/Brodersons fall.svg" alt="Brodersons fall art">
    <img src="/assets/images/brodersons/Brodersons hot.svg" alt="Brodersons hot art">
    <img src="/assets/images/brodersons/Brodersons spring.svg" alt="Brodersons spring art">
    <img src="/assets/images/brodersons/Brodersons summer.svg" alt="Brodersons summer art">
    <img src="/assets/images/brodersons/Brodersons warm.svg" alt="Brodersons warm art">
  </div>
</div>

<div class="header-content">
  <h1><span class="highlight">Winners of the 2025 Broderson Awards</span></h1>
</div>

<div class="winners-navigation">
  <div class="jump-to-category">
    <select id="categoryJumper" class="category-select cta">
      <option value="">Jump to Category</option>
      {% assign sections = site.categories | group_by: 'section' | sort: 'first.section_order' %}
      {% for section in sections %}
        {% assign section_categories = section.items | sort: 'order' %}
        {% for category in section_categories %}
          {% assign category_winners = site.winners | where: 'category', category.slug %}
          {% if category_winners.size > 0 %}
            <option value="{{ category.slug }}">{{ category.title }}</option>
          {% endif %}
        {% endfor %}
      {% endfor %}
    </select>
  </div>
</div>

{% assign sections = site.categories | group_by: 'section' | sort: 'first.section_order' %}
{% assign level_order = 'Gold,Silver,Bronze,Student' | split: ',' %}

{% for section in sections %}
<div class="winners-section">
  <h2>{{ section.name }}</h2>
  
  {% assign section_categories = section.items | sort: 'order' %}
  {% for category in section_categories %}
    {% assign category_winners = site.winners | where: 'category', category.slug %}
    {% if category_winners.size > 0 %}
    <div class="category-group" id="category-{{ category.slug }}">
      <h3>{{ category.title }}</h3>
      
      <div class="winners-grid">
        {% for level in level_order %}
          {% assign level_winners = category_winners | where: 'winning_level', level %}
          {% for winner in level_winners %}
            {% assign winner_assets = site.data.winner_assets[winner.submission_id] %}
            {% assign thumbnails = winner_assets.thumbnails %}
            {% assign thumbnail = thumbnails.first %}
            
            <a href="{{ winner.url }}" class="winner-card-link">
              <div class="winner-card {{ level | downcase }}">
                {% if thumbnail %}
                  <div class="winner-thumbnail" {% if thumbnails.size > 1 %}data-thumbnails="{{ thumbnails | jsonify | xml_escape }}"{% endif %}>
                    <img src="{{ thumbnail }}" alt="{{ winner.title | xml_escape }}">
                  </div>
                {% endif %}
                
                <div class="winner-info">
                  <div class="winner-level">
                    <div class="award-icon">
                      {% include svg/award.svg %}
                    </div>
                    <span>{{ level }}</span>
                  </div>
                  <h4>{{ winner.title | markdownify | remove: '<p>' | remove: '</p>' | strip }}</h4>
                  <p class="winner-name">{{ winner.credited_winner | default: winner.name }}</p>
                  {% if winner.company_name and winner.company_name != '' and winner.credited_winner != winner.company_name %}
                    <p class="winner-company">{{ winner.company_name }}</p>
                  {% endif %}
                  {% if winner.school_name and winner.school_name != '' and winner.credited_winner != winner.school_name %}
                    <p class="winner-school">{{ winner.school_name }}</p>
                  {% endif %}
                  {% assign show_submitter = false %}
                  {% if winner.credited_winner and winner.name %}
                    {% if winner.credited_winner == winner.company_name or winner.credited_winner == winner.school_name %}
                      {% assign show_submitter = true %}
                    {% endif %}
                  {% endif %}
                  {% if show_submitter %}
                    <p class="winner-submitter">{{ winner.name }}</p>
                  {% endif %}
                </div>
              </div>
            </a>
          {% endfor %}
        {% endfor %}
      </div>
    </div>
    {% endif %}
  {% endfor %}
</div>
{% endfor %}

<script>
document.addEventListener('DOMContentLoaded', function() {
  // Handle category jumper dropdown
  const categorySelect = document.getElementById('categoryJumper');
  if (categorySelect) {
    categorySelect.addEventListener('change', function() {
      const selectedCategory = this.value;
      if (selectedCategory) {
        // Navigate to category section with smooth scroll
        const targetElement = document.getElementById('category-' + selectedCategory);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
          // Update URL hash without triggering hashchange event
          history.replaceState(null, null, '#category-' + selectedCategory);
        }
        // Reset the select to placeholder
        this.value = '';
      }
    });
  }

  // Handle fragment navigation for category jumping
  function scrollToCategory() {
    const hash = window.location.hash;
    if (hash && hash.startsWith('#category-')) {
      const targetElement = document.querySelector(hash);
      if (targetElement) {
        setTimeout(() => {
          targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
          
          // Scroll smoothly to the category
        }, 100);
      }
    }
  }
  
  // Handle initial page load with fragment
  scrollToCategory();
  
  // Handle back/forward navigation
  window.addEventListener('hashchange', scrollToCategory);
  
  // Initialize thumbnail rotation for winners with multiple thumbnails
  const thumbnailContainers = document.querySelectorAll('.winner-thumbnail[data-thumbnails]');
  
  thumbnailContainers.forEach(container => {
    const img = container.querySelector('img');
    const thumbnailsData = container.getAttribute('data-thumbnails');
    
    if (!img || !thumbnailsData) return;
    
    let thumbnails;
    try {
      // Parse the JSON data (it's HTML-escaped, so we need to decode it)
      const textarea = document.createElement('textarea');
      textarea.innerHTML = thumbnailsData;
      thumbnails = JSON.parse(textarea.value);
    } catch (e) {
      console.error('Failed to parse thumbnails data:', e);
      return;
    }
    
    if (!thumbnails || thumbnails.length <= 1) return;
    
    let currentIndex = 0;
    let rotationInterval;
    let isHovering = false;
    
    // Function to rotate to next thumbnail
    function rotateThumbnail() {
      if (!isHovering) return;
      
      currentIndex = (currentIndex + 1) % thumbnails.length;
      img.src = thumbnails[currentIndex];
    }
    
    // Find the parent card link to attach hover events to the whole card
    const cardLink = container.closest('.winner-card-link');
    
    // Start rotation on card hover
    cardLink.addEventListener('mouseenter', function() {
      isHovering = true;
      // Start rotating immediately
      rotationInterval = setInterval(rotateThumbnail, 500); // 500ms between rotations
    });
    
    // Stop rotation and reset on card mouse leave
    cardLink.addEventListener('mouseleave', function() {
      isHovering = false;
      clearInterval(rotationInterval);
      
      // Reset to first thumbnail
      currentIndex = 0;
      img.src = thumbnails[0];
    });
    
    // Preload all thumbnails for smooth rotation
    thumbnails.forEach(src => {
      const preloadImg = new Image();
      preloadImg.src = src;
    });
  });
});
</script>