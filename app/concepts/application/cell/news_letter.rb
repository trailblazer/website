# frozen_string_literal: true

class Application::Cell::NewsLetter < Trailblazer::Cell
  def show
    render :news_letter
  end
end
