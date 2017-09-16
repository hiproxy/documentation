<head>
  <meta charset="utf-8">
  <title>{% if page.title %}{{ page.title }} | {% endif %}{{ config.title }}</title>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Canonical links -->
  <link rel="canonical" href="{{ url }}">
  <!-- Alternative links -->
  {% if page.layout == 'page' or page.layout == 'index' %}
    {% for lang in site.data.languages %}
      <link rel="alternative" hreflang="{{ loop.key }}" href="{{ canonical_url(loop.key) }}">
    {% endfor %}
  {% endif %}
  <!-- Icon -->
  <link rel="icon" type="image/png" href="{{ url_for('icons/favicon-196x196.png') }}" sizes="196x196">
  <link rel="icon" type="image/png" href="{{ url_for('icons/favicon-160x160.png') }}" sizes="160x160">
  <link rel="icon" type="image/png" href="{{ url_for('icons/favicon-96x96.png') }}" sizes="96x96">
  <link rel="icon" type="image/png" href="{{ url_for('icons/favicon-16x16.png') }}" sizes="16x16">
  <link rel="icon" type="image/png" href="{{ url_for('icons/favicon-32x32.png') }}" sizes="32x32">
  <link rel="apple-touch-icon" sizes="76x76" href="{{ url_for('icons/apple-touch-icon-76x76.png') }}" />
  <link rel="apple-touch-icon" sizes="120x120" href="{{ url_for('icons/apple-touch-icon-120x120.png') }}" />
  <link rel="apple-touch-icon" sizes="152x152" href="{{ url_for('icons/apple-touch-icon-152x152.png') }}" />
  <link rel="apple-touch-icon" sizes="180x180" href="{{ url_for('icons/apple-touch-icon-180x180.png') }}" />
  <link rel="apple-touch-icon" sizes="58x58" href="{{ url_for('icons/android-touch-icon.png') }}" />
  <!-- CSS -->
  <!-- build:css build/css/navy.css -->
  {{ css('css/navy') }}
  <!-- endbuild -->
  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- RSS -->
  {{ feed_tag('atom.xml') }}
  <!-- Google Analytics -->
  {{ partial('google_analytics') }}
</head>
