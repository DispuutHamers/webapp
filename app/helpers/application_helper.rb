module ApplicationHelper
  def markdown(text)
    return unless text

    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new
    )

    markdown.render(text).html_safe
  end

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

  def alid?
    return unless logged_in?

    redirect_to root_path, notice: "Je account mag niet bij deze resource." if current_user&.alid?
  end
end
