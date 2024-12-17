require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hamers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0
    config.time_zone = 'Amsterdam'
    config.i18n.default_locale = :nl
    config.to_prepare do
      Doorkeeper::ApplicationsController.layout 'application'
      Doorkeeper::AuthorizationsController.layout 'application'
      Doorkeeper::AuthorizedApplicationsController.layout 'application'

      Devise::SessionsController.layout 'application_public'
      Devise::InvitationsController.layout 'application_public'
      Devise::RegistrationsController.layout 'application_public'
      Devise::ConfirmationsController.layout 'application_public'
      Devise::UnlocksController.layout 'application_public'
      Devise::PasswordsController.layout 'application_public'
    end

    Diffy::Diff.default_format = :html

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
