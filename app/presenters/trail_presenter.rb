class TrailPresenter
  include ActionView::Helpers
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

  private

  def user
    User.find(@trail.whodunnit) if @trail.whodunnit
  end
end
