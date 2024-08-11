#!/bin/bash

if ! docker exec -it postgres163 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data postgres163:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it postgres163 psql -U postgres -c "DROP DATABASE IF EXISTS employees;"
docker exec -w /tmp/data -it postgres163 psql -U postgres -c "CREATE DATABASE employees;"

docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -f init_pgsql.sql
