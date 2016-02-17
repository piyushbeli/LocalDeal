require 'rabl'
Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
  config.perform_caching = true
  config.view_paths = [Rails.root.join('app', 'views')]
end