# frozen_string_literal: true

class Application::Operation::Pack < Trailblazer::Operation
  DIST_PATH = "public/dist"
  VITE_PATH = "public/vite"
  OLD_DOCS_PATH = "public/2.0"

  step :clear_previous_pack
  step :compile_assets
  step Subprocess(Application::Operation::Compile), input: ->(_ctx, **) { { dir_path: DIST_PATH } }
  step :copy_old_docs

  def clear_previous_pack(_ctx, **)
    FileUtils.rm_rf(DIST_PATH)
    true
  end

  def compile_assets(_ctx, **)
    Rake::Task["vite:build"].invoke

    FileUtils.mkdir_p(DIST_PATH + "/vite")
    FileUtils.cp_r(VITE_PATH, DIST_PATH)

    true
  end

  def copy_old_docs(_ctx, **)
    FileUtils.cp_r(OLD_DOCS_PATH, DIST_PATH)
    true
  end
end
