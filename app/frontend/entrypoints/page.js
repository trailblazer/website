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
import "~/css/tomorrow-night-blue.css";
import "~/css/font-awesome.css";
import "~/css/main.css";

import "~/js/initAnchor.js";
import "~/js/docSearch.js";

jquery(document).ready(function () {
  hljs.registerLanguage("ruby", ruby);
  hljs.registerLanguage("xml", xml);
  hljs.registerLanguage("json", json);
  hljs.highlightAll();
});
