module UsersHelper

  def gravatar_for(user, options = { size: 64, class: 'gravatar img img-responsive img-rounded' })
    options[:size] = 64 unless options[:size]
    options[:class] = "gravatar img img-responsive img-rounded" unless options[:class]
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&r=x&d=monsterid"
    image_tag(gravatar_url, alt: user.name, class: options[:class])
  end

  def self.sunday_ratio_for(user)
    date = user.groups.where(group_id: 4).first.created_at
    drinks = Event.where(attendance: true).where("date > ?", date).where("deadline < ?", Date.today)
    total = 0.0
    sundays = 0.0
    drinks.each do |drink|
      total = total + 1.0
      if drink.signups.where(user_id: user.id).present?
        sundays = sundays + 1.0
      end
    end

    ratio = (sundays / total) * 100
    user.update(sunday_ratio: ratio)
  end

  def missed_drinks_for(user)
    date = user.groups.where(group_id: 4).first.created_at
    drinks = Event.where(attendance: true).where("created_at > ?", date)
    unattended = []
    drinks.each do |drink|
      if drink.signups.where(user_id: user.id).blank?
        unattended << drink
      end
    end

    unattended
  end

  def self.update_weight_for(user)
    cijfer = 0.0
    user.reviews.each do |review|
      cijfer += review.rating
    end

    weight = (cijfer / user.reviews.count) unless user.reviews.empty?
    user.update(weight: weight) if weight
  end

  def unreviewed_beer_for(user)
    urev_beers = Beer.all
    user.beers.each do |beer|
      urev_beers = urev_beers - [beer]
    end

    urev_beers
  end
end
