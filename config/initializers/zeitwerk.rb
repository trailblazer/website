# frozen_string_literal: true

Rails.autoloaders.each do |autoloader|
  autoloader.ignore(Rails.root.join("app", "frontend"))
end
