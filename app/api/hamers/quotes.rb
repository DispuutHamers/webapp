module Hamers
  class Quotes < Grape::API
    resources :quotes do
      desc 'Selecteer alle quotes'
      oauth2
      get do
        Quote.all
      end

      desc 'Selecteer een specifieke quote bij id'
      params do
        requires :id, type: Integer, desc: 'Quote id'
      end

      route_param :id do
        oauth2
        get do
          Quote.find(params[:id])
        end
      end

      desc 'Create een quote'
      params do
        requires :text, type: String, desc: "Wat heeft deze lul gezegt"
        requires :user_id, type: Integer, desc: "De user id van de lul die het zei"
      end

      oauth2
      post do
        Quote.create!({
          reporter: resource_owner,
          user_id: params[:user_id],
          text: params[:text]
        })
      end

      desc 'Update een quote'
      params do
        requires :id, type: Integer, desc: 'Quote id'
        optional :text, type: String, desc: "Wat heeft deze lul gezegt"
        optional :user_id, type: Integer, desc: "De user id van de lul die het zei"
      end

      oauth2
      route_param :id do
        put do
          Quote.find(params[:id]).update({
          user_id: params[:user_id],
          text: params[:text]
          })
        end
      end

      desc 'Delete een quote'
      params do
        requires :id, type: Integer, desc: 'Quote id'
      end

      oauth2
      route_param :id do 
        delete do
          Quote.find(params[:id]).destroy
        end
      end
    end
  end
end
