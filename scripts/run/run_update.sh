#/bin/bash

mysql -uroot -ppassword -h127.0.0.1 -P 3312 -A employees -e "update salaries set salary = 654321 where to_date = '9999-01-01';"
