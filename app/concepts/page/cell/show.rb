# frozen_string_literal: true

class Page::Cell::Show < Trailblazer::Cell
  def show
    Torture::Page::Final.new(nil).call(:show, html: model.html)
  end
end
