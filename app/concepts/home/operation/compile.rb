# frozen_string_literal: true

class Home::Operation::Compile < Trailblazer::Operation
  PUBLIC_DIR_PATH = "public"

  step :write_page

  def write_page(_ctx, **)
    # create all directories including subdirectories
    FileUtils.mkdir_p(PUBLIC_DIR_PATH)

    html = Home::Cell::Show.new.call(:show)
    File.write("#{PUBLIC_DIR_PATH}/2.1/index.html", html)
  end
end
