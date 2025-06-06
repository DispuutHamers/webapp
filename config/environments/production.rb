Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  secret_key_base = Rails.application.credentials.secret_key_base
  config.OTP_SECRET = Rails.application.credentials.otp_secret

  # Lockbox encryption key
  Lockbox.master_key = Rails.application.credentials.lockbox_master_key

  # Set ActiveRecord encryption keys
  config.active_record.encryption.primary_key = Rails.application.credentials[:active_record_encryption][:primary_key]
  config.active_record.encryption.deterministic_key = Rails.application.credentials[:active_record_encryption][:deterministic_key]
  config.active_record.encryption.key_derivation_salt = Rails.application.credentials[:active_record_encryption][:key_derivation_salt]

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.public_file_server.enabled = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = Uglifier.new(harmony: true)
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true
  config.force_ssl = false

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # TODO determine if this is necessary
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store
  # config.cache_store = :redis_cache_store, { url: Rails.application.credentials.redis_host }

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "hamers_#{Rails.env}"
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'zondersikkel.nl' }
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'zondersikkel.nl',
    user_name:            'webapp@zondersikkel.nl',
    password:             Rails.application.credentials.smtp_password,
    authentication:       :plain,
    enable_starttls_auto: true
  }

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = true

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Purge css shit - Enable after landing of tailwind!
  # config.assets.css_compressor = :purger

  # Declare which ActiveStorage service to use
  config.active_storage.service = :local
end
