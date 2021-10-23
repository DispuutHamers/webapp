class TrailPresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
  include UsersHelper

  def initialize(trail)
    @trail = trail
  end

  def username
    user&.name || "webapp"
  end

  def image
    if user
      gravatar_for(user, { class: "h-6 w-6 rounded-full" })
    else
      image_tag('hamer_square_256.png', class: 'h-6 w-6 rounded-full')
    end
  end

  def message
    case @trail.event
    when "destroy"
      "verwijderde #{type}"
    when "update"
      updated_message
    else
      created_message
    end
  end

  def created_message
    case @trail.item_type
    when "Quote"
      "Citeerde #{@trail.item.user.name}"
    when "Blogitem"
      "blogte #{@trail.item.title}"
    when "Signup"
      status = @trail.item.status ? "in" : "uit"
      "schreef zich #{status} voor #{@trail.item.event.title}"
    when "ActionText::RichText"
      "maakte opgemaakte tekst"
    else
      "maakte #{type}"
    end
  end

  def updated_message
    case @trail.item_type
    when "Quote"
      "wijzigde een citaat van #{@trail.item.user.name}"
    when "Blogitem"
      "schreef aan #{@trail.item.title}"
    when "Signup"
      "wijzigde zijn inschrijving voor #{@trail.item.event.title}"
    when "ActionText::RichText"
      "wijzigde opgemaakte tekst"
    else
      "wijzigde #{type}"
    end
  end

  private

  def user
    User.find(@trail.whodunnit) if @trail.whodunnit
  end

  def type
    @trail.item_type.downcase
  end

  def link
    case @trail.item_type
    when "Quote"
      root_path
    when "ActionText::RichText"
      @trail.item.record
    else
      @trail.item
    end
  end
end
