---
layout: ../layouts/PageLayout.astro
title: Events
theme: "seadogs" # This will be passed as a prop or used to set a bodyClass in PageLayout
bodyClass: "theme-seadogs"
---

# Events Calendar

Join MADE for events throughout the year – from casual mixers to the annual Broderson Awards celebration.

## Upcoming Events

<div class="events-grid wider-grid">
  {/* Placeholder for upcoming events. Will be dynamically rendered. */}
  <p>Upcoming events will be listed here.</p>
</div>

## Past Events

<div class="events-grid wider-grid past-events">
  {/* Placeholder for past events. Will be dynamically rendered. */}
  <p>Past events will be listed here.</p>
</div>

<script type="module">
  // This is a placeholder for where event fetching and rendering logic would go.
  // For now, it's a static page.
  // In a future step, we'll use `Astro.glob` or `getCollection` to fetch events
  // and render them using the EventCard component.

  // Example (conceptual, not for direct execution here):
  // import { getCollection } from 'astro:content';
  // const allEvents = await getCollection('events');
  // ... logic to filter and sort ...
  // ... logic to render EventCard components ...
</script>
