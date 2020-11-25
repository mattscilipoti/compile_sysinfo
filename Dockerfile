# Compile sysinfo for CentOS/RHEL
# https://github.com/zcalusic/sysinfo
# see: http://www.matthiassommer.it/programming/compile-and-run-golang-executable-with-docker/
FROM golang:1 AS builder
LABEL maintainer="Matthew Scilipoti, mscilipoti@stsci.edu"

RUN ["go", "get", "github.com/zcalusic/sysinfo"]
WORKDIR /go/src/github.com/zcalusic/sysinfo/cmd/sysinfo

COPY docker_support/* ./