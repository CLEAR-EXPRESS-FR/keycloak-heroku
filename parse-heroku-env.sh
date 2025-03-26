#!/bin/bash
set -e

echo "🔧 Parsing Heroku DATABASE_URL into Keycloak environment variables..."

if [ -n "$DATABASE_URL" ]; then
  regex="^postgres://([^:]+):([^@]+)@([^:]+):([0-9]+)/(.+)$"
  if [[ $DATABASE_URL =~ $regex ]]; then
    export KC_DB=postgres
    export KC_DB_URL="jdbc:postgresql://${BASH_REMATCH[3]}:${BASH_REMATCH[4]}/${BASH_REMATCH[5]}"
    export KC_DB_USERNAME="${BASH_REMATCH[1]}"
    export KC_DB_PASSWORD="${BASH_REMATCH[2]}"
    echo "✅ Parsed DATABASE_URL:"
    echo " - KC_DB_URL=$KC_DB_URL"
    echo " - KC_DB_USERNAME=$KC_DB_USERNAME"
  else
    echo "❌ Failed to parse DATABASE_URL=$DATABASE_URL"
    exit 1
  fi
else
  echo "⚠️ DATABASE_URL not set, using default Keycloak DB config"
fi
