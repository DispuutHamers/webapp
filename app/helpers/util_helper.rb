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
    event = Event.find(params[:signup][:event_id])
    user.signup(event, params[:signup][:status], params[:signup][:reason])
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
