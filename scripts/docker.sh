#!/usr/bin/env bash

set -e
source ./vars

# install Docker

$INSTALL docker-io
$SUDO service docker restart
$SUDO usermod -a -G "$USER" docker
$SUDO systemctl enable docker
$SUDO systemctl restart docker
echo Please log out and back in to apply your group membership in group docker.