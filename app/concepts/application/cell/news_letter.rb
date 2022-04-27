module Application::Cell
  class NewsLetter < Trailblazer::Cell
    def show
      render :news_letter
    end
  end
end
