#/bin/bash

if [ "$1" == "" ]; then
  echo Usage: $0 domain
  echo i.e.: www.gravatar.com
  exit 0
fi

node_modules/casperjs/bin/casperjs main.js $1

