---
layout: ../layouts/PageLayout.astro
title: Join Maine Ad + Design
theme: "sunshine"
bodyClass: "theme-sunshine"
redirect_from: # This will be handled later in Astro config
   - /join
   - /join-us
   - /join_us
lede_content: |
  # Join Maine Ad + Design

  Maine Ad + Design is a nonprofit professional organization that has been working to create community for Maine's creative professionals for more than 100 years. We're a fun, welcoming, caring group of people connected by shared skills, interests, and geography. Join us!
image_src: "/images/party-for-join-page.jpg" # Adjusted path
image_alt: "MADE community event"
image_position: "right"
object_position: "top center"
no_effect: true
---
import { Markdown } from '@astrojs/markdown-component';
import ContentWithImage from '../components/ContentWithImage.astro';
import Lede from '../components/Lede.astro'; // Though Lede component might not be used if content is directly in ContentWithImage

<ContentWithImage 
  image_src={frontmatter.image_src}
  image_alt={frontmatter.image_alt}
  image_position={frontmatter.image_position}
  object_position={frontmatter.object_position}
  no_effect={frontmatter.no_effect}
  content={`<div class="lede">${new Markdown().render(frontmatter.lede_content).html}</div>`}
/>

<div class="membership-tiers">
  <div class="tier">
    <div>
      <h2>Individual membership</h2>
      <p class="price">$50/year</p>
    </div>
    <a href="https://made.memberful.com/checkout?plan=109068" class="cta">Join</a>
  </div>

  <div class="tier">
    <div>
      <h2>Small business membership</h2>
      <p class="price">$300/year</p>
      <p>Includes MADE memberships for <nobr>1–14</nobr> employees at your organization</p>
    </div>
    <a href="https://made.memberful.com/checkout?plan=109069" class="cta">Join</a>
  </div>

  <div class="tier">
    <div>
      <h2>Large business membership</h2>
      <p class="price">$600/year</p>
      <p>Includes MADE memberships for 15+ employees at your organization</p>
    </div>
    <a href="https://made.memberful.com/checkout?plan=109070" class="cta">Join</a>
  </div>
</div>

---

## Membership includes:

- Access to our members-only Slack to connect with the whole community
- Invitations to members-only special events
- The ability to submit work for consideration for the Broderson Awards
- Good feelings and support for a good cause

<div class="panel panel-seadogs">
  <Markdown content="==We don't want the cost of membership to prevent anyone from joining.==

[Students or educators can join free](https://made.memberful.com/checkout?plan=109068&coupon=Education) with coupon code `Education`.

Need a different accommodation? [Contact our volunteer board](mailto:board@maineaddesign.com) and we'll get right in touch." />
</div>
