FROM golang:1.14 as builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY Makefile /app
COPY pkg /app/pkg
COPY cmd /app/cmd
ARG COMMIT_SHA
RUN make

FROM alpine

COPY --from=builder /app/remote /usr/local/bin/remote
RUN chmod +x /usr/local/bin/remote

