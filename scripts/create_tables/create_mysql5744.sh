#!/bin/bash

if ! docker exec -it mysql5744 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data mysql5744:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it mysql5744 sh -c "mysql -ppassword < init_mysql.sql"
