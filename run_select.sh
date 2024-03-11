#/bin/bash

mysql -uroot -ppassword -h127.0.0.1 -P 3312 -A employees -e "select * from salaries where from_date > '2000-01-11' and to_date < '2023-06-12'"
