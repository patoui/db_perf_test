help:
	    @echo ""
	    @echo "Makefile commands:"
	    @echo ""
	    @echo "DOCKER"
	    @echo ""
	    @echo "start            - Start the docker containers                     - ex: make start"
	    @echo "stop             - Stop the docker containers                      - ex: make stop"
	    @echo ""
	    @echo "DATABASE"
	    @echo ""
	    @echo "load sample data - Load employee sample data                       - ex: make load"
	    @echo ""

start:
	docker compose up -d

stop:
	docker compose down

list:
	docker ps

load:
	./load.sh

cli40:
	docker exec -it mysql40 mysql -uroot -ppassword -A employees

cli8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees

server8036:
	docker exec -it mysql8036 /bin/bash

enable_log_40:
	docker exec -it mysql40 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log_file = '/var/lib/mysql/general_log.log'; SET GLOBAL general_log = 'ON';"

disable_log_40:
	docker exec -it mysql40 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log = 'OFF';"

enable_log_8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log_file = '/var/lib/mysql/general_log.log'; SET GLOBAL general_log = 'ON';"

disable_log_8036:
	docker exec -it mysql8036 mysql -uroot -ppassword -A employees -e "SET GLOBAL general_log = 'OFF';"

