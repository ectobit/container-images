FROM golang:1.15.6-alpine AS builder

RUN apk add --no-cache gcc git musl-dev

RUN GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint && \
    go get golang.org/x/lint/golint

FROM golang:1.15.6-alpine

COPY --from=builder /go/bin/ /go/bin/

USER 65534
