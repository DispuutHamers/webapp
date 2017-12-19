module Hamers
  class Events < Grape::API
    resources :events do
      desc 'Get all events'
      oauth2
      get do
        Event.all
      end

      desc 'Get a specific event'
      params do
        requires :id, type: Integer, desc: 'Event id'
      end
      route_param :id do
        oauth2
        get do
          Event.find(params[:id])
        end
      end

      desc 'Create an event'
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
    end
  end
end
