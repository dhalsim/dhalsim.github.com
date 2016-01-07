---
layout: page
---
{% include JB/setup %}

<h1 class="slogan"><span>{% t headers.main %}</span></h1>

{% for post in site.posts %}
<div class="clearfix">
  <div class="postTitle">
    <a href="{{ site.baseurl }}{{ post.url }}">
      {{ post.title }}
    </a>
  </div>
  <div class="postExcerpt">
      {% if post.image %}
      <a href="{{ site.baseurl }}{{ post.url }}">
        <img src="{{ post.image }}" />
      </a>
      {% endif %}

      {% if post.series %}
      <div class="series">
        <a href="categories.html#{{ post.series_category }}-ref">{{ post.series }} - Part {{ post.series_no }}</a>
      {% else %}
      <div>
      {% endif %}

        <div>
          <span>{{ post.date | date_to_string }}</span> &raquo;
          {{ post.excerpt | strip_html }} ... &raquo;
          <a href="{{ site.baseurl }}{{ post.url }}">{% t mainpage.more %}</a>
        </div>
      </div>
  </div>
</div>
{% endfor %}
