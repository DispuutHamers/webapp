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
      ActionController::Base.helpers.image_tag('hamer_square_256.png', class: 'h-6 w-6 rounded-full')
    end
  end

  def message
    case @trail.event
    when "create"
      created_message
    when "update"
      updated_message
    else
      destroyed_message
    end
  end

  def created_message
    case @trail.item_type
    when "Quote"
      "citeerde #{user_name}"
    when "Blogitem"
      "blogte #{@trail.item.title}"
    when "Event"
      "maakte activiteit"
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
      "wijzigde een citaat van #{user_name}"
    when "Blogitem"
      "schreef aan #{@trail.item.title}"
    when "Event"
      "wijzigde activiteit"
    when "Signup"
      "wijzigde zijn inschrijving voor #{@trail.item.event.title}"
    when "ActionText::RichText"
      "wijzigde opgemaakte tekst"
    else
      "wijzigde #{type}"
    end
  end

  def destroyed_message
    "verwijderde #{type}"
  end

  private

  def user
    User.find(@trail.whodunnit) if @trail.whodunnit
  end

  def type
    return "activiteit" if @trail.item_type == "Event"
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

  def user_name
    if @trail.item
      @trail.item.user.name
    elsif @trail.object
      user_id = JSON.parse(@trail.object)['user_id']
      User.find(user_id).name
    else
      # Object is deleted in the meantime
      user_id = JSON.parse(@trail.object_changes)['user_id'].last
      User.find(user_id).name
    end
  end
end
