# frozen_string_literal: true

class Page::Operation::Compile < Trailblazer::Operation
  PAGES_PATH = "app/concepts/page/page"
  PUBLIC_DIR_PATH = "public"

  LINKS = {
    "about_us" => { header: "About Us", url: "/2.1/about_us.html" },
    "learn"    => { header: "Learn", url: "/2.1/learn.html" }
  }

  step :build_pages
  step :write_pages

  def build_pages(ctx, **)
    site = LINKS.collect do |md_name, options|
      page = Application::Page.for(md_name: md_name, pages_path: PAGES_PATH, **options)
      [md_name, page]
    end
    ctx[:site] = site.to_h
  end

  def write_pages(_ctx, site:, **)
    # create all directories including subdirectories
    FileUtils.mkdir_p(PUBLIC_DIR_PATH)

    site.each do |md_name, page|
      html = Page::Cell::Show.new(page).call(:show)
      File.write("#{PUBLIC_DIR_PATH}#{page.url}", html)
    end
  end
end
