module ParamsHelper
  def signup_params
    params.require(:signup).permit(:event_id, :status, :reason)
  end

  def review_params
    params.require(:review).permit(:user_id, :beer_id, :description, :rating, :proefdatum)
  end

  def micropost_params
    params.require(:quote).permit(:user_id, :text)
  end

  def event_params
    params.require(:event).permit(:end_time, :deadline, :user_id, :beschrijving, :title, :date, :location)
  end

  def motion_params
    params.require(:motion).permit(:motion_type, :subject, :content)
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

  def arm_params
    params.requre(:arm).permit(:lat, :lon)
  end

  def nickname_params
    params.require(:nickname).permit(:user_id, :nickname, :description)
  end

  def meeting_params
    params.require(:meeting).permit(:agenda, :notes, :onderwerp, :date)
  end

  def sticker_params
    params.require(:sticker).permit(:lat, :lon, :notes)
  end
  
  def note_params
    params.require(:note).permit(:title, :content)
  end

  def user_params
    params.require(:user).permit(:name, :email, :batch, :password, :password_confirmation, :anonymous)
  end
end
