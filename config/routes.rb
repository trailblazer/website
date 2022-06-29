# frozen_string_literal: true

Rails.application.routes.draw do
  get "/2.1/docs/:md_name(/*path)", to: "documentation#show"
  get "/2.1/:md_name", to: "pages#show"
  get "/2.1", to: "home#show"

  root "home#show"
end
