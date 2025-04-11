---
layout: page
title: Pattern Library
---

# Pattern Library

This page serves as a reference for all styled elements used throughout the MADE website.

## Typography

### Headings

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

### Paragraphs and Text

Regular paragraph text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in dui mauris. Vivamus hendrerit arcu sed erat molestie vehicula.

<p class="lede">Lede paragraph style. This style is used for introductory text that should have more emphasis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>

**Bold text** and *italic text* and ***bold italic text***.

[This is a link](#) and [this is an external link](https://example.com){:target="_blank" class="external"}.

### Lists

#### Unordered List
* Item 1
* Item 2
* Item 3
  * Nested item 1
  * Nested item 2

#### Ordered List
1. Item 1
2. Item 2
3. Item 3
   1. Nested item 1
   2. Nested item 2

#### Definition List
<dl>
  <dt>Term 1</dt>
  <dd>Definition 1</dd>
  <dt>Term 2</dt>
  <dd>Definition 2</dd>
</dl>

### Blockquotes

> This is a blockquote. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in dui mauris.

### Code

`Inline code`

```
// Code block
function example() {
  return "Hello World";
}
```

## UI Elements

### Buttons & CTAs

<a href="#" class="cta">Primary CTA</a>
<a href="#" class="cta cta-secondary">Secondary CTA</a>
<a href="#" class="external">External Link ↗︎</a>

### Callouts & Notices

<div class="callout">
  <p>This is a callout box used to highlight important information.</p>
</div>

<div class="callout callout-highlight">
  <p>This is a highlighted callout box.</p>
</div>

### Tables

| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |

### Expandable Sections

<div class="expander">
  <div class="expander-toggle">
    <h3>Click to expand</h3>
  </div>
  <div class="expander-content">
    <p>This content is hidden until the user clicks to expand it.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in dui mauris.</p>
  </div>
</div>

## Colors

<div class="color-swatches">
  <div class="color-swatch" style="background-color: var(--page);">
    <p>--page</p>
  </div>
  <div class="color-swatch" style="background-color: var(--ink);">
    <p style="color: white;">--ink</p>
  </div>
  <div class="color-swatch" style="background-color: var(--linktext);">
    <p>--linktext</p>
  </div>
  <div class="color-swatch" style="background-color: var(--currentlinktext);">
    <p>--currentlinktext</p>
  </div>
  <div class="color-swatch" style="background-color: var(--seadogs);">
    <p>--seadogs</p>
  </div>
  <div class="color-swatch" style="background-color: var(--wintermint);">
    <p>--wintermint</p>
  </div>
  <div class="color-swatch" style="background-color: var(--harbor);">
    <p style="color: white;">--harbor</p>
  </div>
  <div class="color-swatch" style="background-color: var(--langostino);">
    <p>--langostino</p>
  </div>
  <div class="color-swatch" style="background-color: var(--sunshine);">
    <p>--sunshine</p>
  </div>
  <div class="color-swatch" style="background-color: var(--orchid);">
    <p style="color: white;">--orchid</p>
  </div>
  <div class="color-swatch" style="background-color: var(--pumpkin);">
    <p>--pumpkin</p>
  </div>
</div>

## Theme System

Apply theme classes to any container element to change the color scheme within that section. The theme will be applied to all child elements, including text, links, buttons, and background images.

### Default Theme

<div class="theme-demo theme-default">
  <h3>Default Theme</h3>
  <p>This is the default theme, using the standard page and ink colors.</p>
  <p>Here is <a href="#">a link</a> and <a href="#" class="current">a current link</a>.</p>
  <a href="#" class="cta">CTA Button</a>
</div>

### Harbor Theme

<div class="theme-demo theme-harbor">
  <h3>Harbor Theme</h3>
  <p>This theme uses harbor as the page color and wintermint as the ink color.</p>
  <p>Here is <a href="#">a link</a> and <a href="#" class="current">a current link</a>.</p>
  <a href="#" class="cta">CTA Button</a>
</div>

### Midnight Theme

<div class="theme-demo theme-midnight">
  <h3>Midnight Theme</h3>
  <p>This theme uses ink as the page color and page as the ink color.</p>
  <p>Here is <a href="#">a link</a> and <a href="#" class="current">a current link</a>.</p>
  <a href="#" class="cta">CTA Button</a>
</div>

### Teal Theme

<div class="theme-demo theme-teal">
  <h3>Teal Theme</h3>
  <p>This theme uses wintermint as the page color and harbor as the ink color.</p>
  <p>Here is <a href="#">a link</a> and <a href="#" class="current">a current link</a>.</p>
  <a href="#" class="cta">CTA Button</a>
</div>

### Sunshine Theme

<div class="theme-demo theme-sunshine">
  <h3>Sunshine Theme</h3>
  <p>This theme uses sunshine as the page color and ink as the ink color.</p>
  <p>Here is <a href="#">a link</a> and <a href="#" class="current">a current link</a>.</p>
  <a href="#" class="cta">CTA Button</a>
</div>

## Themed Components

### Hero with Harbor Theme

{% include hero.html
  image_src="/assets/images/home-page-photo.jpg"
  title="Harbor Theme Hero"
  content="This hero demonstrates the harbor theme with duotoning."
  image_position="top center"
  theme="harbor"
%}

### Hero with Teal Theme

{% include hero.html
  image_src="/assets/images/party-for-join-page.jpg"
  title="Teal Theme Hero"
  content="This hero demonstrates the teal theme with duotoning."
  image_position="center center"
  theme="teal"
%}

### Content with Image (Midnight Theme)

{% capture markdown_content %}
## Midnight Theme Content

This demonstrates a content-with-image component with the midnight theme applied.

- Text and links use theme colors
- Images use theme duotoning
- The entire component inherits the theme
{% endcapture %}

{% capture processed_content %}
{{ markdown_content | markdownify }}
{% endcapture %}

{% include content-with-image.html
   image_src="/assets/images/party-for-join-page.jpg"
   image_alt="MADE event"
   content=processed_content
   image_position="right"
   theme="midnight"
%}

## Components

### Board Member Card

<div class="board-member">
  <img src="/assets/images/board/dustyn.jpeg" alt="Dustyn Bailey">
  <h3>Dustyn Bailey</h3>
  <p>President</p>
  <a href="#" target="_blank">LinkedIn</a>
</div>

### Membership Tier

<div class="tier">
  <h2>Individual membership</h2>
  <p class="price">$50/year</p>
  <a href="#" class="cta">Join</a>
</div>