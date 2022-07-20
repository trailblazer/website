import jquery from "jquery";
import anchorJS from "anchor-js";

var anchors = new anchorJS();
anchors.add(".doc-block h1");
anchors.add(".doc-block h2");
anchors.add(".doc-block h3");
anchors.add(".doc-block h4");
anchors.add(".doc-block ul.navigation li:last-child");

jquery(document).ready(function () {
  anchors.add(".anchored");
});
