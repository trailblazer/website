# frozen_string_literal: true

class DocumentationController < ApplicationController
  def show
    ctx = Documentation::Operation::Compile.wtf?({})
    page_path = params.values_at(:md_name, :path).compact.join("/")
    page = ctx[:site].fetch(page_path)

    render html: cell(
      Documentation::Cell::Show,
      page,
      search_map: ctx[:search_map]
    )
  end
end
