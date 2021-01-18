# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, {
  key: '_hamers_session',
  same_site: :none,
  secure: :true
}
