# yannoff/php

A leaf-weight PHP image based on Alpine.

## DISCLAIMER: This is a WORK IN PROGRESS

## Usage examples

### Run php-fpm as a service

#### Standalone

```bash
$ docker run --rm -p 9000:9000 yannoff/php:fpm
```

#### Stacked (using docker-compose)

```yml
# docker-compose.yml
fpm:
    image: yannoff/php:fpm
    volumes:
        - "./:/var/www/html"
    ports:
        - "9000:9000"
```

### Run a php command once

```bash
$ docker run --rm yannoff/php:latest -r "phpinfo();"
```

### Run php built-in development server

```bash
$ docker run --rm -p 8000:80 -v $PWD:/var/www/html yannoff/php:latest -S 0.0.0.0:80 -t ./
```
