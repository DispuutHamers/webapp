module Hamers
  class Events < Grape::API
    resources :events do
      desc 'Selecteer alle events'
      oauth2
      get do
        Event.all
      end

      desc 'Selecteer een specifiek event bij id'
      params do
        requires :id, type: Integer, desc: 'Event id'
      end

      route_param :id do
        oauth2
        get do
          Event.find(params[:id])
        end
      end

      desc 'Create een event'
      params do
        requires :beschrijving, type: String, desc: 'Beschrijving van het event'
        requires :title, type: String, desc: 'Naam van het event'
        requires :date, type: DateTime, desc: 'Datum en tijd van het event'
        requires :deadline, type: DateTime, desc: 'Inschrijf deadline van het event'
        requires :endtime, type: DateTime, desc: 'Wanneer is het event afgelopen'
        optional :location, type: String, desc: 'Waar is het event'
      end

      oauth2
      post do
        location = params[:location] ||= "TBD"
        Event.create!({
          user: resource_owner,
          beschrijving: params[:beschrijving],
          title: params[:title],
          date: params[:date],
          deadline: params[:deadline],
          end_time: params[:endtime],
          location: location
        })
      end

      desc 'Update een event'
      params do
        requires :id, type: Integer, desc: 'Event id'
          optional :title, type: String, desc: 'Nieuwe title voor het event'
          optional :beschrijving, type: String, desc: 'Nieuwe beschrijving voor het event'
          optional :date, type: DateTime, desc: 'Nieuwe starttijd voor het event, stoptijd en deadline worden niet aangepast.'
          optional :deadline, type: DateTime, desc: 'Nieuwe inschrijf deadline voor het event'
          optional :endtime, type: DateTime, desc: 'Nieuwe eindtijd voor het event, starttijd en deadline worden niet aangepast'
          optional :location, type: String, desc: 'Nieuwe locatie voor het event'
      end

      oauth2
      route_param :id do
        put do
          Event.find(params[:id]).update({
            beschrijving: params[:beschrijving],
            title: params[:title],
            date: params[:date],
            deadline: params[:deadline],
            end_time: params[:endtime],
            location: params[:location]
          })
        end
      end

      desc 'Delete een event'
      params do
        requires :id, type: Integer, desc: 'Event id'
      end

      oauth2
      route_param :id do 
        delete do
          Event.find(params[:id]).destroy
        end
      end
    end
  end
end
