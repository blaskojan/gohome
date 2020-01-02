FROM golang:1.13 as builder

ARG version
ARG commitFull
ARG buildTime

COPY . /opt/gohome
WORKDIR /opt/gohome

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "\
  -X main.version=$version \
  -X main.commitFull=$commitFull \
  -X main.buildTime=$buildTime" \
  -o gohome \
  main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /opt/gohome
COPY --from=builder /opt/gohome/gohome .
COPY --from=builder /opt/gohome/api /opt/gohome/api
COPY --from=builder /opt/gohome/dist /opt/gohome/dist
# change runtime user to 9000 to not to be root
USER 9000
ENTRYPOINT ["./gohome"]
CMD [""]
