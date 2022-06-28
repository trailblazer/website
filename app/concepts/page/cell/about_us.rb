# frozen_string_literal: true

class Page::Cell::AboutUs < Trailblazer::Cell
  PAGES_PATH = "app/concepts/page/view"
  VIEW_PATH = "about_us"

  def show
    render(
      view:     VIEW_PATH,
      prefixes: [PAGES_PATH],
      layout:   :layout,
      locals:   {
        title:        "About Us",
        page:         VIEW_PATH,
        last_updated: File.mtime("#{PAGES_PATH}/#{VIEW_PATH}.erb").strftime("%d %b %y")
      }
    )
  end
end
