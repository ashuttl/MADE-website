---
layout: page
title: Pattern Library
---

# MADE Pattern Library

This page documents the design system and components used on the Maine Ad + Design website.

<div class="panel mini-panel">
  <h3>Quick Reference</h3>
  <a href="#content-guide" class="cta">Content Guide</a>
  <a href="#typography" class="cta" style="margin-top: 0.5rem;">Typography</a>
  <a href="#colors" class="cta" style="margin-top: 0.5rem;">Colors</a>
  <a href="#components" class="cta" style="margin-top: 0.5rem;">Components</a>
  <a href="#events" class="cta" style="margin-top: 0.5rem;">Events</a>
  <a href="#icons" class="cta" style="margin-top: 0.5rem;">Icons</a>
</div>

<a id="content-guide"></a>
## Content Guide

{% capture content_guide %}
This section provides a quick reference for where to modify content on the MADE website. This is helpful for users who are familiar with code and GitHub but may not know Jekyll well.
{% endcapture %}

{{ content_guide | markdownify }}

### File Structure Overview

{% capture file_structure %}
The MADE website follows Jekyll's file structure conventions:

- **Regular Pages**: Individual Markdown files in the root directory (e.g., `about.md`, `membership.md`)
- **Collections**: Groups of related content in folders with an underscore prefix (`_events`, `_brodersons`)
- **Data Files**: Structured content in YAML files in the `_data` directory
- **Layouts**: Templates for different page types in the `_layouts` directory
- **Includes**: Reusable components in the `_includes` directory
- **Assets**: Images, CSS, and JavaScript in the `assets` directory
{% endcapture %}

{{ file_structure | markdownify }}

### Common Content Locations

{% capture content_locations %}
| Content Type | Location | File Format | Notes |
|--------------|----------|-------------|-------|
| Regular pages | Root directory | Markdown (`.md`) | e.g., `about.md`, `membership.md` |
| Events | `_events/` directory | Markdown (`.md`) | Each event is a separate file |
| Brodersons content | `_brodersons/` directory | Markdown (`.md`) | For Broderson Awards content |
| Global banner | `_data/banner.yml` | YAML | Configure the site-wide banner |
| Footer content | `_data/footer.yml` | YAML | Update contact info and footer text |
| Home page CTAs | `_data/home_ctas.yml` | YAML | Main call-to-action buttons on homepage |
| Site config | `_config.yml` | YAML | Site-wide configurations |
{% endcapture %}

{{ content_locations | markdownify }}

### Editing Events

{% capture editing_events %}
Events are managed as a Jekyll collection. To add a new event:

1. Create a new Markdown file in the `_events/` directory with a descriptive filename (e.g., `made-mixer-june.md`)
2. Include required front matter (YAML at the top of the file):

```yaml
---
layout: page
title: Event Title
date: 2025-06-15  # YYYY-MM-DD format
start_time: "6:00 PM"
end_time: "8:00 PM"
location: Venue Name
address: |
  123 Main Street
  Portland, Maine
image: /assets/images/events/your-image.jpg
price: "$10"  # Optional
ticket_link: https://example.com/tickets  # Optional
---
```

3. Add event description in Markdown below the front matter

Events will automatically appear in the upcoming events section if their date is in the future.
{% endcapture %}

{{ editing_events | markdownify }}

### Modifying Global Elements

{% capture global_elements %}
#### Banner

Edit `_data/banner.yml` to update the site-wide banner:

```yaml
enabled: true  # Set to false to disable
text: "Your banner text here"
url: "/target-page"
theme: "tomato"  # Options: tomato, harbor, sunshine, neutral
exclude_paths: "/path1,/path2/"  # Pages where banner shouldn't show
```

#### Footer

Edit `_data/footer.yml` to update footer content:

```yaml
# Contact information
contact:
  email: "your@email.com"
  linkedin: "YourLinkedIn"
  instagram: "YourInstagram"
  facebook: "YourFacebook"
  signup_url: "https://signup-form.com"
  signup_text: "Sign up text"

# Footer text (supports Markdown)
fineprint: |
  Your footer text here
  Can span multiple lines

# Copyright information
copyright_name: "Your organization name"
copyright_start_year: 1923
```

#### Homepage

