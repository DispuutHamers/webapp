# Takes over work from controllers and puts logic in a single place
module UtilHelper
  def save_object(obj, type = nil, push = nil)
    if obj.save
      update_app("{ data: { #{type}: #{obj.to_json} } }") if push
      flash[:success] = "#{type.capitalize} succesvol aangemaakt."
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def update_object(obj, obj_params)
    if obj.update(obj_params)
      yield
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
    allowed_user = (obj.user == current_user or current_user.admin?)
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
    if (event.deadline > Time.now and !!verify_signup(event))
      user.sign!(event, extracted_params[:status], extracted_params[:reason])
      return event
    else
      return nil
    end
  end

  private 
  def verify_signup(event)
    extracted_params = params[:signup]
    if (event.attendance and "0" == extracted_params[:status])
      return extracted_params[:reason].length > 5
    else
      return true
    end
  end
end
