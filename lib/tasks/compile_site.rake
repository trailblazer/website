task compile_site: :environment do
  raise "RAILS_ENV should be production" unless Rails.env.production?

  ctx = {}
  flow_options = {}
  CompileSite::Operation::Run.wtf?([ctx, flow_options])
end