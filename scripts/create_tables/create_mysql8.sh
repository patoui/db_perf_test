#!/bin/bash

if ! docker exec -it mysql8036 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data mysql8036:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it mysql8036 sh -c "mysql -ppassword < init_mysql.sql"
