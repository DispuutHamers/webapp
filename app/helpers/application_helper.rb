module ApplicationHelper

  def markdown(text)
    if text
      markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new
      )
      markdown.render(text).html_safe
    end
  end

  def current_user?(user) 
    current_user.id == user.id
  end

  def lid? 
    redirect_to root_path unless current_user&.lid? || current_user&.olid? 
  end

  def ilid?
    redirect_to root_path unless current_user&.active? 
  end

  def brewer? 
    redirect_to root_path unless current_user&.brouwer?
  end

end
