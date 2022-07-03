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
      if @trail.item_type == "ActionText::RichText"
        return nil if @trail.item.record_type == "Draft"
        return @trail.item.record if @trail.item&.record
      end
      return @trail.item
    end

    # Everything else
    nil
  end

  def processed_changes
    changes = {}

    @trail.changeset.each do |c, v|
      next if c == 'updated_at' || c == 'created_at' || v.all? { |e| e.blank? }
      # Decrypt quotes
      if c == 'text_ciphertext'
        v = v.map { |q| Quote.decrypt_text_ciphertext(q) }
        c = "tekst"
      end

      changes[c.to_s] = Diffy::Diff.new(v[0], v[1])
    end

    changes
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
      "maakte gebruiker <i>#{lookup_object}</i>"
    when "Usergroup"
      "maakte groep <i>#{lookup_object}</i>"
    when "Chugtype"
      "maakte adtcategorie <i>#{lookup_object.name}</i> - #{lookup_object.amount}ml"
    when "Chug"
      "trok een #{lookup_object.chugtype.name.downcase} die #{lookup_object.secs}.#{sprintf("%02d", lookup_object.milis)}s duurde"
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
    when "Chugtype"
      "wijzigde adtcategorie <i>#{lookup_object.name}</i> - #{lookup_object.amount}ml"
    when "Chug"
      "wijzigde #{lookup_object.chugtype.name.downcase} die #{lookup_object.secs}.#{sprintf("%02d", lookup_object.milis)}s duurde"
    when "ActionText::RichText"
      "wijzigde #{action_text_title}"
    when "User"
      s = "wijzigde profiel"
      s += " van #{lookup_object}" if lookup_object != user
      s
    when "Usergroup"
      "wijzigde groep <i>#{lookup_object}</i>"
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
      "verwijderde gebruiker <i>#{lookup_object}</i>"
    when "Usergroup"
      "verwijderde groep <i>#{lookup_object}</i>"
    when "Chugtype"
      "verwijderde adtcategorie <i>#{lookup_object.name}</i> - #{lookup_object.amount}ml"
    when "Chug"
      "verwijderde #{lookup_object.chugtype.name.downcase} die #{lookup_object.secs}.#{sprintf("%02d", lookup_object.milis)}s duurde"
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
    when "Meeting"
      "notulen"
    when "Draft"
      "conceptnotulen"
    when "Chug"
      "#{lookup_object.chugtype.name.downcase} die #{lookup_object.secs}.#{sprintf("%02d", lookup_object.milis)}s duurde"
    when "Chugtype"
      "adtcategorie <i>#{lookup_object.name}</i> - #{lookup_object.amount}ml"
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
