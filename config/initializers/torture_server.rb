# frozen_string_literal: true

# FIXME: Should this be part of torture-server ?

Snippets.class_eval do
  def api(path)
    %(<a href="#{path}"><i class="fa fa-book" aria-hidden="true"></i> API docs</a>)
  end

  def img(_path)
    raise "Please replace `img` with `vite_image_tag`"
  end
end

Torture::Page::HTML.class_eval do
  def search_map
    %(<%= search_map.to_json %>)
  end
end
