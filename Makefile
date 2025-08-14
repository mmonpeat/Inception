NAME 	= Inception

DOCKER = docker
RUN = $(DOCKER) run
COMPOSE = $(DOCKER) compose

# Rutes dels volums persistents
HOME_DIR = /home/mmonpeat
DATA_DIR = $(HOME_DIR)/data
DB_DIR = $(DATA_DIR)/wordpress_db
WP_DIR = $(DATA_DIR)/wordpress_cont

# ╔══════════════════════════════════════════════════════════════════════════╗ #  
#                               SOURCES                                        #
# ╚══════════════════════════════════════════════════════════════════════════╝ # 

MANDATORY_PATH = -f ./srcs/docker-compose.yml
ENV_SAMPLE= ./srcs/.env.sample

# ╔══════════════════════════════════════════════════════════════════════════╗ #  
#                               COLORS                                         #
# ╚══════════════════════════════════════════════════════════════════════════╝ #  

RED=\033[0;31m
CYAN=\033[0;36m
GREEN=\033[0;32m
YELLOW=\033[0;33m
WHITE=\033[0;97m
BLUE=\033[0;34m
BOLD=\033[1m
END=\033[0m # No color

# ╔══════════════════════════════════════════════════════════════════════════╗ #  
#                               RULES                                          #
# ╚══════════════════════════════════════════════════════════════════════════╝ # 

all: setup build up

build:
	@$(COMPOSE) $(MANDATORY_PATH) $@ --build

up:
    @$(COMPOSE) $(MANDATORY_PATH) up -d

setup:
	mkdir -p $(WP_DIR)
	mkdir -p $(DB_DIR)
	cp ${ENV_SAMPLE} srcs/.env
	mkdir secrets

it:
	@$(DOCKER) exec -it $(ID) sh

clean:
	@echo
	@$(COMPOSE) $(MANDATORY_PATH) down
	@printf "$(RED)Natejant contenidors i xarxes$(END)\n"
	@$(DOCKER) container prune -f
	@$(DOCKER) network prune --force
	@printf "$(GREEN) $@ COMPLETE! $(END)\n"

fclean: clean
	@echo
	@printf "$(BOLD)🔥 Neteja COMPLETA...$(END)\n"
	@$(COMPOSE) down --volumes --remove-orphans
	@$(DOCKER) system prune -a --volumes --force
	@echo
	@printf "$(GREEN)COMPLETE! $(END)\n"

status:
	@printf "$(BOLD)📊 Estat actual dels serveis$(END)\n"
	@echo "\n----------- Imatges -----------"
	@$(DOCKER) images
	@echo "\n----------- Contenidors --------"
	@$(DOCKER) ps -a
	@echo "\n----------- Xarxes -------------"
	@$(DOCKER) network ls
	@echo "\n----------- Volums Docker ------"
	@$(DOCKER) volume ls
	@echo "\n------ Volums persistents ------"
	@if [ -d "$(DB_DIR)" ]; then echo "host\t$(DB_DIR)"; fi
	@if [ -d "$(WP_DIR)" ]; then echo "host\t$(WP_DIR)"; fi
	@echo "\n----------- Ús de disc ---------"
	@$(DOCKER) system df

logs:
	@printf "$(BOLD)📜 Logs de tots els serveis$(END)\n"
	$(COMPOSE) logs -f

help:
	@echo "\n$(BOLD)🚀 Inception Project Makefile Help$(END)"
	@echo "make all     → Crear volums, construir i arrencar serveis"
	@echo "make build   → Construir només imatges"
	@echo "make up      → Arrencar contenidors"
	@echo "make down    → Aturar contenidors"
	@echo "make clean   → Neteja bàsica (contenidors, xarxes, volums interns)"
	@echo "make fclean  → Neteja total (tot incloent imatges i volums persistents)"
	@echo "make re      → Neteja total i reconstrucció"
	@echo "make status  → Estat actual del sistema"
	@echo "make logs    → Mostrar logs en temps real"


re: fclean up

.PHONY: up setup it clean down logs re logs help status build
