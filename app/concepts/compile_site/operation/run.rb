# frozen_string_literal: true

class CompileSite::Operation::Run < Trailblazer::Operation
  BUILD_PATH = "public/dist"
  VITE_PATH = "public/vite"

  PAGES = {
    "/2.1"      => Home::Routes,
    "/2.1/docs" => Documentation::Routes
  }

  step :clear_previous_build
  step :compile_assets
  step :copy_vite_build
  step :write_pages

  def clear_previous_build(_ctx, **)
    FileUtils.rm_rf(BUILD_PATH) if File.exist?(BUILD_PATH)
    FileUtils.mkdir_p("#{BUILD_PATH}/vite/assets")
  end

  def compile_assets(_ctx, **)
    Rake::Task["vite:build"].invoke
  end

  def copy_vite_build(_ctx, **)
    FileUtils.cp_r("#{VITE_PATH}/.", "#{BUILD_PATH}/vite")
    true
  end

  def write_pages(_ctx, **)
    PAGES.each do |path, page|
      File.write(path, page)
    end
  end
end
