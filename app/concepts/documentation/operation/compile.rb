# frozen_string_literal: true

class Documentation::Operation::Compile < Trailblazer::Operation
  PAGES_PATH = "app/concepts/documentation/page"
  TOC_ORDER = {
    generics:          %w[
      trailblazer
      test
    ],

    activity:          %w[
      activity
      operation
      workflow
      endpoint
    ],

    gems:              %w[
      reform
      cells
      representable
      disposable
      roar
    ],

    tutorials_and_pro: [
      "tutorials/activity",
      "pro"
    ]
  }

  LINKS = {
    "trailblazer"        => { header: "Trailblazer", url: "/2.1/docs/trailblazer.html" },
    "activity"           => { header: "Activity", url: "/2.1/docs/activity.html" },
    "tutorials/activity" => { header: "Tutorials", url: "/2.1/docs/tutorials/activity.html" },
    "test"               => { header: "Test", url: "/2.1/docs/test.html" },
    "operation"          => { header: "Operation", url: "/2.1/docs/operation.html" },
    "workflow"           => { header: "Workflow", url: "/2.1/docs/workflow.html" },
    "endpoint"           => { header: "Endpoint", url: "/2.1/docs/endpoint.html" },
    "reform"             => { header: "Reform", url: "/2.1/docs/reform.html" },
    "cells"              => { header: "Cells", url: "/2.1/docs/cells.html" },
    "representable"      => { header: "Representable", url: "/2.1/docs/representable.html" },
    "disposable"         => { header: "Disposable", url: "/2.1/docs/disposable.html" },
    "roar"               => { header: "Roar", url: "/2.1/docs/roar.html" },
    "pro"                => { header: "Pro", url: "/2.1/docs/pro.html" }
  }

  step :build_pages
  step :build_left_sidebars
  step :build_right_sidebars
  step :write_pages

  def build_pages(ctx, **)
    site = LINKS.collect do |md_name, options|
      page = Application::Page.for(md_name: md_name, pages_path: PAGES_PATH, **options)
      [md_name, page]
    end
    ctx[:site] = site.to_h
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

  def write_pages(_ctx, site:, dir_path: "public", **)
    # create all directories including subdirectories
    FileUtils.mkdir_p("#{dir_path}/2.1/docs/tutorials")

    site.each do |_md_name, page|
      html = Documentation::Cell::Show.new(page).call(:show)
      File.write("#{dir_path}#{page.url}", html)
    end
  end
end
