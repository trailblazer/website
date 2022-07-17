# frozen_string_literal: true

class Documentation::Cell::Show < Trailblazer::Cell
  cache :show do
    ["documentation", "cell", "show", model.md_name, model.last_updated.to_i]
  end

  def show
    Torture::Page::Final.new(nil).call(
      :show,
      table_of_content: model.left_sidebar,
      right_sidebars:   model.right_sidebar,
      html:             model.html,
      search_map:       @options.fetch(:search_map)
    )
  end
end
