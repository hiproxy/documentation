<header id="banner" class="wrapper">
  <div class="inner">
    <h2 id="banner-title">{{ page.subtitle }}</h2>
    <div id="banner-start">
      <span id="banner-start-command">npm install hiproxy -g</span><a id="banner-start-link" href="get_started/"><i class="fa fa-arrow-right"></i></a>
    </div>
    <div id="banner-share">{{ partial('partial/share') }}</div>
  </div>
</header>
<div id="content-wrap">
  <div class="wrapper">
    <div class="inner">
      {{ page.content }}
      <ul id="intro-cmd-wrap">
        <li class="intro-cmd-item">npm install hiproxy -g</li>
        <li class="intro-cmd-item">hiproxy init</li>
        <li class="intro-cmd-item">hiproxy start --rewrite-file rewrite</li>
      </ul>
      <div id="intro-get-started-wrap">
        <a href="get_started/" id="intro-get-started-link">{{ __('index.get_started') }}</a>
      </div>
    </div>
  </div>
</div>