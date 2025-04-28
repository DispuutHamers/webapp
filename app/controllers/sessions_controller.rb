class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    puts "#{auth_options} #{warden.inspect} #{warden.authenticated?(resource_name)} #{warden.user(resource_name)}"
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      self.resource = resource_class.new(sign_in_params)
      flash.now[:alert] = t('devise.failure.invalid')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
  end
end
