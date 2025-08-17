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
	@$(COMPOSE) $(MANDATORY_PATH) build

up:
	@$(COMPOSE) $(MANDATORY_PATH) up -d

setup:
	@echo "⚙️  Configurant entorn..."

	@if [ ! -d "$(WP_DIR)" ]; then \
		echo "📂 Creant directori WordPress: $(WP_DIR)"; \
		mkdir -p $(WP_DIR); \
	else \
		echo "✅ Directori WordPress ja existeix: $(WP_DIR)"; \
	fi

	@if [ ! -d "$(DB_DIR)" ]; then \
		echo "📂 Creant directori Base de Dades: $(DB_DIR)"; \
		mkdir -p $(DB_DIR); \
	else \
		echo "✅ Directori Base de Dades ja existeix: $(DB_DIR)"; \
	fi

	@if [ ! -f "srcs/.env" ]; then \
		echo "📝 Copiant fitxer d'entorn des de $(ENV_SAMPLE)"; \
		cp $(ENV_SAMPLE) srcs/.env; \
	else \
		echo "✅ Fitxer d'entorn ja existeix: srcs/.env"; \
	fi

	@if [ ! -d "secrets" ]; then \
		echo "🔒 Creant directori de secrets"; \
		mkdir secrets; \
	else \
		echo "✅ Directori de secrets ja existeix"; \
	fi

	@if [ -d "$(HOME_DIR)/passwords" ]; then \
		echo "🔑 Movent fitxers de $(HOME_DIR)/passwords a secrets/"; \
		mv $(HOME_DIR)/passwords/* secrets/ 2>/dev/null || true; \
	else \
		echo "ℹ️  No s'ha trobat cap directori de passwords a $(HOME_DIR)/passwords"; \
	fi

	@echo "✨ Setup completat amb èxit!"

it:
	@if [ -z "$(ID)" ]; then \
		echo "❌ Has d'especificar un ID o nom de contenidor: make it ID=<container_id>"; \
		exit 1; \
	fi
	@echo "🚀 Obrint shell dins de contenidor '$(ID)'..."
	@$(DOCKER) exec -it $(ID) bash 2>/dev/null || $(DOCKER) exec -it $(ID) sh

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
	@$(COMPOSE) $(MANDATORY_PATH) down --volumes --remove-orphans
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
	@echo "make setup   → Construir i moure el necessari perque el projecte funcioni"
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