The homepage is controlled by `index.md`. The hero section is configured directly in the file:

```liquid
{% raw %}{% include hero.html
  image_src="/path/to/image.jpg"
  title="Your title here"
  cta_links=site.data.home_ctas
  theme="harbor"
%}{% endraw %}
```

The homepage CTA buttons are defined in `_data/home_ctas.yml`:

```yaml
- url: /about
  text: About
- url: /membership
  text: Join
```
{% endcapture %}

{{ global_elements | markdownify }}

### Adding Images

{% capture adding_images %}
Images should be placed in the appropriate subdirectory within the `assets/images/` directory:

- Event images: `assets/images/events/`
- Board member photos: `assets/images/board/`
- General images: `assets/images/`
- Brodersons images: `assets/images/brodersons/`
{% endcapture %}

{{ adding_images | markdownify }}

### Using the Capture Technique for Markdown

{% capture markdown_capture %}
Jekyll and Liquid have some limitations when it comes to processing Markdown within certain contexts. To ensure your Markdown content is properly processed, use the "capture" technique:

1. Wrap your Markdown content in a Liquid capture tag:
   ```liquid
   {% raw %}{% capture your_content_name %}
   Your **Markdown** content goes here.
   
   - With lists
   - And other formatting
   {% endcapture %}{% endraw %}
   ```

2. Output the captured content with the markdownify filter:
   ```liquid
   {% raw %}{{ your_content_name | markdownify }}{% endraw %}
   ```

This technique is especially useful for:
- Content that includes complex Markdown formatting
- Content that includes Liquid tags and variables
- Content that needs to be reused in multiple places

You can see this technique used throughout the site, particularly on the About page and in components like the hero section.
{% endcapture %}

{{ markdown_capture | markdownify }}

## Overview

The MADE website uses a minimal design system focused on typography, color, and whitespace. The design system is built around:

- **Fluid Typography**: Font sizes adjust based on viewport size
- **Modular Components**: Reusable patterns for consistent design
- **Color Themes**: Variations that can be applied to sections
- **3D Effects**: A playful, distinctive treatment for interactive elements

---

<a id="typography"></a>
## Typography

The MADE site uses a combination of typefaces for different purposes:

<div class="two-up">
  <div>
    <h3>Primary Fonts</h3>
    <ul>
      <li><strong style="font-family: var(--font-golos);">Golos Text</strong> - Primary sans-serif for body text</li>
      <li><strong style="font-family: var(--font-brandon);">Brandon Grotesque</strong> - Used for headings</li>
      <li><strong style="font-family: var(--font-aluminia);">LfA Aluminia</strong> - Used for lead paragraphs</li>
      <li><strong style="font-family: var(--font-fragment-mono);">Fragment Mono</strong> - Used for code, straplines, and buttons</li>
    </ul>
  </div>
  <div>
    <h3>Type Scale</h3>
    <div style="font-size: 2.5em; font-family: var(--font-heading);">Heading 1</div>
    <div style="font-size: 2em; font-family: var(--font-heading);">Heading 2</div>
    <div style="font-size: 1.5em; font-family: var(--font-heading);">Heading 3</div>
    <div style="font-size: 1.25em; font-family: var(--font-aluminia);">Lede text</div>
    <div style="font-size: 1em; font-family: var(--font-sans);">Body text</div>
    <div style="font-size: 0.85em; font-family: var(--font-mono); text-transform: uppercase;">Strapline</div>
  </div>
</div>

### Headings

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

### Body Copy

