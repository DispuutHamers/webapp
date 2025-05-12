#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
if [ -f tmp/pids/server.pid ]; then
  echo "Removing pre-existing server.pid..."
  rm tmp/pids/server.pid
fi

echo "Apply database migrations..."
bundle exec rails db:migrate

echo "Starting server..."
bundle exec puma -C config/puma.rb
