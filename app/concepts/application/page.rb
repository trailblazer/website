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
    last_updated = File.mtime("#{pages_path}/#{md_name}.md.erb").strftime("%d %b %y")
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
  # rubocop:enable Metrics/MethodLength
end
