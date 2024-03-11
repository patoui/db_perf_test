#/bin/bash

mysql -uroot -ppassword -h127.0.0.01 -P 3312 -A employees -e 'delete from salaries where emp_no = 10010; insert into salaries (emp_no, salary, from_date, to_date) values (10010, 111111, now() - interval 1 year, now() + interval 3 month), (10010, 222222, now() - interval 2 year, now() + interval 3 month), (10010, 333333, now() - interval 3 year, now() + interval 3 month);'
