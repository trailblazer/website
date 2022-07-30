import jquery from "jquery";
import docsearch from "@docsearch/js";

jquery(document).ready(function () {
  docsearch({
    container: "#docsearch",
    appId: "R2IYF7ETH7",
    apiKey: "599cec31baffa4868cae4e79f180729b",
    indexName: "docsearch",
  });
});
