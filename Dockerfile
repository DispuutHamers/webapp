FROM ruby:3.4.1-slim

RUN apt-get update -qq && apt-get install -y cron curl build-essential shared-mime-info \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install NodeJS 16 for webpacker and precompile assets
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN corepack enable

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

COPY . /webapp

RUN bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ARG GIT_COMMIT_COUNT
ARG GIT_COMMIT_HASH
ENV GIT_COMMIT_COUNT=$GIT_COMMIT_COUNT
ENV GIT_COMMIT_HASH=$GIT_COMMIT_HASH

EXPOSE 3000
ENTRYPOINT ["entrypoint.sh"]
