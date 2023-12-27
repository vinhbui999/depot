#!/bin/sh

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
 
echo "RAILS_ENV: $RAILS_ENV"

if [ "$RAILS_ENV" = "development" ]; then
  bin/dev
else
  rails s -p 3000 -b '0.0.0.0'
fi
