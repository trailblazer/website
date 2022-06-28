# frozen_string_literal: true

Rails.application.routes.draw do
  get "/2.1/docs/:page_name(/*path)", to: "documentation#show"
  get "/2.1/about_us", to: "pages#about_us"
  get "/2.1", to: "home#show"

  root "home#show"
end
