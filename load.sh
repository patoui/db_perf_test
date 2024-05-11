#!/bin/bash

if [ ! -d test_db ]; then
  echo "Retrieving employee sample data"
  git clone git@github.com:datacharmer/test_db.git
fi

if ! docker exec -it mysql40 test -d "/tmp/test_db"; then
  echo "Directory does not exist"
  docker cp test_db mysql40:/tmp
fi

docker exec -w /tmp/test_db -it mysql40 sh -c "mysql -uroot -ppassword < employees.sql"

if ! docker exec -it mysql8036 test -d "/tmp/test_db"; then
  echo "Directory does not exist"
  docker cp test_db mysql8036:/tmp
fi

docker exec -w /tmp/test_db -it mysql8036 sh -c "mysql -uroot -ppassword < employees.sql"

