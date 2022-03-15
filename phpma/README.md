# yannoff/phpma

A ready-to-use, fully working Alpine version of [PHPMyAdmin](https://github.com/phpmyadmin/docker/tree/master/fpm-alpine)

## Supported tags

- [5.1-fpm](Dockerfile)
, [5.1](Dockerfile)
, [latest](Dockerfile)

## Examples

Serve on guest machine port `3333`

```bash
docker run --name phpmyadmin --rm -d -p 3333:80 yannoff/phpma
```
