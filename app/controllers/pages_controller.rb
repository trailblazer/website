# frozen_string_literal: true

class PagesController < ApplicationController
  def show
    ctx = Page::Operation::Compile.wtf?({ md_name: params[:md_name] })
    render html: cell(Page::Cell::Show, ctx[:page])
  end
end
