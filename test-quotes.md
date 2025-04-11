---
layout: page
title: Testing Quotes
---

## Standard Markdown Text

Here is some text with an apostrophe: That's nice.

Here is some text with a quote: "Quote here".

## Liquid Template Version

{% capture quotes_test %}
Here is some text with an apostrophe: That's nice.

Here is some text with a quote: "Quote here".
{% endcapture %}

{{ quotes_test | markdownify }}