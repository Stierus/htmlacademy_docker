#!make
include .env

PREFIX		 		= ${PROJECT_PREFIX}
BIN_DOCKER 			= 'docker'
BIN_DOCKER_COMPOSE 	= 'docker-compose'



help:
	@echo "\nDocker management. Please, make sure you have .env file.\n"
	@echo "Usage: \n\
\033[0mmake build                            \033[0m  Casts docker-compose build.\n\
\033[0mmake up                               \033[0m  Casts docker-compose up -d.\n\
\033[0mmake down                             \033[0m  Casts docker-compose down.\n\
\n\
\033[0mmake start                            \033[0m  Casts docker-compose up.\n\
\033[0mmake restart                          \033[0m  Casts down, build and up commabnds.\n\
\n\
\033[0mmake logs                             \033[0m  Casts docker-compose logs -f.\n\
\033[0mmake composer-install                 \033[0m  Casts composer install in app container.\n\
\033[0mmake migrate                          \033[0m  Casts migrations:migrate witiout xdebug in app container.\n\
\n\
\033[0mmake <container_name> <commands_chain>\033[0m  Casts docker exec -it <container_name> <commands_chain>. Example: make app bash - enter in ${PROJECT_PREFIX}-app container with bash.\n\
"
#\033[0mmake clear_all                        \033[0m  Casts clear_containers and clear_images command.\n\
#\033[0mmake clear_containers                 \033[0m  Stops and removes all project containers.\n\
#\033[0mmake clear_images                     \033[0m  Removes all project images.\n\

#clear_all: clear_containers clear_images
#
#clear_containers:
#	@echo "\n\033[0mStart removing environment containers...\033[0m\n"
#	@$(BIN_DOCKER) stop `$(BIN_DOCKER) ps -a -q | grep $(PREFIX)` && $(BIN_DOCKER) rm `$(BIN_DOCKER) ps -a -q`
#
#clear_images:
#	@echo "\n\033[0mStart removing environment images...\033[0m\n"
#	@$(BIN_DOCKER) rmi -f `$(BIN_DOCKER) images -q | grep $(PREFIX)`


down:
	@echo "\n\033[0mTearing down environment...\033[0m\n"
	@$(BIN_DOCKER_COMPOSE) down

build:
	@echo "\033[0mStart build environment...\033[0m"
	@$(BIN_DOCKER_COMPOSE) build

up:
	@echo "\n\033[0mStarting... --------------------------------------\033[0m\n"
	@$(BIN_DOCKER_COMPOSE) pull
	@$(BIN_DOCKER_COMPOSE) up -d


restart:
	@echo "\n\033[0mRestarting... --------------------------------------\033[0m\n"
	@make down && make build && make up

start:
	@echo "\n\033[0mStarting... --------------------------------------\033[0m\n"
	@$(BIN_DOCKER_COMPOSE) up


logs:
	@$(BIN_DOCKER_COMPOSE) logs -f


composer-install:
	@echo "\n\033[0mInstalling composer packages... --------------------------------------\033[0m\n"
	@$(BIN_DOCKER) exec -it $(PREFIX)-app composer install

%:
	$(BIN_DOCKER) exec -it $(PREFIX)-$@ $(filter-out $@, $(MAKECMDGOALS))