DC=docker compose -f ./srcs/docker-compose.yml

.PHONY: all build up down re fclean prune logs

all: build up

build:
	$(DC) build

up:
	$(DC) up -d

down:
	$(DC) down

re: fclean all

fclean: down
	docker system prune -af --volumes

logs:
	docker-compose logs -f
