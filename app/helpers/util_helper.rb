require 'net/http'
require 'uri'

# Takes over work from controllers and puts logic in a single place
module UtilHelper
  def save_object(obj)
    if obj.save
      flash[:success] = "#{obj.class.name} succesvol aangemaakt."
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def self.scramble_string(string)
    return if string.length < 1
    string << " Overigens ben ik van mening dat correct taalgebruik zeer belangrijk is!"
  end

  def update_object(obj, obj_params)
    if obj.class.name == "User" # Hacky de user afzonderen
      if obj.update_with_password(obj_params)
        flash[:success] = "Je profiel is geupdate"
        redirect_to obj
      else
        flash[:error] = "Je profiel is niet geupdate"
        redirect_to obj
      end

    elsif obj.update(obj_params)
      yield if block_given?
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
    allowed_user = (obj.user_id == current_user.id or current_user.admin?)
    if allowed_user and obj.update(obj_params)
      flash[:success] = 'Succesvol bijgewerkt.'
      redirect_to obj
    else
      flash[:error] = "Er ging iets stuk"
      redirect_to root_path
    end
  end

  def delete_object(obj)
    obj.destroy
    flash[:success] = "Succesvol verwijderd"
    redirect_to root_path
  end

  def do_signup(user)
    event = Event.find(params[:signup][:event_id])
    user.signup(event, params[:signup][:status], params[:signup][:reason])
  end

  # Tasks that are run automatically (with cron) and are monitored

  def self.create_drink
    title = 'Dispuutsborrel'
    location = 'De Vluchte'
    description = 'Woensag is een speciale dag. Voor de oude Germanen betekent dat \'de dag van Wodan\', hun oppergod.'\
                'Voor de werkenden betekent het dat de werkweek doormidden is en naar het weekend uitgekeken kan worden.' \
                'Voor ons betekent het een gezellige avond, vol speciaalbier en vertier. Daarom wordt van ieder verwacht dat ze hun overhemd aandoen en met gezwinde spoed naar de Vluchte gaan!'
    date = 'Time.now + 1.weeks + 9.hours' # Next wednesday, 21:00h
    end_time = 'Time.now + 1.weeks + 14.hours' # Next thursday, 02:00h
    deadline = 'Time.now + 1.weeks + 6.hours' # Next wednesday, 18:00h

    Event.new(description: description, attendance: true,  title: title, date: date, end_time: end_time, deadline: deadline, location: location).save

    # Ping healthchecks.io for monitoring purposes
    Net::HTTP.get(URI.parse('https://hc-ping.com/fffa8b9f-1d79-4e3b-89a3-1f704c145138'))
  end

  def self.remind_drink
    event = Event.where(attendance: true).last
    signed_users = event.users
    unsigned_users = User.leden - signed_users
    unsigned_users.each { |user| UserMailer.mail_event_reminder(user, event).deliver }

    # Ping healthchecks.io for monitoring purposes
    Net::HTTP.get(URI.parse('https://hc-ping.com/fed0752c-e524-4af6-907e-23bd47336eb9'))
  end

  def self.cleanup
    User.leden.each{ |u| UsersHelper.update_weight_for(u) }
    User.leden.each{ |u| UsersHelper.sunday_ratio_for(u) }
    Beer.all.each{ |b| b.update_cijfer }
    Blogitem.unscoped.where("title is NULL OR length(title) < 1").delete_all

    # Ping healthchecks.io for monitoring purposes
    Net::HTTP.get(URI.parse('https://hc-ping.com/3a65b459-ea8f-4f0c-89ce-c8f1b750c5fb'))
  end
end
