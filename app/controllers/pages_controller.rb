# frozen_string_literal: true

class PagesController < ApplicationController
  def about_us
    render html: cell(Page::Cell::AboutUs)
  end
end
