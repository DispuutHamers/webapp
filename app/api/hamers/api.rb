module Hamers
  class API < Grape::API
    version 'v3', using: :path
    format :json
    use ::WineBouncer::OAuth2
    prefix :api

    before do
      error!({ message: 'Unauthorized' }, 401) unless resource_owner&.active?
    end

    rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
      error! e.response.description, 401
    end

    rescue_from WineBouncer::Errors::OAuthForbiddenError do |e|
      error! e.response.description, 403
    end

    desc 'Returns the current user.'
    oauth2
    get :whoami do
      resource_owner
    end

    desc 'Laat de logs zien sinds de gespecificeerde tijd'
    params do
      requires :since, type: DateTime, desc: 'De datum en tijd vanaf wanneer logs moeten worden laten zien'
    end

    oauth2 'api'
    get :log do
      PaperTrail::Version.where(created_at: params[:since]..DateTime.current).order(created_at: 'DESC')
    end

    mount Hamers::Users
    mount Hamers::Events
    mount Hamers::Quotes
    mount Hamers::Beers
    mount Hamers::Callbacks

    add_swagger_documentation \
      host: "zondersikkel.nl",
      base_path: '/',
      version: '3',
      endpoint_auth_wrapper: WineBouncer::OAuth2,
      #swagger_endpoint_guard: 'oauth2 false',
      token_owner: 'resource_owner',
      security_definitions: {
        "hamers_auth": {
          "type": "oauth2",
          "authorizationUrl": "https://zondersikkel.nl/oauth/authorize",
          "tokenUrl": "https://zondersikkel.nl/oauth/token",
          "flow": "accessCode"
        }
      },
      info: {
        title: "Hamers API.",
        description: "Provides endpoints to the resources at zondersikkel.nl.",
        contact_name: "Hamers zonder Sikkel",
        contact_email: "dev@zondersikkel.nl",
        contact_url: "https://www.zondersikkel.nl",
      }
  end
end
