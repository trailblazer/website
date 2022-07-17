import jquery from "jquery";

// Import highlight.js and specific languages
import hljs from "highlight.js/lib/core";
import ruby from "highlight.js/lib/languages/ruby";
import xml from "highlight.js/lib/languages/xml";
import json from "highlight.js/lib/languages/json";
import "highlight.js/styles/default.css";

import Wow from "wow.js";
import "wow.js/css/libs/animate.css";

import { ParallaxScroll } from "~/js/jquery.parallax-scroll.js";

import "bootstrap/dist/js/bootstrap.min.js";
import "bootstrap/dist/css/bootstrap.min.css";

import "~/css/material.css";
import "~/css/tomorrow-night-blue.css";
import "~/css/font-awesome.css";
import "~/css/main.css";

import "~/js/initAnchor.js";
import "~/js/initSearchModal.js";
import "~/js/initRightSidebarScrollspy.js";

jquery(document).ready(function () {
  jquery('a.nav-link[data-toggle="tab"]').click(function (e) {
    const navContent = jquery(e.target.dataset.tag);
    navContent.siblings().removeClass("active");
    navContent.addClass("active");
  });

  hljs.registerLanguage("ruby", ruby);
  hljs.registerLanguage("xml", xml);
  hljs.registerLanguage("json", json);

  jquery("pre code").each(function (_i, block) {
    hljs.highlightElement(block);
  });

  new Wow().init();
  ParallaxScroll.init();

  jquery("body").scrollspy({ target: ".nav.menu", offset: 110 });
});
