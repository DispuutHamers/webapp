module ParamsHelper

  def quote_params
    params.require(:quote).permit(:user_id, :text, :reporter)
  end

  def photo_params
    params.require(:blogphoto).permit(:image, :blogitem_id, :description)
  end

  def brew_params
    params.require(:brew).permit(:description, :actiontext_description, :recipe_id)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :beer, :description, :actiontext_description)
  end

  def blog_params
    params.require(:blogitem).permit(:title, :body, :public, :actiontext_body)
  end

  def signup_params
    params.require(:signup).permit(:event_id, :status, :reason)
  end

  def external_signup_params
    params.require(:external_signup).permit(:first_name, :last_name, :email, :note, :invitation_code)
  end

  def review_params
    params.require(:review).permit(:user_id, :beer_id, :description, :rating, :proefdatum)
  end

  def micropost_params
    params.require(:quote).permit(:user_id, :text)
  end

  def event_params
    params.require(:event).permit(:end_time, :deadline, :beschrijving, :public, :title, :date, :location, :description)
  end

  def beer_params
    params.require(:beer).permit(:name, :soort, :picture, :percentage, :country, :brewer, :URL)
  end

  def news_params
    params.require(:news).permit(:cat, :body, :title, :image, :date)
  end

  def device_params
    params.require(:device).permit(:device_key)
  end

  def nickname_params
    params.require(:nickname).permit(:user_id, :nickname, :description)
  end

  def meeting_params
    params.require(:meeting).permit(:agenda, :notes, :onderwerp, :date, :actiontext_notes)
  end

  def sticker_params
    params.require(:sticker).permit(:lat, :lon, :notes, :image)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :batch, :current_password, :password, :password_confirmation, :anonymous)
  end

  def configure_permitted_parameters
    #params.require(:user).permit(:name, :email, :batch, :password, :password_confirmation, :anonymous)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:update, keys: [:name, :anonymous, :batch])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
