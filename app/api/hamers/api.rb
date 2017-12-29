module Hamers
  class API < Grape::API
    version 'v3', using: :path
    format :json
    use ::WineBouncer::OAuth2
    prefix :api

    rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
      error! e.response.description, 401
    end

    rescue_from WineBouncer::Errors::OAuthForbiddenError do |e|
      error! e.response.description, 403
    end

    desc 'Returns the current user.',
      notes: <<-NOTE
  Marked down notes!
    NOTE
    oauth2 
    get :whoami do
      resource_owner
    end

    mount Hamers::Users
    mount Hamers::Events
    mount Hamers::Quotes

    add_swagger_documentation \
      base_path: '/',
      version: '3',
      endpoint_auth_wrapper: WineBouncer::OAuth2,
      info: {
	title: "Hamers API.",
	description: "Provides endpoints to the resources at zondersikkel.nl.",
	contact_name: "Jacko Zuidema",
	contact_email: "jacko@zondersikkel.nl",
	contact_url: "https://www.zondersikkel.nl",
      }
  end
end
