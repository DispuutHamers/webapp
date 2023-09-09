FROM ruby:3.2.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
