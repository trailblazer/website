# frozen_string_literal: true

Rails.application.routes.draw do
  get "/gems/(:name)", to: redirect("/2.0/gems/%{name}") # 2.0 routes
  root to: redirect("/2.1/index.html")
end
