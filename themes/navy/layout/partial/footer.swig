<footer id="footer" class="wrapper">
  <div class="inner">
    <div class="column">
      <p class="column-title">
        &copy; {{ moment(Date.now()).year() }} <a href="https://github.com/hiproxy/hiproxy/graphs/contributors" target="_blank">{{ config.author }}</a><br>
      </p>
      {{ footer_links('licenses') }}
    </div>
    <div class="column">
      <p class="column-title">
        <i class="fa fa-github"></i> Github
      </p>
      {{ footer_links('github') }}
    </div>
    <div class="column">
      <p class="column-title">
        <i class="fa fa-code"></i> {{ __('footer_links.libs') }}
      </p>
      {{ footer_links('libs') }}
    </div>
    <div class="column">
      <p class="column-title">
        <i class="fa fa-link"></i> {{ __('footer_links.links') }}
      </p>
      {{ footer_links('links') }}
    </div>
    <!--
    <div class="column" id="other-links">
      <a href="https://twitter.com/{{ config.twitter }}" class="footer-link" target="_blank"><i class="fa fa-twitter"></i></a>
      <a href="https://github.com/{{ config.github }}" class="footer-link" target="_blank"><i class="fa fa-github"></i></a>
    </div>
    -->
  </div>
</footer>
