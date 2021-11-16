class TrailPresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
  include UsersHelper

  def initialize(trail)
    @trail = trail
  end

  def name
    user&.name || "webapp"
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

  def link
    return nil if @trail.event == "destroy"

    if @trail.item
      return @trail.item.record if @trail.item_type == "ActionText::RichText" && @trail.item&.record
      return @trail.item
    end

    # Everything else
    nil
  end

  private

  def created_message
    case @trail.item_type
    when "Quote"
      "citeerde #{lookup_object.user.name}"
    when "Blogitem"
      "blogte <i>#{lookup_object}</i>"
    when "Event", "Beer"
      "maakte <i>#{lookup_object}</i>"
    when "Review"
      "reviewde <i>#{lookup_object.beer.name}</i>"
    when "ActionText::RichText"
      "maakte #{action_text_title}"
    when "User"
      "maakte gebruiker"
    else
      "maakte #{type}"
    end
  end

  def updated_message
    case @trail.item_type
    when "Quote"
      "wijzigde een citaat van #{lookup_object.user.name}"
    when "Blogitem"
      "schreef aan <i>#{lookup_object}</i>"
    when "Event", "Beer"
      "wijzigde <i>#{lookup_object}</i>"
    when "Signup"
      status = lookup_object.status ? "in" : "uit"
      "schreef zich #{status} voor <i>#{lookup_object.event}</i>"
    when "Review"
      "wijzigde een review van <i>#{lookup_object.beer.name}</i>"
    when "ActionText::RichText"
      "wijzigde #{action_text_title}"
    when "User"
      "wijzigde profiel"
    else
      "wijzigde #{type}"
    end
  end

  def destroyed_message
    case @trail.item_type
    when "Quote"
      "verwijderde citaat van #{lookup_object.user.name}"
    when "Blogitem", "Event", "Beer"
      "verwijderde <i>#{lookup_object}</i>"
    when "Review"
      "verwijderde een review van <i>#{lookup_object.beer.name}</i>"
    when "ActionText::RichText"
      "verwijderde #{action_text_title}"
    when "User"
      "verwijderde gebruiker"
    else
      "verwijderde #{type}"
    end
  end

  def user
    User.find_by_id(@trail.whodunnit) if @trail.whodunnit
  end

  def type
    @trail.item_type.downcase
  end

  def action_text_type
    type = JSON.parse(@trail.object)['record_type']

    if type == "Event"
      object_id = JSON.parse(@trail.object)['record_id']
      return "<i>#{type.constantize.with_deleted.find(object_id).title}</i>"
    end

    "een #{type.downcase}"
  end

  def action_text_title
    unless @trail.item&.record
      return "#{action_text_type}" if @trail.object
      return nil
    end

    case @trail.item.record_type
    when "Blogitem"
      "<i>#{lookup_object}</i>"
    when "Event"
      "<i>#{lookup_object}</i>"
    when "Review"
      "een review van <i>#{lookup_object.beer.name}</i>"
    else
      "iets?"
    end
  end

  def lookup_object
    # We are talking about a possibly deleted object,
    # referenced trough a PaperTrail version object
    if defined? @trail.item.record
      return @trail.item.record
    end

    # Normal object
    if @trail.item # Create
      @trail.item
    elsif @trail.object # Update
      model_id = JSON.parse(@trail.object)['id']
      @trail.item_type.constantize.with_deleted.find(model_id)
    else
      # Delete
      model_id = JSON.parse(@trail.object_changes)['id'].last
      @trail.item_type.constantize.with_deleted.find(model_id)
    end
  end
end
