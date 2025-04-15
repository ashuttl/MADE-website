---
layout: page
title: Pattern Library
---

# MADE Pattern Library

This page documents the design system and components used on the Maine Ad + Design website.

<div class="panel mini-panel">
  <h3>Quick Reference</h3>
  <a href="#typography" class="cta">Typography</a>
  <a href="#colors" class="cta" style="margin-top: 0.5rem;">Colors</a>
  <a href="#components" class="cta" style="margin-top: 0.5rem;">Components</a>
</div>

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

<p class="lede">This is a lede paragraph, set in Aluminia. It's used to introduce sections with a distinctive, editorial feel.</p>

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

<strapline>This is a strapline</strapline>
<headline>This is a headline that follows the strapline</headline>

```html
<strapline>This is a strapline</strapline>
<headline>This is a headline that follows the strapline</headline>
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
  <strapline>Our mission</strapline>
  <headline>To celebrate, cultivate, and connect Maine's professional creative community</headline>
  
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
  <strapline>Inclusion</strapline>
  <p><mark>Maine Ad + Design is a community of tolerance and pride.</mark> We stand against oppression in all its forms.</p>
</div>

<div class="panel panel-harbor" style="margin: 2rem 0; color: white;">
  <strapline>Join us</strapline>
  <p>Become part of Maine's vibrant creative community.</p>
  <a href="#" class="cta">Become a member</a>
</div>

```html
<div class="panel panel-sunshine">
  <strapline>Our mission</strapline>
  <headline>To celebrate, cultivate, and connect</headline>
  
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

## Responsive Behavior

The MADE website uses a mobile-first approach with fluid typography and layouts.

- **Typography**: Scales fluidly based on viewport size
- **Layouts**: Stack vertically on small screens, expand on larger screens
- **Components**: Adapt to different screen sizes (e.g., two-up becomes single column)
- **Navigation**: Remains accessible across device sizes

The site does not use traditional breakpoints, but instead relies on fluid, relative units for responsiveness.