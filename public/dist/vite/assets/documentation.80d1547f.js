import{j as a,H as n,r as g,x as l,a as c}from"./main.8edf4e21.js";import"./initAnchor.90976c72.js";function o(){var t=a(".nav-item .active").attr("href"),e=t,s=e+"-features";a(".features").hide(),a(s).show()}async function v(t){a(`a[data-tag$="${t}"]`).each((s,i)=>{a(i).tab("show");const r=a(i.dataset.tag);r.siblings().removeClass("active"),r.addClass("active")})}a(document).ready(function(){a('a.nav-link[data-toggle="tab"]').click(function(t){const e=a(t.target.dataset.tag);e.siblings().removeClass("active"),e.addClass("active");const s=t.target.dataset.tag.split("-");v(s[s.length-1])}),n.registerLanguage("ruby",g),n.registerLanguage("xml",l),n.registerLanguage("json",c),n.highlightAll(),a(window).scrollspy({target:".nav.menu",offset:110}),o(),a(window).on("activate.bs.scrollspy",o)});
//# sourceMappingURL=documentation.80d1547f.js.map