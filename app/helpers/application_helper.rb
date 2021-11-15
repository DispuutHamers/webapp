module ApplicationHelper
  include Pagy::Frontend

  def current_user?(user)
    current_user.id == user.id
  end

  def lid?
    return unless logged_in?

    redirect_to root_path, notice: "Je account mag niet bij deze resource." unless current_user&.lid? || current_user&.olid?
  end

  def ilid?
    return unless logged_in?

    redirect_to root_path, notice: "Je account mag niet bij deze resource." unless current_user&.active?
  end
end
