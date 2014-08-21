#!/usr/bin/env bash

set -e

# test the environment in a Docker container
TAG=heichblatt/test-default-environment-fedora

which docker >&1 >/dev/null
echo Building image.
docker build -t "$TAG" .
echo Running tests in container.
rm -rf ./CID
docker run --cidfile=./CID "$TAG"
docker logs -f $(cat CID)
retval=$?
rm -rf ./CID
exit $retval

trap "rm -f ./CID" SIGHUP SIGINT SIGTERM
