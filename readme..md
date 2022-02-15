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


3.1.
