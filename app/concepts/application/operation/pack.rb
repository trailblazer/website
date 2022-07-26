# frozen_string_literal: true

class Application::Operation::Pack < Trailblazer::Operation
  DIST_PATH = "public/dist"
  VITE_PATH = "public/vite"

  step :clear_previous_build
  step :compile_assets
  step Subprocess(Application::Operation::Compile), input: ->(_ctx, **) { { dir_path: DIST_PATH } }

  def clear_previous_pack(_ctx, **)
    FileUtils.rm_rf(DIST_PATH)
    true
  end

  def compile_assets(_ctx, **)
    Rake::Task["vite:build"].invoke
    FileUtils.cp_r(VITE_PATH, DIST_PATH)

    true
  end
end
