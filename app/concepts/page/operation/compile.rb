# frozen_string_literal: true

class Page::Operation::Compile < Trailblazer::Operation
  PAGES_PATH = "app/concepts/page/page"

  LINKS = {
    "about_us" => { header: "About Us", url: "/2.1/about_us.html" },
    "learn"    => { header: "Learn", url: "/2.1/learn.html" },
    "404"     =>  { header: "404 :(", url: "/404.html" }
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

  def write_pages(_ctx, site:, dir_path: "public", **)
    # create all directories including subdirectories
    FileUtils.mkdir_p("#{dir_path}/2.1")

    site.each do |_md_name, page|
      html = Page::Cell::Show.new(page).call(:show)
      File.write("#{dir_path}#{page.url}", html)
    end

    # Override 404 generation until DDoS is over :(
    File.write("#{dir_path}/404.html", "not_found")
  end
end
