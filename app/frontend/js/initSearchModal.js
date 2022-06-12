import jquery from "jquery";
import { getMatches, fragmentsFor } from "./fzySearch";

jquery(document).ready(function () {
  var searchModal = jquery("#searchModal");
  var searchInput = searchModal.find("input.search-input");

  jquery(document).on("keypress", function (e) {
    if (e.which === 47) {
      e.preventDefault();
      searchModal.modal("show"); // Opening search on typing `/`
    }
  });

  searchModal.on("show.bs.modal", function (e) {
    searchModal.find(".modal-body").remove(); // Clear previous search results
  });

  searchModal.on("shown.bs.modal", function (e) {
    searchInput.focus();
  });

  searchModal.on("hidden.bs.modal", function () {
    searchInput.val(""); // Clear search query
  });

  // Hack to blur out searchInput so that breadcrumb links can be clicked
  searchModal.on("mouseover", "li.breadcrumb-item > a", function (e) {
    e.preventDefault();
    e.stopPropagation();

    if (searchInput.is(":focus")) searchInput.blur();
  });

  searchModal.on("click", "li.breadcrumb-item > a", function () {
    searchModal.modal("hide");
  });

  searchModal.on(
    "change keyup paste",
    ".search-header .search-input",
    function (e) {
      searchModal.find(".modal-body").remove(); // Clear previous search results on each query change

      var matches = getMatches(e.target.value);
      var searchesFragment = fragmentsFor(matches);

      // Insert fragment into DOM at once
      searchModal
        .find(".modal-content")
        .append(
          jquery('<div class="modal-body"></div>').append(searchesFragment)
        );
    }
  );
});
