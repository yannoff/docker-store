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

- `ES_PLUGINS` : Additional plugins to be installeld at build time (defaults to `analysis-icu`) :warning: Not fully supported: multiple plugins install is not implemented yet
