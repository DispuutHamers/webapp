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
      "citeerde #{quote.user.name}"
    when "Blogitem"
      "blogte '#{blog.title}'"
    when "Event"
      "maakte activiteit '#{event.title}'"
    when "Beer"
      "maakte bier '#{beer.name}'"
    when "Review"
      "reviewde '#{review.beer.name}'"
    when "ActionText::RichText"
      "maakte beschrijving #{action_text_title}"
    else
      "maakte #{type}"
    end
  end

  def updated_message
    case @trail.item_type
    when "Quote"
      "wijzigde een citaat van #{quote.user.name}"
    when "Blogitem"
      "schreef aan '#{blog.title}'"
    when "Event"
      "wijzigde activiteit '#{event.title}'"
    when "Signup"
      status = @trail.item.status ? "in" : "uit"
      "schreef zich #{status} voor '#{@trail.item.event.title}'"
    when "Beer"
      "wijzigde bier '#{beer.name}'"
    when "Review"
      "wijzigde review van '#{review.beer.name}'"
    when "ActionText::RichText"
      "wijzigde beschrijving #{action_text_title}"
    else
      "wijzigde #{type}"
    end
  end

  def destroyed_message
    case @trail.item_type
    when "Quote"
      "verwijderde citaat van #{quote.user.name}"
    when "Blogitem"
      "verwijderde blog '#{blog.title}'"
    when "Event"
      "verwijderde activiteit '#{event.title}'"
    when "Beer"
      "verwijderde bier '#{beer.name}'"
    when "Review"
      "verwijderde een review van '#{review.beer.name}'"
    when "ActionText::RichText"
      "verwijderde beschrijving #{action_text_title}"
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
    type = JSON.parse(@trail.object)['record_type'].downcase

    return "activiteit" if type == "event"
    type
  end

  def action_text_title
    unless @trail.item&.record
      return "van een #{action_text_type}" if @trail.object
      return nil
    end

    "van " + case @trail.item.record_type
             when "Blogitem"
               "blogitem '#{blog.title}'"
             when "Event"
               "activiteit '#{event.title}'"
             when "Review"
               "een review van #{review.beer.name}"
             else
               "iets?"
             end
  end

  def quote
    lookup_object(Quote)
  end

  def event
    lookup_object(Event)
  end

  def beer
    lookup_object(Beer)
  end

  def review
    lookup_object(Review)
  end

  def blog
    lookup_object(Blogitem)
  end

  def lookup_object(model)
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
      model.with_deleted.find(model_id)
    else
      # Delete
      model_id = JSON.parse(@trail.object_changes)['id'].last
      model.with_deleted.find(model_id)
    end
  end
end
