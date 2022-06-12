# frozen_string_literal: true

class Application::Cell::PreviewMeta < Trailblazer::Cell
  def show
    render :preview_meta
  end

  def title
    model[:title]
  end

  def description
    model[:description]
  end

  def image
    model[:image]
  end

  def twitter_image
    model[:twitter_image]
  end
end
