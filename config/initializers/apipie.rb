Apipie.configure do |config|
  config.app_name                = "Hamers"
  config.api_base_url            = "/api/v2"
  config.doc_base_url            = "/apidocs"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api2/*.rb"
end
