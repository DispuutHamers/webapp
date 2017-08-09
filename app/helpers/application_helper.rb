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
end
