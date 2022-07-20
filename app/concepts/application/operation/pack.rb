# frozen_string_literal: true

class Application::Operation::Pack < Trailblazer::Operation
  step :clear_previous_build
  step :compile_assets
  step Subprocess(Application::Operation::Compile)

  def clear_previous_build(_ctx, **)
    Rake::Task["vite:clobber"].invoke
    true
  end

  def compile_assets(_ctx, **)
    Rake::Task["vite:build"].invoke
    true
  end
end
