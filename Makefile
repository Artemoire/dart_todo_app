export POSTGRES_DB_HOST ?= localhost
export POSTGRES_DB_PORT ?= 5432

build:
	@docker build -t todo_server -f todo_server/Dockerfile .

dev-server:	
	@dart run todo_server/bin/todo_server.dart

dev-db-up:
	@docker start temp_postgres || docker run --name temp_postgres -e POSTGRES_DB=postgres -e POSTGRES_USER=user -e POSTGRES_PASSWORD=pass -p 5432:5432 -d postgres:15-alpine

dev-db-down:
	@docker stop temp_postgres

dev-app:
	@cd todo_app && flutter run -d chrome --web-browser-flag "--disable-web-security"

dev-win:
	@$(MAKE) dev-db-up
	@start "" $(MAKE) dev-server
	@start "" $(MAKE) dev-app
