FROM ruby:3.4.1-slim

RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn shared-mime-info \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN corepack enable

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

COPY . /webapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["entrypoint.sh"]
