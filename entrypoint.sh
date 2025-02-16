#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "Precompiling assets..."
bundle exec rails assets:precompile

echo "Apply database migrations..."
bundle exec rails db:migrate

echo "Writing schedule..."
bundle exec whenever -w

echo "Starting server..."
bundle exec puma -C config/puma.rb
