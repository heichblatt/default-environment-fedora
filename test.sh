#!/usr/bin/env bash

set -e

# test the environment in a Docker container

TAG=heichblatt/test-default-environment-fedora

which docker >&1 >/dev/null || exit 1
docker build -t "$TAG" . && ID=$(docker run -d -i -t "$TAG")
echo Container is running.
echo Watch logs with: docker logs -f "$ID"