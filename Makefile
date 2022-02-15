postgres:
	sudo docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	sudo docker exec -it postgres12 createdb --username=root --owner=root simple_bank
dropdb:
	sudo docker exec -it postgres12 drop simple_bank

.PHONY: postgres createdb drop