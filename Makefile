DC=docker compose -f ./srcs/docker-compose.yml
DATA_FOLDER= /home/gvigilan/data

.PHONY: all build up down re fclean prune logs

all: setup build up

setup:
	@if ! grep -q "127.0.0.1 gvigilan.42.fr" /etc/hosts; then \
		echo "127.0.0.1 gvigilan.42.fr" | sudo tee -a /etc/hosts; \
		echo "127.0.0.1 www.gvigilan.42.fr" | sudo tee -a /etc/hosts; \
	fi

build:
	$(DC) build

up:
	@mkdir -p $(DATA_FOLDER)/wordpress
	@mkdir -p $(DATA_FOLDER)/mariadb
	$(DC) up -d

down:
	$(DC) down

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(DATA_FOLDER) || true

re: fclean all

fclean: down clean
	docker system prune -af --volumes

logs:
	docker-compose logs -f
