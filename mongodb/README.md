# yannoff/docker-store/mongodb

**WARNING: This is a WORK IN PROGRESS**

*This project has not been fully tested yet and can't be considered reliable at the moment.*

An Alpine Linux version of MongoDB server.

This is the source repository for [yannoff/mongodb](https://hub.docker.com/r/yannoff/mongodb/ "yannoff/mongodb on DockerHub") image on [DockerHub](https://hub.docker.com/).

This image aims to provide the same features as MongoDB official image. See [MongoDB official documentation](https://github.com/docker-library/docs/tree/master/mongo) for more details on how to use it.

## Usage 

Example use case:

- `./data` as persistent data directory
- `db` for the service name



### Usage standalone


```bash
docker run --rm -d --name db -v "$(pwd)/data":/data/db yannoff/mongodb
```



### Usage in a stack



```yaml
#docker-compose.yml
db:
    image: yannoff/mongodb
    volumes:
        - "./data:/data/db"
```
