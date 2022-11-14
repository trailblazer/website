APP_ROOT = File.expand_path("../..", __dir__)

task :publish do
  FileUtils.chdir APP_ROOT do
    puts "== Creating public/dist =="
    system("RAILS_ENV=production rails pack")

    puts "== Commiting public/dist =="
    commit_message = "Publishing public/dist"
    system("git add public/dist && git commit -m '#{commit_message}'")

    current_branch = `git rev-parse --abbrev-ref HEAD`
    puts "== Pushing changes to #{current_branch} =="
    system("git push origin #{current_branch}")
  end
end
