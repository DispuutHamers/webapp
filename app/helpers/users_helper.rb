module UsersHelper
  def gravatar_for(user, options = {size: 256, class: 'h-6 w-6 rounded-full self-center'})
    return image_tag('hamer_square_256.png', **options) unless user

    gravatar_id = Digest::MD5.hexdigest(user.email&.downcase || 'system')
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}&r=x&d=https%3A%2F%2Fpreviews.123rf.com%2Fimages%2Folesiabilkei%2Folesiabilkei1611%2Folesiabilkei161100112%2F66299032-cheerful-boy-with-disability-at-rehabilitation-center-for-kids-with-special-needs.jpg"
    image_tag(gravatar_url, alt: user.name, class: options[:class])
  end

  def gravatar_for_email(email, options = {size: 256, class: 'h-6 w-6 rounded-full'})
    gravatar_id = Digest::MD5.hexdigest(email&.downcase || 'system')
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}&r=x&d=https%3A%2F%2Fpreviews.123rf.com%2Fimages%2Folesiabilkei%2Folesiabilkei1611%2Folesiabilkei161100112%2F66299032-cheerful-boy-with-disability-at-rehabilitation-center-for-kids-with-special-needs.jpg"
    image_tag(gravatar_url, alt: email, class: options[:class])
  end

  def self.drink_ratio_for(user)
    drinks = Event.where(attendance: true)
                  .where('date > ?', Date.today - 1.year)
                  .where('date > ?', user.lid_since)
                  .where('deadline IS NOT NULL AND deadline < ?', Date.today)
    total = 0.0
    attended = 0.0
    drinks.each do |drink|
      total += 1.0
      attended += 1.0 if drink.signups.where(user_id: user.id).present?
    end

    ratio = (attended / total) * 100
    user.update(drink_ratio: ratio) unless ratio.nan?
  end

  def self.missed_drinks_for(user)
    return nil unless user.lid?

    date = user.lid_since
    drinks = Event.where(attendance: true).where('created_at > ?', date)
    unattended = []
    drinks.each do |drink|
      unattended << drink if drink.signups.where(user_id: user.id).blank?
    end

    unattended
  end

  def self.update_weight_for(user)
    weight = user.reviews.average(:rating).to_f
    user.update(weight: weight)
  end

  def unreviewed_beer_for(user)
    urev_beers = Beer.all
    user.beers.each do |beer|
      urev_beers -= [beer]
    end

    urev_beers
  end
end
