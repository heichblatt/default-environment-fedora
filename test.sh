#!/usr/bin/env bash

set -e

# test the environment in a Docker container
TAG=heichblatt/test-default-environment-fedora

which docker >&1 >/dev/null
echo Building image.
time docker build -t "$TAG" .
echo Running tests in container.
time ID=$(docker run -i -t "$TAG")
exit 0