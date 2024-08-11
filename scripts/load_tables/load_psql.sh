#!/bin/bash

if ! docker exec -it postgres163 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data postgres163:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY departments FROM 'departments.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY employees FROM 'employees.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY dept_emp FROM 'dept_emp.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY dept_manager FROM 'dept_manager.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY titles FROM 'titles.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY salaries FROM 'salaries1.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
docker exec -w /tmp/data -it postgres163 psql -U postgres -d employees -c "\COPY salaries FROM 'salaries2.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);"
