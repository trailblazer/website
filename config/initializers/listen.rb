# Re-generate documentation on any markdown file change
listener = Listen.to('app/concepts') do |modified, added, removed|
  puts "\e[33mRegenerating documentation...\e[0m"
  Application::Operation::Compile.wtf?({})
end

listener.start
