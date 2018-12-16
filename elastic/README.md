# yannoff/elastic

## ElasticSearch version 6.5.3 Alpine port

:warning: This is a Work-In-Progress

### Usage

Directions for use are exactly the same than [ElasticSearch official image](https://github.com/docker-library/docs/tree/master/elasticsearch).

### Build args

These version provides the following additional build args:

See [docker official documentation](https://docs.docker.com/engine/reference/builder/#arg) for more information about build args.

- `ES_VERSION` : Alternative version (defaults to `6.5.3`)
- `ES_HOME` : Home for Elastic Search (defaults to `/usr/share/elasticsearch`
- `ELASTICSEARCH_REPO` Alternative repository for ElasticSearch downloads (defaults to `https://artifacts.elastic.co/downloads/elasticsearch`)
- `UID` : ID for elasticsearch user (defaults to `9200`) 
- `GID` : ID for elasticsearch group (defaults to `9200`) 
- `ES_PLUGINS` : Space-separated list of additional plugins to be installeld at build time (defaults to `analysis-icu`)

### OSS/Full Version

To build the OSS version of ElasticSearch, set `ES_VERSION` build arg to `oss-6.5.3`, e.g:

```bash
docker build -t yannoff/elastic:6-oss --build-arg "ES_VERSION=oss-6.5.3" elastic/.

```

### Credits

This work is derived from [ElasticSearch version 5 Alpine image](https://github.com/docker-library/elasticsearch/blob/367769da361526411ffac12dae5fa19bb87c3f6c/5/alpine/Dockerfile) and highly inspired by the excellent [pires/docker-elasticsearch](https://github.com/pires/docker-elasticsearch) by [Paulo Pires](https://github.com/pires).
