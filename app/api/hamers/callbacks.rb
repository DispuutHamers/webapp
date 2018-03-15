module Hamers
  class Callbacks < Grape::API

    resource :brew_temps do
      desc 'Get all temperatures'
      oauth2 'api'
      get do
        BrewTemp.all
      end

      desc 'Post a beer temperature'
      params do
        requires :temperature, type: Float, desc: 'Float with the temperature'
      end

      #oauth2 'api'
      post do
        BrewTemp.create!({
          temperature: params[:temperature],
          brew: Brew.last
        })
      end
    end
  end
end
