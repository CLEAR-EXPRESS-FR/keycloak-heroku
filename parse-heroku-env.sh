#!/bin/bash
set -e

if [ "$DATABASE_URL" != "" ]; then
  echo "Parsing DATABASE_URL: $DATABASE_URL"

  regex='^postgres://([^:]+):([^@]+)@([^:/]+):([0-9]+)/(.+)$'
  if [[ $DATABASE_URL =~ $regex ]]; then
    export KC_DB=postgres
    export KC_DB_URL_HOST=${BASH_REMATCH[3]}
    export KC_DB_URL_PORT=${BASH_REMATCH[4]}
    export KC_DB_URL_DATABASE=${BASH_REMATCH[5]}
    export KC_DB_USERNAME=${BASH_REMATCH[1]}
    export KC_DB_PASSWORD=${BASH_REMATCH[2]}
  fi
fi

exec "$@"
