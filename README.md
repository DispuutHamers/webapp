# Hamers zonder Sikkel
webapp voor https://www.zondersikkel.nl/

# Prerequisites
- [Ruby 3.4.1](.ruby-version)
- [Node.js 16 LTS](https://nodejs.org/en/)
- [Yarn](https://yarnpkg.com/)

# Setting up a development environment 
- Install the version of ruby specified in .ruby-version (protip: use rvm or rbenv)
- Install dependecies by running `bundle install` in the root of the repository
- Install javascript dependencies by running `yarn install` 
- Initialeze the database schema by running `rails db:setup`
- Start a development server by running `rails s`
- You can now connect to localhost:3000 to see a local instance of the web app 
- credentials for logging in locally are: dev@zondersikkel.nl:12345678

# Deploying to production
- The app is deployed with Kamal. 
- Automatic deployments are set up for the master branch.
