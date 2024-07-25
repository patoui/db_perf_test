help:
	    @echo ""
	    @echo "Makefile commands:"
	    @echo ""
	    @echo "DOCKER"
	    @echo ""
	    @echo "start            - Start the docker containers                     - ex: make start"
	    @echo "stop             - Stop the docker containers                      - ex: make stop"
	    @echo "list             - List the docker containers                      - ex: make list"
	    @echo ""
	    @echo "DATABASE"
	    @echo ""
	    @echo "load             - Load employee sample data                       - ex: make load"
	    @echo "cli5744          - Access the MySQL 5.7.44 CLI client              - ex: make cli5744"
	    @echo "cli8036          - Access the MySQL 8.0.36 CLI client              - ex: make cli8036"
	    @echo "cli163           - Access the PostgreSQL 16.36 CLI client          - ex: make cli163"
	    @echo ""
	    @echo "SERVER"
	    @echo ""
	    @echo "server5744      - Access the MySQL 5.7.44 CLI client              - ex: make server5744"
	    @echo "server8036      - Access the MySQL 8.0.36 CLI client              - ex: make server8036"
	    @echo "server163       - Access the PostgreSQL 16.36 CLI client          - ex: make server163"
	    @echo ""

start:
	docker compose up -d

stop:
	docker compose down

restart:
	docker compose up --remove-orphans --build --force-recreate -d

list:
	docker ps

load:
	./load.sh

cli5744:
	docker exec -it mysql5744 mysql -uroot -ppassword -A employees

cli8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees

cli163:
	docker exec -it postgres163 psql -U postgres -d employees

server5744:
	docker exec -it mysql5744 /bin/bash

server8036:
	docker exec -it mysql8036 bash

server163:
	docker exec -it postgres163 /bin/bash

enable_log_5744:
	docker exec -it mysql40 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log_file = '/var/lib/mysql/general_log.log'; SET GLOBAL general_log = 'ON';"

disable_log_5744:
	docker exec -it mysql40 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log = 'OFF';"

enable_log_8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log_file = '/var/lib/mysql/general_log.log'; SET GLOBAL general_log = 'ON';"

disable_log_8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log = 'OFF';"

benchmark_read_5744:
	sysbench benchmark_read.lua --mysql-user=root --mysql-host=0.0.0.0 --mysql-port=3357 --mysql-password=password --mysql-db=employees --report-interval=5 --events=0 --time=10 run

benchmark_read_8036:
	sysbench benchmark_read.lua --mysql-user=root --mysql-host=0.0.0.0 --mysql-port=3380 --mysql-password=password --mysql-db=employees --report-interval=5 --events=0 --time=10 run

