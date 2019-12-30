# gohome

This is example of `/` "home" handler for microservices which display some meaningful information like `name`, `version`, `commit_full`, `build_time` and links to Swagger API description.

To display Swagger docs right from this service I'm using [Swagger UI](https://github.com/swagger-api/swagger-ui) and `Pet store` API example.

This example can be of course extended up to your needs 🙂

## Build

1. You might use either `-ldflags` or environment variables approach
    1. Build golang binary using `-ldflags` and overwriting variables in Go programm (`package.var_name`)
    ```bash
    $ go build -ldflags "\
        -X main.version=1.2.3 \
        -X main.commitFull=013fe2c2980c1237d8b6c521fc870cf1e0b46ae7 \
        -X main.buildTime=$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
        main.go
    ```
    2. Env variables - just to set `API_NAME`, `VERSION`, `COMMIT`, `BUILD_TIME` e.g. OSX `export API_NAME=my-awesome-app`
2. Run binary
    ```bash
    $ ./main
    ```

3. Open homepage
    ```bash
    $ curl --silent http://127.0.0.1:3000 | jq
      {
        "name": "my-awesome-app",
        "version": "1.2.3",
        "commit_full": "013fe2c2980c1237d8b6c521fc870cf1e0b46ae7",
        "build_time": "2019-11-23T16:49:02Z",
        "swagger_ui": "http://127.0.0.1:3000/swaggerui/",
        "swagger_yaml": "http://127.0.0.1:3000/v1.yaml"
      }
    ```


## Docker build and run

### Build
```docker build . -t gohome:0.1.0```

### Run
```docker run -it -p 3000:3000 --rm gohome:0.1.0```
