FROM ruby:3.4.1-slim

RUN apt-get update -qq && apt-get install -y build-essential nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
