# frozen_string_literal: true

module Documentation::Page
  module_function

  PAGES_PATH = "app/concepts/documentation/page"

  Model = Struct.new(
    :md_name,
    :url,
    :last_updated,
    :html,
    :graph,
    :left_sidebar,
    :right_sidebar,
    :table_of_content
  )

  # rubocop:disable Metrics/MethodLength
  def for(md_name:, url:)
    last_updated = File.mtime("#{PAGES_PATH}/#{md_name}.md.erb").strftime("%d %b %y")
    page = Model.new(md_name, url, last_updated)

    html, graph = Torture::Server.compile_page( # compiles Torture::Page::HTML
      path:   PAGES_PATH,
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
