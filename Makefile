NAME = inception
DOCKER = sudo docker
COMPOSE = $(DOCKER)-compose

all: $(NAME)

$(NAME):
	$(COMPOSE) --env-file srcs/.env -f srcs/docker-compose.yml up --build

clean:
	$(DOCKER) system prune -af
	$(DOCKER) volume rm `sudo docker volume ls -q`

re: clean
	make -C ./ all

.PHONY: all clean re

