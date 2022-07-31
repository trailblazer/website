APP_ROOT = File.expand_path("../..", __dir__)

task :publish do
  FileUtils.chdir APP_ROOT do
    puts "== Creating public/dist =="
    system("RAILS_ENV=production rails pack")

    puts "== Commiting public/dist =="
    commit_message = "Publishing public/dist"
    system("git add public/dist && git commit -m '#{commit_message}'")

    puts "== Pushing changes =="
    system("git push origin")
  end
end
