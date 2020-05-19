#
# DemocracyOS Makefile
#

ifndef DEBUG
  DEBUG="democracyos*"
endif

ifndef NODE_ENV
  NODE_ENV="development"
endif

run: build
	@echo "Launching..."
	@DEBUG=$(DEBUG) npm run start

build: packages
	@echo "Building..."
	@npm run build

packages:
	@echo "Installing dependencies..."
	@npm install

docker:
	@echo "Starting DemocracyoOS docker development environment..."
	@docker-compose up app

clean:
	@echo "Removing dependencies, components and built assets..."
	@rm -rf node_modules public
	@echo "Done.\n"

prod-start:
	@echo "Starting app in production mode\n"
	@docker-compose -f production.yml up -d --remove-orphans
	@echo "Done.\n"

prod-stop:
	@echo "Stopping production app\n"
	@docker-compose -f production.yml kill
	@echo "Done.\n"

prod-clean:
	@echo "Cleaning production app containers\n"
	@docker-compose -f production.yml rm
	@echo "Done.\n"

.PHONY: clean docker
