---
layout: page
title: Yazılım Namına Dur!
tagline: Supporting tagline
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
    <li>
      <div class="postTitle">
        <a href="{{ BASE_PATH }}{{ post.url }}">
          {% if post.series %}
            {{ post.series }} - PART {{ post.series_no }}:
          {% endif %}
          {{ post.title }}</a> &raquo;
        <span>{{ post.date | date_to_string }}</span>
      </div>
      <div class="postExcerpt">
        <blockquote>
          {{ post.excerpt | strip_html }}
          ... &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">Devamı</a>
        </blockquote>
      </div>
    </li>
  {% endfor %}
</ul>
