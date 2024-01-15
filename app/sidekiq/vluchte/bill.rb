class Vluchte::Bill
  include Sidekiq::Job

  def perform(data)
    not_found = []
    data['bill'].each do |user_bill|
      user = User.find_by(email: user_bill['user']['email'])

      unless user&.active?
        not_found << user_bill['user']['email']
        next
      end

      UserMailer.mail_vluchte_bill(user_bill, user).deliver
    end

    not_found
  end
end
