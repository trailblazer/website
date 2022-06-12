# frozen_string_literal: true

class Application::Cell::Footer < Trailblazer::Cell
  def show
    render :footer
  end

  def layout
    model.fetch(:layout)
  end

  def page
    model.fetch(:page)
  end
end
