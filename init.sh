#!/bin/bash

until pg_isready -h db -U $DB_USERNAME; do
  echo "Waiting for PGSQL..."
  sleep 2
done

psql -h db -U $DB_USERNAME -d postgres -c "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;"

echo "Creating DB structure..."
psql -h db -U $DB_USERNAME -d $DB_DATABASE -f /testbusapi.sql

echo "Importing demo data..."
psql -h db -U $DB_USERNAME -d $DB_DATABASE -f /insert.sql

echo "Migrating..."
php artisan migrate --force

echo "Starting server..."
php artisan serve --host=0.0.0.0 --port=8000
