# frozen_string_literal: true

class Documentation::Operation::Compile < Trailblazer::Operation
  TOC_ORDER = {
    generics: %w[
      trailblazer
      test
    ],

    activity: [
      "activity",
      "operation",
      "workflow"
      # "2.1/docs/endpoint.md"
    ]

    # gems:              [
    #   "2.1/docs/reform.md",
    #   "2.1/docs/cells.md",
    #   "2.1/docs/representable.md",
    #   "2.1/docs/disposable.md",
    #   "2.1/docs/roar.md"
    # ],

    # tutorials_and_pro: [
    #   "2.1/tutorials/activity.md",
    #   "2.1/docs/pro.md"
    # ]
  }

  LINKS = {
    "trailblazer" => "/2.1/docs/trailblazer.html",
    "activity"    => "/2.1/docs/activity.html",
    "test"        => "/2.1/docs/test.html",
    "operation"   => "/2.1/docs/operation.html",
    "workflow"    => "/2.1/docs/workflow.html"
    # "page/trailblazer.md" => "/2.1/docs/trailblazer.html"
  }

  step :build_pages
  step :build_search_map
  step :build_left_sidebars
  step :build_right_sidebars

  def build_pages(ctx, **)
    site = LINKS.collect do |md_name, url|
      page = Documentation::Page.for(md_name: md_name, url: url)
      [md_name, page]
    end

    ctx[:site] = site.to_h
  end

  def build_search_map(ctx, site:, **)
    search_map = []

    site.each do |_, page|
      next unless page.graph

      item = page.graph.page_header
      search_map_recurrence!(search_map, section: item, breadcrumbs: [], url: page.url)
    end

    ctx[:search_map] = search_map
  end

  def build_left_sidebars(_ctx, site:, **)
    sidebar_group = Documentation::Cell::SidebarGroup.new(site: site)

    TOC_ORDER.each do |_group_name, md_names|
      md_names.each do |current_md_name|
        current_page = site.fetch(current_md_name)

        # render sidebar per page, for all groups
        left_sidebar = TOC_ORDER.collect do |_group_name, current_md_names|
          sidebar_group.call(:show, md_names: current_md_names, current_md_name: current_md_name)
        end

        current_page.left_sidebar = left_sidebar.join("\n")
      end
    end
  end

  def build_right_sidebars(_ctx, site:, **)
    TOC_ORDER.each do |_group_name, md_names| # per page, build all h2 (chapters), and sections
      md_names.each do |current_md_name|
        current_page = site.fetch(current_md_name)

        h2_ordered = current_page.graph.page_header.items # FIXME: make level_to_header ordered.

        right_sidebar = h2_ordered.map.with_index do |h2, index|
          Documentation::Cell::RightSidebarSection.new(h2).call(:show, index: index)
        end

        current_page.right_sidebar = right_sidebar.join("\n")
      end
    end
  end

  private

  def search_map_recurrence!(search_map, section:, breadcrumbs:, url:)
    fragment = {
      pattern:     section.id,
      breadcrumbs: [*breadcrumbs, { title: section.title, link: "#{url}##{section.id}" }]
    }

    search_map.push(fragment)

    section.items.each do |item|
      search_map_recurrence!(search_map, section: item, breadcrumbs: fragment[:breadcrumbs], url: url)
    end
  end
end
