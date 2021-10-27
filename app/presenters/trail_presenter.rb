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

  def has_link
    # Todo: when object is deleted
    @trail.event != "destroy"
  end

  def link
    if @trail.item # update
      # Rich text
      if @trail.item_type == "ActionText::RichText"
        if @trail.item&.record
          return @trail.item.record
        end
      end
      return @trail.item
    end

    # Everything else
    root_path
  end

  private

  def created_message
    case @trail.item_type
    when "Quote"
      "citeerde #{user_name}"
    when "Blogitem"
      "blogte #{blog.title}"
    when "Event"
      "maakte activiteit #{event.title}"
      # when "Signup" --> Alleen update wordt gebruikt momenteel
    when "Beer"
      "maakte bier #{beer.name}"
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
      "schreef aan #{blog.title}"
    when "Event"
      "wijzigde activiteit #{event.title}"
    when "Signup"
      status = @trail.item.status ? "in" : "uit"
      "schreef zich #{status} voor #{@trail.item.event.title}"
    when "Beer"
      "wijzigde bier #{beer.name}"
    when "ActionText::RichText"
      "wijzigde opgemaakte tekst"
    else
      "wijzigde #{type}"
    end
  end

  def destroyed_message
    "verwijderde #{type}"
  end

  def user
    User.find_by_id(@trail.whodunnit) if @trail.whodunnit
  end

  def type
    case @trail.item_type
    when "Event"
      "activiteit"
    when "Beer"
      "bier"
    when "Blogitem"
      "blog"
    when "ActionText::RichText"
      "opgemaakte tekst"
    else
      @trail.item_type.downcase
    end
  end

  def user_name
    if @trail.item # Create
      @trail.item.user.name
    elsif @trail.object # Update
      user_id = JSON.parse(@trail.object)['user_id']
      User.find(user_id).name
    else
      # Delete
      user_id = JSON.parse(@trail.object_changes)['user_id'].last
      User.find(user_id).name
    end
  end

  def event
    if @trail.item # Create
      @trail.item
    elsif @trail.object # Update
      event_id = JSON.parse(@trail.object)['id']
      Event.with_deleted.find(event_id)
    else
      # Delete
      event_id = JSON.parse(@trail.object_changes)['id'].last
      Event.with_deleted.find(event_id)
    end
  end

  def beer
    if @trail.item # Create
      @trail.item
    elsif @trail.object # Update
      beer_id = JSON.parse(@trail.object)['id']
      Beer.with_deleted.find(beer_id)
    else
      # Delete
      beer_id = JSON.parse(@trail.object_changes)['id'].last
      Beer.with_deleted.find(beer_id)
    end
  end

  def blog
    if @trail.item # Create
      @trail.item
    elsif @trail.object # Update
      blog_id = JSON.parse(@trail.object)['id']
      Blogitem.with_deleted.find(blog_id)
    else
      # Delete
      blog_id = JSON.parse(@trail.object_changes)['id'].last
      Blogitem.with_deleted.find(blog_id)
    end
  end
end
