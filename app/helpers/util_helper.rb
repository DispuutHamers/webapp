# Takes over work from controllers and puts logic in a single place
module UtilHelper
  def save_object(obj)
    if obj.save
      flash[:success] = "#{obj.class.name} succesvol aangemaakt."
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def self.scramble_string(string)
    return if string.length < 1
    string << " Overigens ben ik van mening dat correct taalgebruik zeer belangrijk is!"
  end

  def update_object(obj, obj_params)
    if obj.class.name == "User" # Hacky de user afzonderen
      if obj.update_with_password(obj_params)
        flash[:success] = "Je profiel is geupdate"
        redirect_to obj
      else
        flash[:error] = "Je profiel is niet geupdate"
        redirect_to obj
      end

    elsif obj.update(obj_params)
      yield if block_given?
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
    allowed_user = (obj.user_id == current_user.id or current_user.admin?)
    if allowed_user and obj.update(obj_params)
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def delete_object(obj)
    obj.destroy
    flash[:success] = "Succesvol verwijderd"
    redirect_to root_path
  end

  def do_signup(user)
    extracted_params = params[:signup]
    event = Event.find(extracted_params[:event_id])
    if user.sign(event, extracted_params[:status], extracted_params[:reason])
      event
    else
      nil
    end
  end

  def self.remind_zondag
    event = Event.where(attendance: true).last
    signed_users = event.users
    unsigned_users = User.leden - signed_users
    unsigned_users.each { |user| UserMailer.mail_event_reminder(user, event).deliver }
  end

  def self.make_reservation
    event = Event.where(attendance: true).last
    UserMailer.mail_reservation(event)
  end
end
