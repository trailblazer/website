import jquery from "jquery";
import anchorJS from "anchor-js";

jquery(document).ready(function () {
  var anchors = new anchorJS();
  anchors.add(".doc-block h1");
  anchors.add(".doc-block h2");
  anchors.add(".doc-block h3");
  anchors.add(".doc-block h4");
  anchors.add(".doc-block ul.navigation li:last-child");
});
