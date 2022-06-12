# frozen_string_literal: true

class Documentation::Cell::SidebarGroup < Cell::ViewModel
  def initialize(site:)
    super
    @site = site
  end

  def show(md_names:, current_md_name:)
    content = md_names.collect { |md_name|
      page = @site.fetch(md_name)

      Documentation::Cell::LeftSidebarSection.new(
        page.graph.page_header,
        expanded: current_md_name == md_name,
        url:      page.url
      ).call
    }.join("\n")

    render view: :sidebar_group, locals: { content: content }, prefixes: ["app/concepts/documentation/view"]
  end
end
