# Entry point for the webhook resource
class VluchteController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate, only: [:create]

  def create
    begin
      data = JSON.parse(request.body.read)
      not_found = Vluchte::Bill.perform_async(data)

      puts "Not found: #{not_found}"
      if not_found.empty?
        json_response(200, 'OK')
      else
        json_response(200, "OK, but #{not_found.join(', ')} not found")
      end
    rescue JSON::ParserError => e
      return json_response(400, "Invalid JSON: #{e}")
    end
  end

  private

  def json_response(code, message)
    render json: { message: message }, status: code
  end

  def validate
    return json_response(401, 'Unauthorized') unless params[:secret] == Rails.application.secrets.vluchte_webhook
    return json_response(400, 'No body') if request.body.read.blank?

    true
  end
end
