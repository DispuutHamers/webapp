module Hamers
  class Users < Grape::API

    resource :users do 
      desc 'Get all users'
      oauth2 
      get do
        User.all
      end

      desc 'Get a specific user'
      params do
        requires :id, type: Integer, desc: 'User id'
      end
      route_param :id do
        oauth2 
        get do
          User.find(params[:id])
        end
      end
    end
  end
end
