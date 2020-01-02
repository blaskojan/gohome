# gohome

This is example of `/` "home" handler for microservices which display some meaningful information like `name`, `version`, `commit_full`, `build_time` and links to Swagger API description.

To display Swagger docs right from this service I'm using [Swagger UI](https://github.com/swagger-api/swagger-ui) and `Pet store` API example.

This example can be of course extended up to your needs 🙂

## Build

1. Build golang binary
    ```bash
    $ docker build \
      --build-arg version="v4.4.4" \
      --build-arg commitFull="abc123" \
      --build-arg buildTime=$(date -u '+%Y-%m-%dT%H:%M:%SZ') \
      -t "gohome:latest" .
    ```
    Note: it's very convinient to use `--build-arg` since you can pass whatever info you want from CI pipeline.

2. Run binary
    ```bash
    $ docker run -it -p 3000:3000 --rm gohome:latest
    ```

3. Open homepage
    ```bash
    $ curl --silent http://127.0.0.1:3000 | jq
    {
      "name": "my-awesome-app",
      "version": "v4.4.4",
      "commit_full": "abc123",
      "build_time": "2020-01-02T14:59:51Z",
      "swagger_ui": "http://127.0.0.1:3000/swaggerui/",
      "swagger_yaml": "http://127.0.0.1:3000/v1.yaml"
    }
    ```
