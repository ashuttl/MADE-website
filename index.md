---
layout: home
title: Home
has_hero: true
theme: harbor
---

{% 
  include hero.html
  image_src="/assets/images/home-page-photo.jpg"
  title="Building community for Maine creatives since 1923"
  cta_links=site.data.home_ctas
  image_position="top center"
  theme="harbor"
%}

{% include upcoming-events.html theme="harbor" %}

<section class="instagram">
<div class="container">
<h2>Stay in the loop</h2>
<div class="instagram-follow">
  <a href="https://www.instagram.com/MaineAdDesign" target="_blank" class="cta cta-harbor">Follow us on Instagram</a>
</div>
<behold-widget feed-id="TwvbmjtgKDpsUvUDxaua"></behold-widget>
<script>
  (() => {
    const d=document,s=d.createElement("script");s.type="module";
    s.src="https://w.behold.so/widget.js";d.head.append(s);
  })();
</script>
</div>
</section>

<hr>