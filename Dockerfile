FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y curl vim nano build-essential nodejs default-libmysqlclient-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
