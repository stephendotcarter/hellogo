##
## Build
##
FROM golang:1.17-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY main.go ./

RUN CGO_ENABLED=0 go build -o /hellogo

##
## Deploy
##
FROM scratch

WORKDIR /

COPY --from=build /hellogo /hellogo

ENTRYPOINT ["/hellogo"]
