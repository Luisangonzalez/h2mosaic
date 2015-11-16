# H2mosaic - a quick and simple demonstration of HTTP/2 latency improvements

This set of static files showcases the latency and page load
improvements delivered by HTTP/2 compared to
HTTP/1.1. [Demo: giuseppeciotta.net/h2mosaic](https://giuseppeciotta.net/h2mosaic/)

![h2mosaic screenshot](h2mosaic.gif)

It does that by serving an image composed of ~230 small tiles. This
scenario stresses the head-of-line blocking and latency sensitiveness
of HTTP/1.1.

It relies on
[nginx SSI](http://nginx.org/en/docs/http/ngx_http_ssi_module.html)
for some dynamic details, like displaying the currently used HTTP
version.

[Blog post](https://giuseppeciotta.net/getting-to-know-http20-with-the-mosaic-demo.html)
explaining how this demo works.

