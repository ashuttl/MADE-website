---
layout: page
title: Events
theme: seadogs
---

# Events Calendar

Join MADE for events throughout the year – from casual mixers to the annual Broderson Awards celebration.

{% assign now = site.time %}
{% assign upcoming_events = site.events | where_exp: "event", "event.date >= now" | sort: "date" %}
{% assign past_events = site.events | where_exp: "event", "event.date < now" | sort: "date" | reverse %}

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