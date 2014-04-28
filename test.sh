#!/usr/bin/env bash

set -e

# test the environment in a Docker container
TAG=heichblatt/test-default-environment-fedora

which docker >&1 >/dev/null
echo Building image.
docker build -t "$TAG" .
echo Running tests in container.
rm -rf ./CID
docker run -i -t --cidfile=./CID "$TAG"
exit $(docker logs -f $(cat CID))

rm -rf ./CID

trap "rm -f ./CID" SIGHUP SIGINT SIGTERM