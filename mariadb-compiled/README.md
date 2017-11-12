# yannoff/docker-store/mariadb-compiled

## THIS IS A WORK-IN-PROGRESSS, PLEASE DON'T USE IT

An image based on latest Alpine Linux, with edge MariaDB server installed.

This is the source repository for [yannoff/mariadb](https://hub.docker.com/r/yannoff/mariadb/ "yannoff/mariadb on DockerHub") image on [DockerHub](https://hub.docker.com/).

This image supports the [exact same features](https://github.com/docker-library/docs/blob/master/mariadb/README.md "MariaDB Official image documentation") as the original MariaDB image (except for TokuDB plugin which is not supported yet by Alpine Linux).

## Usage 

Example use case:

- `xxxx` as root (i.e admin) password for MariaDB.
- `3307` as exposed port on host machine
- `./data` as persistent data directory
- `db` for the service name

### Usage standalone


```bash
docker run --rm -d --name db -e MYSQL_ROOT_PASSWORD=xxxx -p "3306:3306" -v "$(PWD)/data":/var/lib/mysql yannoff/mariadb
```

### Usage in a stack

```yaml
#docker-compose.yml
db:
    image: yannoff/mariadb
    environment:
        MYSQL_ROOT_PASSWORD: xxxx
    volumes:
        - "./data:/var/lib/mysql"
    ports:
        - "3307:3306"
```
