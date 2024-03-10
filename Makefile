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

cli12:
	docker exec -it mysql12 mysql -uroot -ppassword

cli40:
	docker exec -it mysql40 mysql -uroot -ppassword
