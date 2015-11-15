<!DOCTYPE html>
<!--# config timefmt="%s" -->{# for outputting a timestamp along images to avoid caching #}
<html>
  <head>
    <title>HTTP/2 Mosaic test</title>
    <meta charset="UTF-8">
    <link rel="canonical" href="https://giuseppeciotta.net/h2mosaic/" />    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="/h2mosaic/favicon.png" type="image/png">
    {% if google_analytics %}
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', '{{google_analytics}}', 'auto');
      ga('send', 'pageview');
    </script>
    {% endif %}
    <link rel="stylesheet" href="style.css?<!--# echo var='date_gmt' -->">
  </head>
  <body>
    <a href=".">
      <img class="logo" src="http2_logo.svg?<!--# echo var='date_gmt' -->" alt="HTTP/2 unofficial logo"/>
    </a>
    <h1>HTTP/2 Mosaic test</h1>    

    <p>
      <!--# if expr="$server_protocol = HTTP/2.0" -->
      ✔ <span>You're currently using <strong>HTTP/2.0</strong></span>       
      <!--# else -->
      ✘ <span>You're <strong>not using</strong> HTTP/2.0</span>
      <!--# endif -->
    </p>
    <strong id="loadTime"><div id="spinner"></div></strong>
    <p>
      {# Hack to be able to evaluate two variables at the same time. In ssi there is no AND support #}
      <!--# if expr="$https$server_protocol = /onHTTP\/1.+/" -->
      {# -- connected via SSL but no HTTP/2.0 #}
      <span>Your browser doesn't seem to support HTTP/2.0</span>
      <!--# elif expr="$server_protocol = HTTP/2.0" -->
      <a href="http://h1.giuseppeciotta.net/h2mosaic/">You can run this test with HTTP/1.1</a>
      <!--# else -->
      <a href="https://giuseppeciotta.net/h2mosaic/">You can run this test with HTTP/2 (if your browser supports it)</a>
      <!--# endif -->
    </p>
    
    <div class="mosaic">
      {% for i in images %}<img height="27" width="40" src="tiles/{{i}}?<!--# echo var='date_gmt' -->">{% endfor %}
      <div class="clearfix"></div>
    </div>
    <footer>
      <a href="https://giuseppeciotta.net">Giuseppe Ciotta</a> 2015
      <p>
	<small>Original concept by <a href="https://http2.golang.org/gophertiles">Golang's Gophertiles</a></small>
      </p>
    </footer>
    <script>
      function loadTime() {
        var now = new Date().getTime();
        var load_time = now - performance.timing.connectStart;
        document.getElementById("loadTime").innerHTML = '<span title="Measured from connectStart">Load time</span>: ' + load_time / 1000.0 + ' seconds';
      }
      window.addEventListener("load", loadTime);      
    </script>    
  </body>
</html>
