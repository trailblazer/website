# frozen_string_literal: true

class Home::Operation::Compile < Trailblazer::Operation
  step :write_page

  def write_page(_ctx, dir_path: "public", **)
    # create all directories including subdirectories
    FileUtils.mkdir_p("#{dir_path}/2.1")

    html = Home::Cell::Show.new.call(:show)
    File.write("#{dir_path}/2.1/index.html", html)
  end
end
