FROM golang:1.17.2-alpine AS builder

RUN apk add --no-cache gcc git musl-dev && \
    go install golang.org/x/lint/golint@latest && \
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

FROM golang:1.17.2-alpine

RUN apk add --no-cache make

COPY --from=builder /go/bin/ /go/bin/

USER 65534:65534
