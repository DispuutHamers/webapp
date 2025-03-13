class ApplicationJob < ActiveJob::Base
  before_perform do |job|
    puts "Before perform: Preparing to perform #{job.class} with arguments #{job.arguments}"
  end

  after_perform do |job|
    puts "After perform: Finished performing #{job.class}"
  end
end
