# Entry point for the webhook resource
class VluchteController < ApplicationController
  before_action :validate, only: [:post]

  def post
    data = JSON.parse(request.body.read)
    not_found = []
    data.each do |bill|
      user = User.find_by(email: bill['user']['email'])
      unless user&.active?
        not_found << bill['user']['email']
        next
      end

      UserMailer.mail_vluchte_bill(bill, user).deliver
    end

    if not_found.empty?
      response(200, 'OK')
    else
      response(200, "OK, but #{not_found.join(', ')} not found")
    end
  end

  private

  def response(code, message)
    render json: { code: code, message: message }, status: code
  end

  def validate
    if params[:secret] != Rails.application.secrets.vluchte_webhook
      return response(401, 'Unauthorized')
    end

    if request.body.read.nil?
      return response(400, 'No body')
    end

    true
  end
end
