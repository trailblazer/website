import jquery from "jquery";
import { score } from "fzy.js";

const getMatches = function (query) {
  if (!query) return;

  var regex = new RegExp(query.split("").join(".*"));
  var filteredList = searchMap.filter(function (item) {
    return item.pattern.match(regex);
  });

  // Sort matched sectons in DESC order and keep only top five
  return filteredList
    .sort(function (second, first) {
      return score(query, first.pattern) - score(query, second.pattern);
    })
    .slice(0, 5);
};

const fragmentsFor = function (matches) {
  // Create empty fragment to generate list DOM and avoid multiple DOM insertions
  var searchesFragment = jquery(document.createDocumentFragment());
  matches.forEach(function (item) {
    var breadcrumbs = item.breadcrumbs.map(function (breadcrumb) {
      return jquery(
        '<li class="breadcrumb-item"><a href="' +
          breadcrumb.link +
          '">' +
          breadcrumb.title +
          "</a></li>"
      );
    });

    searchesFragment.append(
      jquery('<ol class="breadcrumb"></ol>').append(breadcrumbs)
    );
  });

  return searchesFragment;
};

export { getMatches, fragmentsFor };
