# frozen_string_literal: true

Rails.autoloaders.each do |autoloader|
  autoloader.ignore(Rails.root.join("app", "frontend"))
  autoloader.ignore(Rails.root.join("app", "concepts", "documentation", "page"))
  autoloader.ignore(Rails.root.join("app", "concepts", "page", "page"))
end
