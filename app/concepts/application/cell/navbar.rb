module Application::Cell
  class Navbar < Trailblazer::Cell
    def show
      render :navbar
    end

    private

    def landing_page?
      model[:layout] == "home"
    end

    def doc_page?
      model[:layout] == "doc"
    end

    def about_us_page?
      model[:page] == "about_us"
    end

    def blog_page?
      model[:page] == "blog"
    end

    def learn_page?
      model[:page] == "learn"
    end
  end
end
