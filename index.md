---
layout: page
---
{% include JB/setup %}

<h1>{% t headers.main %}</h1>

<ul class="posts">
  {% for post in site.posts %}
    <li>
      <div class="postTitle">
        <a href="{{ site.baseurl }}{{ post.url }}">
          {% if post.series %}
            {{ post.series }} - PART {{ post.series_no }}:
          {% endif %}
          {{ post.title }}</a> &raquo;
        <span>{{ post.date | date_to_string }}</span>
      </div>
      <div class="postExcerpt">
        <blockquote>
          {{ post.excerpt | strip_html }}
          ... &raquo; <a href="{{ site.baseurl }}{{ post.url }}">{% t mainpage.more %}</a>
        </blockquote>
      </div>
    </li>
  {% endfor %}
</ul>