{% capture ledecontent %}
This is a lede paragraph, set in Aluminia. It’s used to introduce sections with a distinctive, editorial feel. Aluminia was designed for Mainer Bruce Kennett’s excellent book on the excellent W.A. Dwiggins ([this is the book](https://brucekennett.com/wa-dwiggins-a-life-in-design/), and here’s [more on the font](https://letterformarchive.org/news/recasting-aluminia/?srsltid=AfmBOopSiBEKqFhkcs2IxMHSfys786D_7Q6r1G7k39XNzU3eaFl2JRVw)).
{% endcapture %}

<div class="lede">
{{ ledecontent | markdownify }}
</div>

Regular paragraph text is set in Golos Text. It's clean, contemporary, and highly readable at all sizes. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Links are generally <a href="#">underlined</a> and inherit their color from the parent element.

**Bold text** and *italic text* and <mark>highlighted text</mark> can be used for emphasis.

### Lists

* Unordered lists use a custom square bullet
* Items have comfortable spacing
* For better readability and scannability

1. Ordered lists maintain the same styling
2. But with numerical indicators
3. Consistent spacing with unordered lists

### Straplines and Headlines

Straplines and headlines are custom elements used to introduce sections:

<span class="strapline">This is a strapline</span>
<h2 class="headline">This is a headline that follows the strapline</h2>

```html
<span class="strapline">This is a strapline</span>
<h2 class="headline">This is a headline that follows the strapline</h2>
```

<a id="colors"></a>
## Colors

The MADE color palette builds upon the brand's heritage while introducing new accent colors.

<div class="color-swatches">
  <div class="color-swatch" style="background-color: var(--page);">
    <p style="color: var(--ink)">--page<br>#FAF7EF</p>
  </div>
  <div class="color-swatch" style="background-color: var(--ink);">
    <p style="color: white;">--ink<br>#062138</p>
  </div>
  <div class="color-swatch" style="background-color: var(--seadogs);">
    <p style="color: var(--ink)">--seadogs<br>#52C1B1</p>
  </div>
  <div class="color-swatch" style="background-color: var(--tomato);">
    <p style="color: white;">--tomato<br>#CA583C</p>
  </div>
  <div class="color-swatch" style="background-color: var(--tomato-alt);">
    <p style="color: white;">--tomato-alt<br>#D85E38</p>
  </div>
  <div class="color-swatch" style="background-color: var(--sunshine);">
    <p style="color: var(--ink)">--sunshine<br>#F0C86D</p>
  </div>
  <div class="color-swatch" style="background-color: var(--harbor);">
    <p style="color: white;">--harbor<br>#062138</p>
  </div>
  <div class="color-swatch" style="background-color: var(--wintermint);">
    <p style="color: var(--ink)">--wintermint<br>#9ECCBF</p>
  </div>
</div>

### Color Modifiers

Colors can be used with transparency modifiers from 10% to 90%:

<div style="display: flex; gap: 0.5rem; margin-bottom: 1rem; flex-wrap: wrap;">
  <div class="bg-tomato-1" style="padding: 0.5rem; border-radius: 0.25rem;">.bg-tomato-1 (10%)</div>
  <div class="bg-tomato-3" style="padding: 0.5rem; border-radius: 0.25rem;">.bg-tomato-3 (30%)</div>
  <div class="bg-tomato-5" style="padding: 0.5rem; border-radius: 0.25rem;">.bg-tomato-5 (50%)</div>
  <div class="bg-tomato-7" style="padding: 0.5rem; border-radius: 0.25rem;">.bg-tomato-7 (70%)</div>
  <div class="bg-tomato-9" style="padding: 0.5rem; border-radius: 0.25rem; color: white;">.bg-tomato-9 (90%)</div>
</div>

<a id="components"></a>
## Components

### Buttons

Buttons use a distinctive 3D effect with pill-shaped styling:

<div style="display: flex; gap: 1rem; flex-wrap: wrap; margin: 2rem 0;">
  <a href="#" class="cta">Primary Button</a>
  <a href="#" class="cta cta-secondary">Secondary Button</a>
  <a href="#" class="cta cta-large">Large Button</a>
  <a href="#" class="cta cta-small">Small Button</a>
</div>

```html
<a href="#" class="cta">Primary Button</a>
<a href="#" class="cta cta-secondary">Secondary Button</a>
<a href="#" class="cta cta-large">Large Button</a>
<a href="#" class="cta cta-small">Small Button</a>
```

### Mini Panels

Mini panels are floating content sections that can contain a call to action:

<div class="panel mini-panel" style="position: static; float: none; display: inline-block; margin: 1rem;">
  <h3>Ready to join?</h3>
  <a href="#" class="cta">Become a member</a>
</div>

<div class="panel mini-panel mini-panel-filled" style="position: static; float: none; display: inline-block; margin: 1rem;">
  <h3>Ready to join?</h3>
  <a href="#" class="cta">Become a member</a>
</div>

<div class="panel mini-panel mini-panel-harbor" style="position: static; float: none; display: inline-block; margin: 1rem;">
  <h3>Ready to join?</h3>
  <a href="#" class="cta">Become a member</a>
</div>

```html
<div class="panel mini-panel">
  <h3>Ready to join?</h3>
  <a href="#" class="cta">Become a member</a>
</div>

<div class="panel mini-panel mini-panel-filled">
  <h3>Ready to join?</h3>
  <a href="#" class="cta">Become a member</a>
</div>
```

### Themed Panels

Panels are content containers that can have different color themes:

<div class="panel panel-sunshine" style="margin: 2rem 0;">
  <span class="strapline">Our mission</span>
  <h2 class="headline">To celebrate, cultivate, and connect Maine's professional creative community</h2>
  
  <div class="two-up">
    <div>
      <h3>We provide:</h3>
      <ul>
        <li>Educational workshops</li>
        <li>Networking events</li>
      </ul>
    </div>
    <div>
      <h3>We serve:</h3>
      <ul>
        <li>Agencies and studios</li>
        <li>Independent professionals</li>
      </ul>
    </div>
  </div>
</div>

<div class="panel panel-tomato" style="margin: 2rem 0;">
  <span class="strapline">Inclusion</span>
  <p><mark>Maine Ad + Design is a community of tolerance and pride.</mark> We stand against oppression in all its forms.</p>
</div>

<div class="panel panel-harbor" style="margin: 2rem 0; color: white;">
  <span class="strapline">Join us</span>
  <p>Become part of Maine's vibrant creative community.</p>
  <a href="#" class="cta">Become a member</a>
</div>

```html
<div class="panel panel-sunshine">
  <span class="strapline">Our mission</span>
  <h2 class="headline">To celebrate, cultivate, and connect</h2>
  
  <div class="two-up">
    <!-- Two-column content -->
  </div>
</div>
```

### Two-Column Layout

The two-up layout creates a simple two-column grid for content organization:

<div class="two-up">
  <div>
    <h3>Left Column</h3>
    <p>This content appears in the left column on larger screens, and stacks on mobile.</p>
  </div>
  <div>
    <h3>Right Column</h3>
    <p>This content appears in the right column on larger screens, and stacks on mobile.</p>
  </div>
</div>

```html
<div class="two-up">
  <div>
    <h3>Left Column</h3>
    <p>Content here...</p>
  </div>
  <div>
    <h3>Right Column</h3>
    <p>Content here...</p>
  </div>
</div>
```

### Membership Tiers

Membership tiers use a card-based layout with the 3D hover effect:

<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; margin: 2rem 0;">
  <div class="tier">
    <div>
      <h2>Individual</h2>
      <p class="price">$50/year</p>
      <p>Perfect for independent creatives and professionals.</p>
    </div>
    <a href="#" class="cta">Join</a>
  </div>
  
  <div class="tier">
    <div>
      <h2>Studio</h2>
      <p class="price">$150/year</p>
      <p>Ideal for small agencies and design studios.</p>
    </div>
    <a href="#" class="cta">Join</a>
  </div>
</div>

```html
<div class="tier">
  <div>
    <h2>Individual</h2>
    <p class="price">$50/year</p>
    <p>Description here...</p>
  </div>
  <a href="#" class="cta">Join</a>
</div>
```

### Board Member Cards

Board members are displayed in a grid of cards with photos:

<div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 1.5rem; margin: 2rem 0;">
  <div class="board-member">
    <img src="/assets/images/board/dustyn.jpeg" alt="Dustyn Bailey">
    <h3>Dustyn Bailey</h3>
    <p>President</p>
  </div>
  
  <div class="board-member">
    <img src="/assets/images/board/abby.jpeg" alt="Abby Lank">
    <h3>Abby Lank</h3>
    <p>Member</p>
  </div>
</div>

```html
<div class="board-member">
  <img src="/path/to/image.jpg" alt="Name">
  <h3>Name</h3>
  <p>Role</p>
</div>
```

<a id="events"></a>
### Event Cards

Events are displayed in a responsive grid with cards that have rounded corners and a distinctive style:

<div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 1.5rem; margin: 2rem 0;">
  <div class="event-card">
    <div class="event-image" style="background-image: url('/assets/images/event-placeholder.jpg');">
      <a href="#" class="event-ticket-link cta cta-sunshine cta-small">RSVP</a>
    </div>
    <div class="event-content">
      <h3 class="event-title text-seadogs">MADE Mixer</h3>
      <div class="event-date">
        <time datetime="2025-04-17">Thursday, April 17</time>
        <span class="event-time">5:30 PM–7:30 PM</span>
      </div>
      <div class="event-location">
        <div class="location-name">Factory 3</div>
        <div class="location-address">105 St James St, Portland, ME</div>
      </div>
    </div>
  </div>
</div>

```html
{% include event-card.html event=event %}
```

To display a list of upcoming events:

```html
{% include upcoming-events.html theme="seadogs" %}
```

### Global Banner

The site features a configurable global banner at the top:

<div style="border: 1px dashed #ccc; padding: 1rem; border-radius: 0.5rem; margin: 2rem 0;">
  <div class="global-banner bg-tomato" style="position: static; padding: 0.75rem 1rem; border-radius: 0.25rem;">
    <div>
      <a href="#" class="banner-link">Get the latest on the 2025 Brodersons ✨ June 5, 2025</a>
    </div>
  </div>
</div>

The banner is configured in `_data/banner.yml` and can be:
- Enabled/disabled
- Customized with different text and links
- Themed with different colors

<a id="icons"></a>
## Icons

### SVG Icons

SVG icons are included as inline SVG for better styling control:

<div style="display: flex; gap: 1.5rem; flex-wrap: wrap; margin: 2rem 0;">
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="linkedin" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">LinkedIn</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="instagram" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Instagram</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="facebook" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Facebook</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="external-link" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">External Link</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="wave" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Wave</p>
  </div>
</div>

Size variations:

<div style="display: flex; gap: 1.5rem; flex-wrap: wrap; margin: 2rem 0; align-items: center;">
  {% include icon.html name="linkedin" class="icon-sm" %}
  {% include icon.html name="linkedin" %}
  {% include icon.html name="linkedin" class="icon-lg" %}
  {% include icon.html name="linkedin" class="icon-xl" %}
</div>

```html
<!-- Default SVG icon -->
{% include icon.html name="linkedin" %}

<!-- Size variations -->
{% include icon.html name="linkedin" class="icon-sm" %}
{% include icon.html name="linkedin" class="icon-lg" %}
{% include icon.html name="linkedin" class="icon-xl" %}

<!-- Available icons -->
{% include icon.html name="linkedin" %}
{% include icon.html name="instagram" %}
{% include icon.html name="facebook" %}
{% include icon.html name="external-link" %}
{% include icon.html name="wave" %}
```

### Emoji Icons

For simpler cases, emoji icons are also available:

<div style="display: flex; gap: 1.5rem; flex-wrap: wrap; margin: 2rem 0;">
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="wave" type="emoji" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Wave</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="external" type="emoji" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">External</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="social-linkedin" type="emoji" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">LinkedIn</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="social-instagram" type="emoji" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Instagram</p>
  </div>
  
  <div style="text-align: center; width: 80px;">
    {% include icon.html name="social-facebook" type="emoji" %}
    <p style="margin-top: 0.5rem; font-size: 0.875em;">Facebook</p>
  </div>
</div>

```html
<!-- Emoji icons -->
{% include icon.html name="wave" type="emoji" %}
{% include icon.html name="external" type="emoji" %}
{% include icon.html name="social-linkedin" type="emoji" %}
{% include icon.html name="social-instagram" type="emoji" %}
{% include icon.html name="social-facebook" type="emoji" %}
```

### Direct Link Icons

External links can automatically include an icon:

<a href="https://example.com" class="external">External link example</a>

```html
<a href="https://example.com" class="external">External link example</a>
```

## Responsive Behavior

The MADE website uses a mobile-first approach with fluid typography and layouts.

- **Typography**: Scales fluidly based on viewport size
- **Layouts**: Stack vertically on small screens, expand on larger screens
- **Components**: Adapt to different screen sizes (e.g., two-up becomes single column)
- **Navigation**: Remains accessible across device sizes

The site does not use traditional breakpoints, but instead relies on fluid, relative units for responsiveness.