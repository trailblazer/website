import jquery from "jquery";

// Import highlight.js and specific languages
import hljs from "highlight.js/lib/core";
import ruby from "highlight.js/lib/languages/ruby";
import xml from "highlight.js/lib/languages/xml";
import json from "highlight.js/lib/languages/json";
import "highlight.js/styles/default.css";

import "bootstrap/dist/js/bootstrap.min.js";
import "bootstrap/dist/css/bootstrap.min.css";

import "~/css/material.css";
import "~/css/font-awesome.css";
import "~/css/main.css";

// import "~/js/docSearch.js";
import "~/js/initAnchor.js";

function updateRightSidebarScrollspy() {
  var href = jquery(".nav-item .active").attr("href");
  var chapter = href;
  var feature = chapter + "-features";
  jquery(".features").hide();
  jquery(feature).show();
  history.replaceState({}, "", href);
}

async function activateAllTabsFor(navTagTitle) {
  const navLinks = jquery(`a[data-tag$="${navTagTitle}"]`);

  navLinks.each((_index, navLink) => {
    jquery(navLink).tab("show");

    const navContent = jquery(navLink.dataset.tag);
    navContent.siblings().removeClass("active");
    navContent.addClass("active");
  });
}

jquery(document).ready(function () {
  // listen for click on tab links
  jquery('a.nav-link[data-toggle="tab"]').click(function (event) {
    const navContent = jquery(event.target.dataset.tag);

    navContent.siblings().removeClass("active");
    navContent.addClass("active");

    const navTagPath = event.target.dataset.tag.split("-");
    activateAllTabsFor(navTagPath[navTagPath.length - 1]);
  });

  hljs.registerLanguage("ruby", ruby);
  hljs.registerLanguage("xml", xml);
  hljs.registerLanguage("json", json);
  hljs.highlightAll();

  jquery(window).scrollspy({ target: ".nav.menu", offset: 110 });
  updateRightSidebarScrollspy();

  jquery(window).on("activate.bs.scrollspy", updateRightSidebarScrollspy);
});
