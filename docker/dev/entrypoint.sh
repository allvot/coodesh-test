#!/bin/bash

bundle install

bundle exec rails db:reset

rm -f tmp/pids/server.pid

Spinup the application and sidekiq
bundle exec rails s -b 0.0.0.0
