# frozen_string_literal: true

Cell::ViewModel.class_eval do
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include ViteRails::TagHelpers
  include Cell::Erb
end

if Rails.env.development?
  require "cell/development"
  Cell::ViewModel.include Cell::Development
end
