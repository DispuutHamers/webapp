module UsersHelper

  def gravatar_for(user, options = {size: 50, class: 'gravatar img img-repsonsive'})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    html_class = options[:class]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: html_class)
  end

end
