FROM ruby:3.4.1-slim

ARG GIT_COMMIT_HASH
ARG GIT_COMMIT_COUNT
ENV GIT_COMMIT_HASH=$GIT_COMMIT_HASH
ENV GIT_COMMIT_COUNT=$GIT_COMMIT_COUNT

# sqlite3 is needed for dbconsole, tar is needed for storage backup tar
RUN apt-get update -qq && apt-get install -y cron curl build-essential shared-mime-info sqlite3 tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /webapp
WORKDIR /webapp

COPY Gemfile /webapp/Gemfile
COPY Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

COPY . /webapp

RUN bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

COPY cron-executor.sh /webapp/cron-executor.sh
RUN chmod +x /webapp/cron-executor.sh

EXPOSE 3000
ENTRYPOINT ["entrypoint.sh"]
