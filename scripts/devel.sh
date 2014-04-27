#!/usr/bin/env bash

set -e
source ./vars

# install packages necessary for development work

$GROUPINSTALL "Development Tools"
$INSTALL git gitg meld docker-io
sudo service docker restart
sudo usermod -aG "$USER" docker
echo Please log out and back in to apply your group membership in group docker.