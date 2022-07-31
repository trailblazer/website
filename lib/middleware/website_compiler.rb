module Middleware
  class WebsiteCompiler
    def initialize(app)
      @app = app

      @@previous_website_mtime = get_current_website_mtime
    end

    def call(env)
      @request = Rack::Request.new(env)

      if website_should_compile?
        puts "\e[33mRebuilding documentation...\e[0m"
        Rails.application.reloader.reload!
        Application::Operation::Compile.wtf?({})
      end

      @app.call(env)
    end

    def website_should_compile?
      new_mtime = get_current_website_mtime
      old_mtime = @@previous_website_mtime

      @@previous_website_mtime = new_mtime

      return true if old_mtime.blank?
      return true if new_mtime > old_mtime
      return false
    end

    def get_current_website_mtime
      Dir["./app/concepts/**/*"].map{ |file| File.mtime(file) }.max
    end
  end
end
