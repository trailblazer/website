# Re-generate documentation on any markdown file change
documentation_listener = Listen.to('app/concepts/documentation/page') do |modified, added, removed|
  puts "\e[33mRegenerating documentation...\e[0m"
  Documentation::Operation::Compile.wtf?({})
end

documentation_listener.start
