# A Simple Bank

- Create and manager account (owner, balance, currency)
- Record all balance changes
- Money transfer transaction

## Database design

- Design a SQL DB schema using dbdiagram.io
- Save and share DB diagram
- Generate SQL code

## 2 - Install Docker, DB

2.1 Install Docker

- Pull an image

```shell
    docker pull <image>:<tag>
```

2.2 Run Postgres container

- Start a container

```shell
    #explain
    docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
    # --name tag: name of container
    # -e tag: environment variable for container. Using password to connect to postgres
    # -d tag: to tell Docker to run this container in background
    # postgres: name of postgres images
    # -p tag: port mapping: <host_port:container_port>: bridge between localhost network and container network. 2 port don't necessary same. 5432 is port of postgres in docker

    docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
    # if success, returns this ID
```

- Postgres server is ready

- Run command in container

```shell
    docker exec -it <container_name_or_id> <command> [args]
    #command psql to access postgres control
    # -U tag: to tell psql connect to root user

    docker exec -it postgres12 psql -U root
```

- View container logs

```shell
    docker logs postgres12
```

- A password is not required when connecting from localhost

- CLI in docker container

```shell
    docker exec -it postgres12 /bin/sh
```

2.3 Install Table plus

- Table Plus is GUI tool can talk to many database engines

- Create DB Schema

## 3 - DB MIGRATION

- The up-script is run to make a forward change to the schema
- The down-script is run if we want revert the change made by the up-script
- When run "migrate up" command, up-script file in db/migrate folder will be run sequentially by the order of their prefix version 1->2->3
- On the contrary, "migrate down" 3->2->1

```shell
    migrate create -ext sql -dir db/migration -seq init_schema
    # -ext tag: extensioin
    # -dir tag: follow directory for store it
    # -sed tag: q sequential version number of the migrate file
```

```shell
    #
   	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
```

- "schema_migrations" stores the latest applied migrate version
- dirty column tells us if the last migrate has failed or not

## 4 - CRUD

### 4.1 - What is CRUD

- Create: insert new records to database
- Read: select of search fro records in the database
- Update: change some fields of the record in the database
- Detele: delete records

### 4.1 CURD in Golang
- Using package "database/sql"
    - Fast & straightforward
    - Manual mapping SQL fields to variables
    - Easy to make mistakes
- Using package "GORM"
    - Short code (only need declare the models adn call the functions that gorm provides)
    - Must learn  to write querries using gorm's function
    - run slowly on high load
=> people are switching to middle-way approach
- Using "SQLX" library
    - Quite fast & easy to use
    - Fields mapping via querry text & struct tags
- Using "SQLC"
    - very fast & easy to code
    - Automatic code generation (golang crud codes will be automatically generated for us)
    - Catch SQL query error before generate codes
    - full support Postgres
    - "sqlc.dev": sudo snap install sqlc
    - run "sqlc init"

## 5 - Unit test 

## 6 - 