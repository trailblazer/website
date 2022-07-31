# frozen_string_literal: true

class Application::Operation::Compile < Trailblazer::Operation
  step :remove_old_files
  step Subprocess(Home::Operation::Compile)
  step Subprocess(Documentation::Operation::Compile)
  step Subprocess(Page::Operation::Compile)

  def remove_old_files(_ctx, dist_path: "public", **)
    FileUtils.rm_rf("#{dist_path}/2.1")
  end
end
