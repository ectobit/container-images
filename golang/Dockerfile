FROM golang:1.17.0-alpine AS builder

RUN apk add --no-cache gcc git musl-dev

RUN GO111MODULE=on go get golang.org/x/lint/golint && \
    GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint

FROM golang:1.17.0-alpine

RUN apk add --no-cache make

COPY --from=builder /go/bin/ /go/bin/

USER 65534:65534
