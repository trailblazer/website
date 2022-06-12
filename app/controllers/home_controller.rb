# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    render html: cell(Home::Cell::Show)
  end
end
