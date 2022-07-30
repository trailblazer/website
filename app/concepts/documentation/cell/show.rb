# frozen_string_literal: true

class Documentation::Cell::Show < Trailblazer::Cell
  def show
    Torture::Page::Final.new(nil).call(
      :show,
      table_of_content: model.left_sidebar,
      right_sidebars:   model.right_sidebar,
      html:             model.html
    )
  end
end
