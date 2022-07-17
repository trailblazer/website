# frozen_string_literal: true

module Application::Page
  module_function

  Model = Struct.new(
    :md_name,
    :header,
    :url,
    :last_updated,
    :html,
    :graph,
    :left_sidebar,
    :right_sidebar,
    :table_of_content
  )

  # rubocop:disable Metrics/MethodLength
  def for(md_name:, header:, url:, pages_path:)
    last_updated = calculate_last_updated_at(md_name: md_name, pages_path: pages_path)
    cache_key = [pages_path, md_name, last_updated.to_i]

    Rails.cache.fetch(cache_key) do
      page = Model.new(md_name, header, url, last_updated)

      html, graph = Torture::Server.compile_page( # compiles Torture::Page::HTML
        path:   pages_path,
        layout: "../view/layout",
        page:   "#{page.md_name}.md",
        model:  page
      )

      page.html = html
      page.graph = graph

      page
    end
  end
  # rubocop:enable Metrics/MethodLength

  # consider markdown or it's snippet's `mtime` (whichever is latest)
  def calculate_last_updated_at(md_name:, pages_path:)
    files = Dir["#{pages_path}/snippet/#{md_name}/**/*"] + ["#{pages_path}/#{md_name}.md.erb"]
    files.map { |file| File.mtime(file) }.max
  end
end
