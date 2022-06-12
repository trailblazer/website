import jquery from "jquery";

jquery(window).on("activate.bs.scrollspy", function (e) {
  var href = jquery(".nav-item .active").attr("href");
  var chapter = href;
  var feature = chapter + "-features";
  jquery(".features").hide();
  jquery(feature).show();
  history.replaceState({}, "", href);
});
