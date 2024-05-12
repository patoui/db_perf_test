#!/bin/bash

if ! docker exec -it mysql8036 test -d "/tmp/data"; then
  echo "Starting to copy the test data..."
  docker cp data mysql8036:/tmp
  echo "Finished copying the test data"
fi

docker exec -w /tmp/data -it mysql8036 sh -c "mysql -ppassword < init_mysql.sql"

docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/departments.tsv' INTO TABLE departments FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/employees.tsv' INTO TABLE employees FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/dept_emp.tsv' INTO TABLE dept_emp FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/dept_manager.tsv' INTO TABLE dept_manager FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/titles.tsv' INTO TABLE titles FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/salaries1.tsv' INTO TABLE salaries FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
docker exec -w /tmp/data mysql8036 mysql -uroot -ppassword -Demployees -e "LOAD DATA INFILE '/tmp/data/salaries2.tsv' INTO TABLE salaries FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
