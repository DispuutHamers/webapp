namespace :devise_two_factor do
  desc "Copy devise_two_factor OTP secret from old format to new format"
  task copy_otp_secret_to_rails7_encrypted_attr: [:environment] do
    User.find_each do |user| # find_each finds in batches of 1,000 by default
      otp_secret = user.otp_secret # read from otp_secret column, fall back to legacy columns if new column is empty
      puts "Processing #{user.email}"
      user.update!(otp_secret: otp_secret)
    end
  end
end
