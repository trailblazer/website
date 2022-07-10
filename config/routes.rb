# frozen_string_literal: true

Rails.application.routes.draw do
  get "/2.1/docs/:md_name(/*path)", to: "documentation#show"
  get "/2.1/:md_name", to: "pages#show"
  get "/2.1", to: "home#show"

  # 2.0 routes
  get "/gems/(:name)", to: redirect("/2.0/gems/%{name}")

  root "home#show"
end
