# hamers
webapp voor https://www.zondersikkel.nl/

# Setting up a development environment 
- Install the version of ruby specified in .ruby-version (protip: use rvm or rbenv)
- Install npm and yarn
- Setup a local instance of mysql and add the credentials to `config/database.yml`
- Install dependecies by running `bundle install` in the root of the repository
- Install javascript dependencies by running `yarn install` 
- Initialeze the database schema by running `rails db:setup`
- Start a development server by running `rails s`
- You can now connect to localhost:3000 to see a local instance of the web app 
- credentials for logging in locally are: dev@zondersikkel.nl:12345678
