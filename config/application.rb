# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AwesomeRails
  class Application < Rails::Application
    config.app                            = config_for(:config)
    config.i18n.default_locale            = 'pt-BR'
    config.time_zone                      = 'Brasilia'
    config.generators.scaffold_stylesheet = false
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    Time::DATE_FORMATS[:default] = '%d-%m-%Y %H:%M'
    Date::DATE_FORMATS[:default] = '%d-%m-%Y'

    Time::DATE_FORMATS[:db] = '%Y-%m-%d %H:%M:%S'
    Date::DATE_FORMATS[:db] = '%Y-%m-%d'

    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
