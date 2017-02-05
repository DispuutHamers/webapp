module UtilHelper
  def save_object(obj, type = nil, push = false)
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
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
  end

  def delete_object(obj)
    obj.destroy
    flash[:success] = "Succesvol verwijderd"
    redirect_to root_path
  end
end
