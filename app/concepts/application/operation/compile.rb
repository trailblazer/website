class Application::Operation::Compile < Trailblazer::Operation
  step Subprocess(Home::Operation::Compile), inject: [:dir_path]
  step Subprocess(Documentation::Operation::Compile), inject: [:dir_path]
  step Subprocess(Page::Operation::Compile), inject: [:dir_path]
end
