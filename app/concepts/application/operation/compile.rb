class Application::Operation::Compile < Trailblazer::Operation
  step Subprocess(Home::Operation::Compile)
  step Subprocess(Documentation::Operation::Compile)
  step Subprocess(Page::Operation::Compile)
end
