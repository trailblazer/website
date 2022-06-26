# frozen_string_literal: true

class DocumentationController < ApplicationController
  def show
    ctx = Documentation::Operation::Compile.wtf?({})
    page = ctx[:site].fetch(params[:page_name])

    render html: cell(
      Documentation::Cell::Show,
      page,
      search_map: ctx[:search_map]
    )
  end
end
