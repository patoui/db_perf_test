#!/bin/bash

if ! docker exec -it mysql57 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data mysql57:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it mysql57 sh -c "mysql -ppassword < init_mysql.sql"

docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/departments.tsv' INTO TABLE departments FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/employees.tsv' INTO TABLE employees FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/dept_emp.tsv' INTO TABLE dept_emp FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/dept_manager.tsv' INTO TABLE dept_manager FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/titles.tsv' INTO TABLE titles FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql57 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/salaries.tsv' INTO TABLE salaries FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
