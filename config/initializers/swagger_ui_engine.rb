SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    v3: 'https://zondersikkel.nl/api/v3/swagger_doc'
  }

  config.model_rendering = 'model'
  config.validator_enabled = true

end
