---
layout: page
title: "2025 Broderson Award Winners"
class: winners-page
permalink: /brodersons/2025/winners/
---

<div class="brodersons-stripes"></div>

<div class="header-content">
  <h1><span class="highlight">2025 Broderson Award Winners</span></h1>
  <h2>Celebrating excellence in Maine's creative community</h2>
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
    <div class="category-group">
      <h3>{{ category.title }}</h3>
      
      <div class="winners-grid">
        {% for level in level_order %}
          {% assign level_winners = category_winners | where: 'winning_level', level %}
          {% for winner in level_winners %}
            {% assign winner_assets = site.data.winner_assets[winner.submission_id] %}
            {% assign thumbnail = winner_assets.thumbnails.first %}
            
            <div class="winner-card {{ level | downcase }}">
              {% if thumbnail %}
                <div class="winner-thumbnail">
                  <a href="{{ winner.url }}">
                    <img src="{{ thumbnail }}" alt="{{ winner.title }}">
                  </a>
                </div>
              {% endif %}
              
              <div class="winner-info">
                <div class="winner-level">{{ level }}</div>
                <h4><a href="{{ winner.url }}">{{ winner.title }}</a></h4>
                <p class="winner-name">{{ winner.name }}</p>
                {% if winner.company_name and winner.company_name != '' %}
                  <p class="winner-company">{{ winner.company_name }}</p>
                {% endif %}
              </div>
            </div>
          {% endfor %}
        {% endfor %}
      </div>
    </div>
    {% endif %}
  {% endfor %}
</div>
{% endfor %}