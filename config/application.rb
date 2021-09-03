require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hamers
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "Amsterdam"
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.i18n.default_locale = :'nl'
    config.to_prepare do
      Doorkeeper::ApplicationsController.layout 'application'
      Doorkeeper::AuthorizationsController.layout 'application'
      Doorkeeper::AuthorizedApplicationsController.layout 'application'
      
      Devise::SessionsController.layout 'application_public'
      Devise::RegistrationsController.layout 'application_public'
      Devise::ConfirmationsController.layout 'application_public'
      Devise::UnlocksController.layout 'application_public'
      Devise::PasswordsController.layout 'application_public'
    end

  end
end
