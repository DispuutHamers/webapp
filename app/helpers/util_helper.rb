# Takes over work from controllers and puts logic in a single place
module UtilHelper
  def save_object(obj)
    if obj.save
      flash[:success] = "#{obj.class.name} succesvol aangemaakt."
      redirect_to obj
    else
      flash.now[:error] = obj.errors.full_messages.join('<br>')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
  end

  def self.scramble_string(string)
    return if string.empty?

    string << ' Overigens ben ik van mening dat correct taalgebruik zeer belangrijk is!'
  end

  def update_object(obj, obj_params)
    if obj.update(obj_params)
      yield if block_given?
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash.now[:error] = obj.errors.full_messages.join('<br>')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
    allowed_user = (obj.user_id == current_user.id or current_user.admin?)
    if allowed_user and obj.update(obj_params)
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash.now[:error] = obj.errors.full_messages.join('<br>')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
  end

  def delete_object(obj)
    obj.destroy
    flash[:success] = 'Succesvol verwijderd'
    redirect_to root_path
  end

  # Tasks that are run automatically (with cron) and are monitored

  def self.create_drink
    title = 'Dispuutsborrel'
    location = 'De Vluchte'
    description = 'Woensdag is een speciale dag. Voor de oude Germanen betekent dat \'de dag van Wodan\', hun oppergod. ' \
                'Voor de werkenden betekent het dat de werkweek doormidden is en naar het weekend uitgekeken kan worden. ' \
                'Voor ons betekent het een gezellige avond, vol speciaalbier en vertier. Daarom wordt van ieder verwacht dat ' \
                'ze hun overhemd aandoen en met gezwinde spoed naar de Vluchte gaan!'
    date = (Time.now + 1.weeks).beginning_of_day + 20.hours # Next wednesday, 20:00h
    end_time = (Time.now + 1.weeks + 1.days).beginning_of_day + 2.hours # Next thursday, 02:00h
    deadline = (Time.now + 1.weeks).beginning_of_day + 15.hours # Next wednesday, 15:00h

    Event.new(description: description, attendance: true, title: title, date: date, end_time: end_time, deadline: deadline, location: location).save

    # Ping Honeybadger for monitoring purposes
    Net::HTTP.get(URI.parse('https://api.honeybadger.io/v1/check_in/P0Imk4'))
  end

  def self.remind_drink
    event = Event.where(attendance: true).last
    signed_users = event.users
    unsigned_users = User.leden - signed_users
    unsigned_users.each { |user| UserMailer.mail_event_reminder(user, event).deliver_later(queue: "low") }

    # Ping Honeybadger for monitoring purposes
    Net::HTTP.get(URI.parse('https://api.honeybadger.io/v1/check_in/RYI9a8'))
  end

  def self.cleanup
    User.intern.each { |u| UsersHelper.update_weight_for(u) }
    User.leden.each { |u| UsersHelper.drink_ratio_for(u) }
    Beer.all.each(&:update_cijfer)
    Blogitem.unscoped.where('title is NULL OR length(title) < 1').delete_all

    # Ping Honeybadger for monitoring purposes
    Net::HTTP.get(URI.parse('https://api.honeybadger.io/v1/check_in/oWI2ay'))
  end
end
