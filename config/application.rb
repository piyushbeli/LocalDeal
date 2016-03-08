require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RoR
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.initialize_on_precompile = false
    config.assets.precompile << /\.(?:svg|eot|woff|ttf|gif)\z/
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    #Uncomment this line after setting up memcache for production and testing environment
    #config.cache_store = :dalli_store, "cache-1.example.com", "cache-2.example.com",
    #{ :namespace => 'LocalDeal', :expires_in => 1.day, :compress => true }
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache'
    config.session_store = :redis_store, 'redis://localhost:6379/0/session'

    config.active_record.default_timezone = :local

    #application specific global constants
    config.x.order_no_length = 8
    config.x.per_page = 10

    config.after_initialize do

    end
  end
end
