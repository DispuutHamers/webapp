module ParamsHelper
  def api_key_params
    params.require(:api_key).permit(:name)
  end

  def quote_params
    params.require(:quote).permit(:user_id, :text, :reporter)
  end

  def brew_params
    params.require(:brew).permit(:description, :description, :recipe_id)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :beer, :description, :description)
  end

  def blog_params
    params.require(:blogitem).permit(:title, :body, :public, :body, :tags_as_string)
  end

  def signup_params
    params.require(:signup).permit(:event_id, :status, :reason)
  end

  def external_signup_params
    params.require(:external_signup).permit(:first_name, :last_name, :email, :note, :invitation_code)
  end

  def review_params
    params.require(:review).permit(:user_id, :beer_id, :description, :description, :rating, :proefdatum)
  end

  def micropost_params
    params.require(:quote).permit(:user_id, :text)
  end

  def event_params
    params.require(:event).permit(:end_time, :deadline, :public, :title, :date, :location, :description, :usergroup_id)
  end

  def beer_params
    params.require(:beer).permit(:name, :kind, :picture, :percentage, :country, :brewer, :URL)
  end

  def news_params
    params.require(:news).permit(:cat, :body, :title, :image, :date)
  end

  def meeting_params
    params.require(:meeting).permit(:agenda, :onderwerp, :date, :notes, :chairman_id, :secretary_id, user_ids: [])
  end

  def sticker_params
    params.require(:sticker).permit(:lat, :lon, :notes, :image)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :batch, :anonymous)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def usergroup_params
    params.require(:usergroup).permit(:name, :logo, :signal_url)
  end

  def public_page_params
    params.require(:public_page).permit(:content, :title, :public)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:update, keys: [:name, :anonymous, :batch])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
