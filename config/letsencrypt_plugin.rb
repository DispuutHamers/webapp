default: &default
  endpoint: 'https://acme-v01.api.letsencrypt.org/'
  email: 'jacko@zondersikkel.nl'
  domain: "<%= ['zondersikkel.nl', 'www.zondersikkel.nl'].join(' ') %>"

  private_key: 'config/key.pem'

  output_cert_dir: 'certificates'

  challenge_dir_name: 'challenge'

production:
  # if 'cert_name' is set, the keys are saved with this name, if not the first string from key 'domain' will be used
  cert_name: 'production'
  <<: *default

development:
  # if 'cert_name' is set, the keys are saved with this name, if not the first string from key 'domain' will be used
  cert_name: 'development'
  <<: *default
#
test:
  # if 'cert_name' is set, the keys are saved with this name, if not the first string from key 'domain' will be used
  cert_name: 'test'
  <<: *default
