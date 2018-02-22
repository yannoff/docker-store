# yannoff/gulp

An [Alpine Linux](https://alpinelinux.org/) image to run [gulp](https://gulpjs.com/) commands, especially background tasks like `watch`.

## Usage

### Usage standalone

#### Running gulp watch in the background

By default, the image is run invoking `watch` task.

```bash
docker run --rm -d --name gulp -v $(PWD):/src yannoff/gulp
```

which is equivalent to issuing:

```bash
docker run --rm -d --name gulp -v $(PWD):/src yannoff/gulp watch
```


> NOTE: The above example assumes a `gulpfile.js` is present in the current directory, and a `watch` task has been defined. If not, the container will stop and exit with a non-zero status.


#### Running a one-shot gulp task

For instance, to execute the `build:assets` task once:

```bash
docker run --rm --name gulp -v $(PWD):/src yannoff/gulp build:assets
```

### Usage in a stack

The integration in a stack is intended for the `watch` mode (default), which is the only task capable of holding the service up and running.


```yaml
#docker-compose.yml
gulp:
    image: yannoff/gulp
    volumes:
        - "./:/src"
```
