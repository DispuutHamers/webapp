module Hamers
  class Beers < Grape::API
    resources :beers do
      desc 'Selecteer alle biertjes'
      oauth2 'api'
      get do
        Beer.all
      end

      desc 'Selecteer een specifiek biertje bij id'
      params do
        requires :id, type: Integer, desc: 'Bier id'
      end

      route_param :id do
        oauth2 'api'
        get do
          Beer.find(params[:id])
        end
      end

      desc 'Create een biertje'
      params do
        requires :name, type: String, desc: "naam van het biertje"
        requires :soort, type: String, desc: "Het soort bier"
        optional :picture, type: String, desc: "Een url naar een plaatje van dit bier"
        requires :percentage, type: String, desc: "of the kind /\d?\d(\.\d)?/"
        requires :country, type: String, desc: "land van herkomst"
        optional :brewer, type: String, desc: "Wie heeft het gemaakt"
        optional :URL, type: String, desc: "Voor als hier meer info over het biertje te vinden is"
      end

      oauth2 'api'
      post do
        Beer.create!({
          name: params[:name],
          soort: params[:soort],
          picture: params[:picture],
          percentage: params[:percentage],
          country: params[:country],
          brewer: params[:brewer],
          URL: params[:URL]
        })
      end

      desc 'Update een biertje'
      params do
        requires :id, type: Integer, desc: 'Bier id'
        optional :name, type: String, desc: "naam van het biertje"
        optional :soort, type: String, desc: "Het soort bier"
        optional :picture, type: String, desc: "Een url naar een plaatje van dit bier"
        optional :percentage, type: String, desc: "of the kind /\d?\d(\.\d)?/"
        optional :country, type: String, desc: "land van herkomst"
        optional :brewer, type: String, desc: "Wie heeft het gemaakt"
        optional :URL, type: String, desc: "Voor als hier meer info over het biertje te vinden is"
      end

      oauth2 'api'
      route_param :id do
        put do
          Beer.find(params[:id]).update({
            name: params[:name],
            soort: params[:soort],
            picture: params[:picture],
            percentage: params[:percentage],
            country: params[:country],
            brewer: params[:brewer],
            URL: params[:URL]
          })
        end
      end

      desc 'Delete een biertje'
      params do
        requires :id, type: Integer, desc: 'Bier id'
      end

      oauth2 'api'
      route_param :id do
        delete do
          Beer.find(params[:id]).destroy
        end
      end
    end
  end
end
