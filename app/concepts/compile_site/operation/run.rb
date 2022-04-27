class CompileSite::Operation::Run < Trailblazer::Operation
  BUILD_PATH = 'public/dist'
  VITE_PATH = 'public/vite'

  PAGES = {
    '/2.1' => Home::Cell::Show,
  }

  step :clear_previous_build
  step :compile_assets
  step :copy_vite_build
  step :compile_pages

  def clear_previous_build(_ctx, **)
    FileUtils.rm_rf(BUILD_PATH) if File.exists?(BUILD_PATH)
    FileUtils.mkdir_p("#{BUILD_PATH}/vite/assets")
  end

  def compile_assets(_ctx, **)
    Rake::Task["vite:build"].invoke()
  end

  def copy_vite_build(_ctx, **)
    FileUtils.cp_r("#{VITE_PATH}/.", "#{BUILD_PATH}/vite")
    true
  end

  def compile_pages(_ctx, **)
    PAGES.each do |path, cell|
      File.open("#{BUILD_PATH}#{path}.html", 'w') do |f|
        f.write ::Cell::ViewModel.cell(cell)
      end
    end
  end
end