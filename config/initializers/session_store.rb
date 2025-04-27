# Be sure to restart your server when you modify this file.
if Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_hamers_session', same_site: :lax, secure: :true
else
  Rails.application.config.session_store :cookie_store
end
