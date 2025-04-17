---
layout: page
title: Events
theme: seadogs
---

# Events Calendar

Join MADE for events throughout the year – from casual mixers to the annual Broderson Awards celebration.

{% assign now = site.time %}

{% comment %}
  To show events until the day after they occur, we need to calculate
  yesterday's date and compare only the date parts (without time).
{% endcomment %}
{% assign day_in_seconds = 86400 %}
{% assign yesterday_timestamp = now | date: "%s" | minus: day_in_seconds %}
{% assign yesterday = yesterday_timestamp | date: "%Y-%m-%d" %}

{% assign upcoming_events = '' | split: '' %}
{% assign past_events = '' | split: '' %}

{% for event in site.events %}
  {% assign event_date = event.date | date: "%Y-%m-%d" %}
  {% if event_date >= yesterday %}
    {% assign upcoming_events = upcoming_events | push: event %}
  {% else %}
    {% assign past_events = past_events | push: event %}
  {% endif %}
{% endfor %}

{% assign upcoming_events = upcoming_events | sort: 'date' %}
{% assign past_events = past_events | sort: 'date' | reverse %}

## Upcoming Events

{% if upcoming_events.size > 0 %}
<div class="events-grid wider-grid">
  {% for event in upcoming_events %}
    {% include event-card.html event=event %}
  {% endfor %}
</div>
{% else %}
<div class="no-events">
  <p>No upcoming events at this time. Check back soon!</p>
</div>
{% endif %}

{% if past_events.size > 0 %}
## Past Events

<div class="events-grid wider-grid past-events">
  {% for event in past_events %}
    {% include event-card.html event=event %}
  {% endfor %}
</div>
{% endif %}