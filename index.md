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

<!-- <div class="container home">
  <div class="secondary-ctas">
      <a href="https://maineaddesign.slack.com" class="external" target="_blank">Member Slack</a>
      <a href="https://made.memberful.com/auth/sign_in" class="external" target="_blank">Member account login</a>
  </div>
</div> -->