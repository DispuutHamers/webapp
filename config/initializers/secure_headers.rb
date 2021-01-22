SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true
  }
  config.csp = {
    default_src: %w('self' www.google.com),
    base_uri: %w('self'),
    img_src: %w(* data:),
    script_src: %w('self' www.google.com www.gstatic.com maps.googleapis.com cdnjs.cloudflare.com),
    style_src: %w('self' 'unsafe-inline' www.gstatic.com cdnjs.cloudflare.com),
  }
end