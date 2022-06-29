# frozen_string_literal: true

class Page::Operation::Compile < Trailblazer::Operation
  PAGES_PATH = "app/concepts/page/page"

  LINKS = {
    "about_us" => { header: "About Us", url: "/2.1/about_us" },
    "learn"    => { header: "Learn", url: "/2.1/learn" }
  }

  step :build_page

  def build_page(ctx, md_name:, **)
    url, header = LINKS.fetch(md_name).values_at(:url, :header)

    ctx[:page] = Application::Page.for(
      md_name:    md_name,
      header:     header,
      url:        url,
      pages_path: PAGES_PATH
    )
  end
end
